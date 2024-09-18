import 'package:deplan_subscriptions_client/api/common_api.dart';
import 'package:deplan_subscriptions_client/components/months_selector.dart';
import 'package:deplan_subscriptions_client/components/screen_wrapper.dart';
import 'package:deplan_subscriptions_client/components/subscription_card.dart';
import 'package:deplan_subscriptions_client/constants/routes.dart';
import 'package:deplan_subscriptions_client/models/payment_info.dart';
import 'package:deplan_subscriptions_client/models/subscription.dart';
import 'package:deplan_subscriptions_client/screens/subscription_details.dart';
import 'package:deplan_subscriptions_client/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SubsciptionsHome extends StatefulWidget {
  const SubsciptionsHome({super.key});

  @override
  State<SubsciptionsHome> createState() => _SubsciptionsHomeState();
}

class _SubsciptionsHomeState extends State<SubsciptionsHome> {
  DateTime selectedDate = DateTime.now();
  late String paymentLink;

  @override
  void initState() {
    super.initState();

    api.getPaymentLink().then((_paymentlink) {
      setState(() {
        paymentLink = _paymentlink;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
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
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: FutureBuilder<List<Subscription>>(
                      future: api.listSubscriptions(DateTime(selectedDate.year,
                              selectedDate.month, selectedDate.day + 1)
                          .millisecondsSinceEpoch),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Column(
                            children: [
                              SubscriptionCard(
                                isEmpty: true,
                                title: 'No subscriptions',
                                planPrice: 0,
                                userPays: 0,
                                usagePercentage: 0,
                                avatar: 'assets/icons/no_subscriptions.png',
                                orgId: 'no_org_id',
                                onTap: (subscription) {},
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "You don't have any subscription yet",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
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
                  FutureBuilder(
                      future: api.getPaymentInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('');
                        }

                        if (snapshot.hasError) {
                          return const Text('');
                        }

                        return snapshot.data!.paymentInfo.youPay > 0.5
                            ? buildBottomSheet(context,
                                snapshot.data!.paymentInfo, paymentLink)
                            : Container();
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildBottomSheet(
    BuildContext context, PaymentInfo paymentInfo, String? paymentLink) {
  return Container(
    decoration: const BoxDecoration(
      color: Color(0xffffffff),
    ),
    child: Container(
      padding: const EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "You save \$${paymentInfo.fullPrice - paymentInfo.youPay} this month",
            style: const TextStyle(
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
            onPressed: () async {
              try {
                if (paymentLink != null) {
                  await launchUrl(Uri.parse(paymentLink));
                } else {
                  print('Paymment link is not defined');
                }
              } catch (e) {
                print('Error when requesting payment link: $e');
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Pay ",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$${paymentInfo.fullPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "\$${paymentInfo.youPay.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
