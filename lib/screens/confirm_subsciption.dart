import 'package:flutter/material.dart';

class ConfirmSubsciption extends StatelessWidget {
  const ConfirmSubsciption({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Subscription'),
      ),
      body: const Center(
        child: Text(
          'Confirm Subscription!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
