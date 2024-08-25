import 'package:deplan_subscriptions_client/components/screen_wrapper.dart';
import 'package:deplan_subscriptions_client/components/screens_content/sign_in.dart';
import 'package:flutter/material.dart';

class Signin extends StatelessWidget {
  const Signin({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return const ScreenWrapper(
      child: SignInBody(),
    );
  }
}
