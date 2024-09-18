import 'package:deplan_subscriptions_client/components/day_grid.dart';
import 'package:deplan_subscriptions_client/components/screen_wrapper.dart';
import 'package:deplan_subscriptions_client/components/subscription_card.dart';
import 'package:deplan_subscriptions_client/models/subscription.dart';
import 'package:deplan_subscriptions_client/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SubscriptionDetails extends StatelessWidget {
  final Subscription subscriptionData;
  final DateTime selectedDate;

  const SubscriptionDetails(
      {super.key, required this.subscriptionData, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      showAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the default back button
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 28,
              height: 28,
              child: Image.network(
                subscriptionData.logo!,
                width: 100,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              subscriptionData.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      child: Column(
        children: [
          SubscriptionCard(
            // month and year in format: January 2022
            title: DateFormat.yMMMM().format(selectedDate),
            backgroundColor: const Color(0xffffffff),
            titleStyle: const TextStyle(
              fontSize: 30,
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w700,
              color: TEXT_MAIN,
            ),
            planPrice: subscriptionData.planPrice,
            userPays: subscriptionData.youPay,
            orgId: subscriptionData.orgId,
            usagePercentage: subscriptionData.usage,
          ),
          Flexible(
            child: DayGrid(
              date: selectedDate,
              subscriptionData: subscriptionData,
            ),
          ),
        ],
      ),
    );
  }
}
