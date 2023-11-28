import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  void createUserWithEmailAndPassword(
      String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

//signing in a user with a password
  Future<String?> signInWithEmailAndPassword(
      String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      return null; // No error
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'The provided Email is not valid.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password.';
      }
      return 'An error occurred'; // Generic error message
    } catch (e) {
      return 'An unexpected error occurred';
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
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
    final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

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
    // You can also show an error message to the user if needed
    // For example: showErrorMessage("Google Sign-In Failed");
    return null; // Return null to indicate failure
  } catch (error) {
    // Handle other exceptions
    print("Unexpected error: $error");
    return null; // Return null to indicate failure
  }
}


}
