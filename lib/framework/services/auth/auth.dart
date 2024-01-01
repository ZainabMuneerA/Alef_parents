import 'dart:io';

import 'package:alef_parents/framework/shared_prefrences/UserPreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../notifications/notifications.dart';

class Auth {
  final secureStorage = FlutterSecureStorage();

  Future<String?> createUserWithEmailAndPassword(
      String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      // Save data
      await secureStorage.write(key: 'userID', value: credential.user!.uid);
      await secureStorage.write(
          key: 'username', value: credential.user!.displayName);

      return null; // No error
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return 'An error occurred'; // Generic error message
    } catch (e) {
      return 'An unexpected error occurred';
    }
  }

//signing in a user with a password
  Future<String?> signInWithEmailAndPassword(
      String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          IdTokenResult tokenResult = await user.getIdTokenResult(true);

          Map<String, dynamic>? customClaims = tokenResult.claims;
          // Accessing dbId directly
          final dbid = customClaims?['dbId'];

          //saving the data
          await UserPreferences.saveEmail(credential.user!.email ?? '');
          await UserPreferences.saveUsername(
              credential.user!.displayName ?? '');
          await UserPreferences.saveUserId(dbid ?? 0);

          if (Platform.isAndroid) {
            await Notifications().initiNorification(credential.user!.uid);
          }
        } catch (e) {
          print("Error accessing custom claims: $e");
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'The provided Email is not valid.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password.';
      } else if (e.code == 'invalid-login-credentials') {
        return 'invalid login credentials';
      }
      return 'An error occurred $e';
    } catch (e) {
      return 'An unexpected error occurred';
    }
  }

  // Save data
  // await UserPreferences.saveEmail(credential.user!.email ?? '');
  // await UserPreferences.saveUsername(credential.user!.displayName ?? '');

//sign out
 Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
  await SharedPreferences.getInstance().then((prefs) => prefs.clear());
}

  //?google sevices ?? do i need this??

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Check if the user canceled the sign-in process
      if (googleUser == null) {
        print("Google Sign-In canceled by the user.");
        return null; // Return null to indicate failure
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (error) {
      // Handle FirebaseAuthException
      print("Firebase Auth Exception: $error");
      return null; // Return null to indicate failure
    } catch (error) {
      // Handle other exceptions
      print("Unexpected error: $error");
      return null; // Return null to indicate failure
    }
  }
//* example

// final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
// final User? user = userCredential.user;

// if (user != null) {
//   // Access user information
//   String uid = user.uid;
//   String displayName = user.displayName ?? "";
//   String email = user.email ?? "";

//   // Save data to secure storage or other storage mechanisms
//   await secureStorage.write(key: 'userID', value: uid);
//   await secureStorage.write(key: 'username', value: displayName);
// }
}
