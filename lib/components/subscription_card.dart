import 'package:deplan_subscriptions_client/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';

class SubscriptionCard extends StatelessWidget {
  final String appName;
  final double planPrice;
  final double userPays;
  final double usagePercentage;
  final String avatar;
  final bool isEmpty;

  SubscriptionCard({
    super.key,
    required this.appName,
    required this.planPrice,
    required this.userPays,
    required this.usagePercentage,
    required this.avatar,
    this.isEmpty = false,
  });

  final ValueNotifier<double> _valueNotifier = ValueNotifier(37.0);

  @override
  Widget build(BuildContext context) {
    // final ValueNotifier<double> valueNotifier = ValueNotifier(usagePercentage);

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xffE9E9EE).withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 5))
              ],
            ),
            child: isEmpty
                ? Icon(
                    null,
                    color: const Color(0xff11243E).withOpacity(0.4),
                    size: 60,
                  )
                : Image.network(
                    avatar,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEmpty ? 'App' : appName,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff11243E).withOpacity(0.85),
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Plan price',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            isEmpty
                                ? '--'
                                : '\$${planPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 20,
                              color: const Color(0xff11243E).withOpacity(0.4),
                              fontFamily: 'SF Pro Display',
                              fontWeight: FontWeight.w500,
                              decoration:
                                  isEmpty ? null : TextDecoration.lineThrough,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 30),
                      Column(
                        children: [
                          const Text(
                            'You pay',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            isEmpty ? '--' : '\$${userPays.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'SF Pro Display',
                              color: TEXT_MAIN,
                              fontWeight:
                                  isEmpty ? FontWeight.normal : FontWeight.w700,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 70,
            height: 70,
            child: DashedCircularProgressBar.aspectRatio(
              aspectRatio: 1, // width ÷ height
              valueNotifier: _valueNotifier,
              progress: usagePercentage * 100,
              startAngle: 240,
              sweepAngle: 240,
              foregroundColor: const Color(0xff00ADED),
              backgroundColor: const Color.fromARGB(255, 179, 158, 196),
              foregroundStrokeWidth: 8,
              backgroundStrokeWidth: 8,
              animation: true,
              seekSize: 5,
              maxProgress: 100.0,
              seekColor: Colors.white,
              child: ValueListenableBuilder(
                valueListenable: _valueNotifier,
                builder: (context, value, child) => Column(
                  children: [
                    const Text(''),
                    Text(
                      isEmpty ? '--%' : '${value.toInt()}%',
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w800,
                        color: Color(0xff874AB6),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        'Usage',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xff874AB6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
