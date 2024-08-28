import 'package:flutter/material.dart';
import 'package:deplan_subscriptions_client/constants/routes.dart';

class AppEntryPoint extends StatelessWidget {
  const AppEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Entry Point'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 20, 20, 70),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
                'On this screen we will check the auth and if user authenticated - will be redirected to the dashboard screen of not - SignIn screen'),
            const SizedBox(height: 20),
            const Text(
                'If user signed In but came from the outside for the subscription - redirect to the confirm_subscription screen'),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.signin);
                  },
                  child: const Text('Sign In'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.subscriptionsHome);
                  },
                  child: const Text('Subsciptions'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.confirmSubscription);
                  },
                  child: const Text('Confirm Subscription'),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
