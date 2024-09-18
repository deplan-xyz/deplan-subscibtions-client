import 'package:deplan_subscriptions_client/api/common_api.dart';
import 'package:deplan_subscriptions_client/components/months_selector.dart';
import 'package:deplan_subscriptions_client/components/screen_wrapper.dart';
import 'package:deplan_subscriptions_client/components/subscription_card.dart';
import 'package:deplan_subscriptions_client/constants/routes.dart';
import 'package:deplan_subscriptions_client/models/subscription.dart';
import 'package:deplan_subscriptions_client/screens/subscription_details.dart';
import 'package:deplan_subscriptions_client/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SubsciptionsHome extends StatefulWidget {
  const SubsciptionsHome({super.key});

  @override
  State<SubsciptionsHome> createState() => _SubsciptionsHomeState();
}

class _SubsciptionsHomeState extends State<SubsciptionsHome> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    // Simulate a condition: Show the bottom sheet after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      // make an api call to get the data
      _showPaymentBottomSheet(false);
    });
  }

  _showPaymentBottomSheet(bool showPaymentBottomSheet) {
    if (showPaymentBottomSheet) {
      _showBottomSheet(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Padding(
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
                      onPressed: () {
                        if (mounted) {
                          Navigator.pushNamed(context, Routes.settings);
                        }
                      },
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
                  initialDate: selectedDate,
                  onChange: (month, date) {
                    setState(() {
                      selectedDate = date!;
                    });
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
            // scrolled list with SubscriptionCard elements
            const SizedBox(height: 16),
            Expanded(
              flex: 1,
              child: FutureBuilder<List<Subscription>>(
                future: api.listSubscriptions(DateTime(selectedDate.year,
                        selectedDate.month, selectedDate.day + 1)
                    .millisecondsSinceEpoch),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        "You don't have any subscription yet",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }

                  final subscriptions = snapshot.data!;
                  return ListView.builder(
                    itemCount: subscriptions.length,
                    itemBuilder: (context, index) {
                      final subscription = subscriptions[index];
                      return SubscriptionCard(
                        title: subscription.name,
                        planPrice: subscription.planPrice,
                        userPays: subscription.youPay,
                        usagePercentage: subscription.usage,
                        avatar: subscription.logo,
                        orgId: subscription.orgId,
                        onTap: (subscription) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubscriptionDetails(
                                subscriptionData: subscription,
                                selectedDate: selectedDate,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allow the bottom sheet to take full width
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
    ),
    isDismissible: false,
    sheetAnimationStyle: AnimationStyle(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ),
    builder: (BuildContext context) {
      return buildBottomSheet(context);
    },
  );
}

Widget buildBottomSheet(BuildContext context) {
  return Padding(
    padding: MediaQuery.of(context).viewInsets,
    child: Container(
      padding: const EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "You save \$42.22 this month",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            onPressed: () {},
            child: const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Pay ",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$55.94",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  "\$13.72",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    ),
  );
}
