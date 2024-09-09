import 'package:deplan_subscriptions_client/components/organization_item_vertical.dart';
import 'package:deplan_subscriptions_client/components/screen_wrapper.dart';
import 'package:deplan_subscriptions_client/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConfirmSubsciption extends StatelessWidget {
  final String orgId;

  const ConfirmSubsciption({super.key, required this.orgId});

  @override
  Widget build(BuildContext context) {
    print('OrgId: $orgId');
    final user = FirebaseAuth.instance.currentUser;
    return ScreenWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Image.asset('assets/images/DePlan_Logo Blue.png'),
            ),
          ),
          const SizedBox(height: 45),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 250),
            child: const Text('Confirm to subscribe with DePlan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: TEXT_MAIN,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w700,
                )),
          ),
          const SizedBox(height: 50),
          const OrganizationItemVertical(
            organizationName: 'Justdoiter',
            subscriptionPrice: '9.99\$/mo',
            organizationWebsite: 'justdoiter.live',
            organizationLogoUrl:
                'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
          ),
          const SizedBox(height: 35),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: const Text(
              'This price is the cap and you never pay more. You will see how much to pay at the end of the month.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'SF Pro Display',
                color: TEXT_SECONDARY,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Spacer(),
          Column(
            children: [
              const Text(
                "Your DePlan account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'SF Pro Display',
                  color: TEXT_SECONDARY,
                ),
              ),
              Text(
                user?.email ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'SF Pro Display',
                  color: COLOR_BLACK,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text("Confirm and Subscribe"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
