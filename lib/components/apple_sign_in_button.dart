import 'package:deplan_subscriptions_client/api/auth.dart';
import 'package:deplan_subscriptions_client/constants/routes.dart';
import 'package:deplan_subscriptions_client/utilities/error_handlers.dart';
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
          print('AppleSignInButton: Error signing in with apple: $e');
          if (context.mounted) {
            shouwAuthErrorDialog(context: context, error: e);
          }
        }
      },
      label: const Text('Sign In with Apple'),
      icon: const Icon(Icons.apple),
    );
  }
}
