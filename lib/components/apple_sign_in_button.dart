import 'package:deplan_subscriptions_client/api/auth.dart';
import 'package:deplan_subscriptions_client/constants/routes.dart';
import 'package:deplan_subscriptions_client/models/subscription_query_data.dart';
import 'package:deplan_subscriptions_client/screens/confirm_subsciption.dart';
import 'package:deplan_subscriptions_client/utilities/error_handlers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppleSignInButton extends StatelessWidget {
  final SubscriptionQueryData? subscriptionQueryData;
  const AppleSignInButton({super.key, this.subscriptionQueryData});

  @override
  Widget build(BuildContext context) {
    navigateToSubscriptionsHome(SubscriptionQueryData? subscriptionQueryData) {
      if (subscriptionQueryData != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmSubsciption(
                    subscriptionQueryData: subscriptionQueryData)));
      } else {
        Navigator.pushNamed(context, Routes.subscriptionsHome);
      }
    }

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
      onPressed: () async {
        try {
          await Auth.signInWithApple();
          navigateToSubscriptionsHome(subscriptionQueryData);
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
