import 'package:flutter/material.dart';
import 'package:deplan_subscriptions_client/constants/routes.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.signin);
          },
          child: const Text('Sign In'),
        ),
      ),
    );
  }
}
