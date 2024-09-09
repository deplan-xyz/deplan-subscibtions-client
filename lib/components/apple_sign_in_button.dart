import 'package:deplan_subscriptions_client/api/auth.dart';
import 'package:deplan_subscriptions_client/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    navigateToSubscriptionsHome() {
      Navigator.pushNamed(context, Routes.subscriptionsHome);
    }

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
      onPressed: () async {
        try {
          await Auth.signInWithApple();
          navigateToSubscriptionsHome();
        } on FirebaseAuthException catch (e) {
          print(e.code);
          print(e.message);
        }
      },
      label: const Text('Sign In with Apple'),
      icon: const Icon(Icons.apple),
    );
  }
}
