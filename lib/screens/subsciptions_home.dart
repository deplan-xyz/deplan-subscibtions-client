import 'package:deplan_subscriptions_client/components/months_selector.dart';
import 'package:deplan_subscriptions_client/components/subscription_card.dart';
import 'package:deplan_subscriptions_client/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SubsciptionsHome extends StatelessWidget {
  const SubsciptionsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with logo and icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Image.asset('assets/images/DePlan_Logo Black.png'),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: SizedBox(
                        width: 25,
                        height: 25,
                        child: Image.asset('assets/icons/gear_icon.png'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Time period selector
            SizedBox(
              height: 40,
              width: double.infinity,
              child: MonthSelector(
                  initialDate: DateTime.now(),
                  onChange: (month, date) {
                    print(month);
                    print(date);
                  }),
            ),
            const SizedBox(height: 24),
            // Title
            const Text(
              "Usage of your subscriptions",
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w600,
                color: TEXT_MAIN,
              ),
            ),
            // Empty state message
            SubscriptionCard(
              appName: 'App',
              planPrice: 0,
              userPays: 0,
              usagePercentage: 0,
              avatar: '',
              isEmpty: true,
            ),
            const SizedBox(
              height: 45,
            ),
            const Center(
              child: Text(
                "You don’t have any subscription yet",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
