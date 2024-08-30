import 'package:deplan_subscriptions_client/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    Future<UserCredential> signInWithApple() async {
      final appleProvider = OAuthProvider("apple.com")
        ..addScope('email')
        ..addScope('name');

      if (kIsWeb) {
        print('web');
        return await FirebaseAuth.instance.signInWithPopup(appleProvider);
      } else {
        print('mobile');
        return await FirebaseAuth.instance.signInWithProvider(appleProvider);
      }
    }

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
      onPressed: () async {
        try {
          final credentials = await signInWithApple();
          print({
            'user': credentials.user,
            'additionalUserInfo': credentials.additionalUserInfo,
          });
          // go to subscriptions home route
          Navigator.pushNamed(context, Routes.subscriptionsHome);
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
