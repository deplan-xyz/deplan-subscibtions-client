import 'package:deplan_subscriptions_client/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SubsciptionsHome extends StatelessWidget {
  const SubsciptionsHome({super.key});

  @override
  Widget build(BuildContext context) {
    final userCredentials = FirebaseAuth.instance.currentUser;
    final isAuthenticated = userCredentials != null;
    final username = userCredentials?.displayName ?? 'User';
    final email = userCredentials?.email ?? 'Email';

    navigateToRoot() {
      Navigator.of(context).pushReplacementNamed(Routes.signin);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subsciptions Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This is the Subsciptions Home screen',
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isAuthenticated
                      ? 'User: $username is authenticated \n with email: $email'
                      : 'User is not authenticated',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: isAuthenticated
                          ? Colors.greenAccent
                          : Colors.redAccent),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                navigateToRoot();
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
