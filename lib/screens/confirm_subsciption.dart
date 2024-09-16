import 'package:deplan_subscriptions_client/api/auth.dart';
import 'package:deplan_subscriptions_client/api/common_api.dart';
import 'package:deplan_subscriptions_client/components/organization_item_vertical.dart';
import 'package:deplan_subscriptions_client/components/screen_wrapper.dart';
import 'package:deplan_subscriptions_client/constants/routes.dart';
import 'package:deplan_subscriptions_client/models/organization.dart';
import 'package:deplan_subscriptions_client/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfirmSubsciption extends StatefulWidget {
  final String orgId;
  final String redirectUrl;
  final String data;

  const ConfirmSubsciption(
      {super.key,
      required this.orgId,
      required this.redirectUrl,
      required this.data});

  @override
  State<ConfirmSubsciption> createState() => _ConfirmSubsciptionState();
}

class _ConfirmSubsciptionState extends State<ConfirmSubsciption> {
  // if user is not authenticated, call Auth.signInWithApple method
  @override
  void initState() {
    super.initState();
  }

  _loginIfNeeded() async {
    if (FirebaseAuth.instance.currentUser == null) {
      try {
        await Auth.signInWithApple();
      } catch (e) {
        _navigateToSignIn();
      }
    }
  }

  Future<Organization> getOrganizationById() async {
    final organization = await api.getOrganizationById(widget.orgId);
    print('Getting organization by id: ${organization.toString()}');

    return organization;
  }

  _navigateToSignIn() {
    Navigator.pushNamedAndRemoveUntil(context, Routes.signin, (route) => false);
  }

  _launchCallbackUrl(String url) async {
    if (kIsWeb) {
      await launchUrl(Uri.parse(url));
    }
  }

  _navigateToSubscriptionsHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.subscriptionsHome, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
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
          FutureBuilder(
            future: getOrganizationById(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const OrganizationItemVerticalSkeleton();
              }
              return OrganizationItemVertical(
                organizationName: snapshot.data!.name,
                subscriptionPrice:
                    snapshot.data!.settings.pricePerMonth.toString(),
                organizationWebsite: '',
                organizationLogoUrl: snapshot.data!.logo,
              );
            },
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
                  onPressed: () async {
                    await _loginIfNeeded();
                    var response = await api.confirmSubscription(
                        widget.orgId, widget.data);
                    _launchCallbackUrl(widget.redirectUrl);
                    _navigateToSubscriptionsHome();
                  },
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
