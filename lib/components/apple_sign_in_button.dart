import 'package:deplan_subscriptions_client/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    Future<UserCredential> signInWithApple() async {
      final appleProvider = AppleAuthProvider();
      appleProvider.addScope('email');
      appleProvider.addScope('name');
      print(appleProvider.scopes);
      if (kIsWeb) {
        return await FirebaseAuth.instance.signInWithPopup(appleProvider);
      } else {
        return await FirebaseAuth.instance.signInWithProvider(appleProvider);
      }
    }

    return SignInWithAppleButton(
      onPressed: () async {
        try {
          final credentials = await signInWithApple();
          print(credentials.toString());
          // go to subscriptions home route
          Navigator.pushNamed(context, Routes.subscriptionsHome);
        } on FirebaseAuthException catch (e) {
          print(e.code);
          print(e.message);
        }
      },
    );
  }
}
