import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SubsciptionsHome extends StatelessWidget {
  const SubsciptionsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subsciptions Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This is the Subsciptions Home screen'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // Navigate to root
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
