import 'dart:io';

import 'package:alef_parents/framework/shared_prefrences/UserPreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../notifications/notifications.dart';

class Auth {
  final secureStorage = const FlutterSecureStorage();

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
        IdTokenResult tokenResult = await user.getIdTokenResult(true);

        Map<String, dynamic>? customClaims = tokenResult.claims;
        // Accessing dbId directly
        final dbid = customClaims?['dbId'];

        //saving the data
        await UserPreferences.saveEmail(credential.user!.email ?? '');
        await UserPreferences.saveUsername(credential.user!.displayName ?? '');
        await UserPreferences.saveUserId(dbid ?? 0);
        await UserPreferences.saveToken(tokenResult.token ?? '');

        if (Platform.isAndroid) {
          await Notifications().initiNorification(credential.user!.uid);
        }
      } else {
        return 'Please try again';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'The provided Email is not valid.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password.';
      } else if (e.code == 'invalid-login-credentials') {
        // Access the more detailed error information provided by Firebase
        if (e.message != null && e.message!.isNotEmpty) {
          return 'Invalid login credentials: ${e.message}';
        } else if (e.credential?.providerId == 'password') {
          return 'Invalid login credentials: Please check your email and password.';
        } else {
          return 'Invalid login credentials.';
        }
      }
      return 'Error: ${e.message}';
    } catch (e) {
      return 'An unexpected error occurred: $e';
    }
    return null;
  }

//sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await SharedPreferences.getInstance().then((prefs) => prefs.clear());
  }

  Future<bool> checkToken() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        IdTokenResult tokenResult = await user.getIdTokenResult(true);

        Map<String, dynamic>? decodedToken =
            JwtDecoder.decode(tokenResult.token!);

        if (decodedToken != null && decodedToken['exp'] != null) {
          int expirationTimeInSeconds = decodedToken['exp'];
          int currentTimeInSeconds =
              DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
          print(currentTimeInSeconds);
          return expirationTimeInSeconds >= currentTimeInSeconds;
        }
      }
    } catch (e) {
      print('Error during checkToken: $e');
    }

    // Return false in case of an error or if the token is not valid
    return false;
  }



  //?google sevices

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
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
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
}


class AuthenticationUtils {
  static Future<String?> getUserToken() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        IdTokenResult tokenResult = await user.getIdTokenResult(true);
        return tokenResult.token;
      } else {
        return null; // Return null if user is not authenticated
      }
    } catch (e) {
      print('Error fetching user token: $e');
      return null;
    }
  }
}