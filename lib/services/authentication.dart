import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> registerAndSendVerificationEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification
      await userCredential.user!.sendEmailVerification();
    } catch (e) {
      // Handle registration errors
      throw e;
    }
  }

  static Future<void> signInAfterVerification({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential signInCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (signInCredential.user != null &&
          signInCredential.user!.emailVerified) {
        // Navigate to appropriate page after successful sign-in
        // This could be the home page or a form page
      } else {
        // Show alert dialog for email not verified
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Email Not Verified'),
              content: const Text('Please verify your email to log in.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle sign-in errors
      throw e;
    }
  }
}
