import 'package:deplan_subscriptions_client/components/apple_sign_in_button.dart';
import 'package:deplan_subscriptions_client/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Image.asset('assets/images/DePlan_Logo Blue.png'),
          ),
        ),
        const SizedBox(height: 30),
        Expanded(child: Image.asset('assets/images/subsription-logo.png')),
        const SizedBox(height: 30),
        Text(
          "Pay for how much you actually use your subscriptions",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Control all your subscriptions in one place",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'SF Pro Display',
                  color: TEXT_SECONDARY,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 52,
                child: const AppleSignInButton(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
