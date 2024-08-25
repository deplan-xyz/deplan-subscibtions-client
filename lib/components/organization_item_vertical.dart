import 'package:deplan_subscriptions_client/theme/app_theme.dart';
import 'package:flutter/material.dart';

class OrganizationItemVertical extends StatelessWidget {
  // constructor should get an organization name, organization logo url, subscribtion price, organization name, organization website
  final String organizationName;
  final String organizationLogoUrl;
  final String subscriptionPrice;
  final String organizationWebsite;

  const OrganizationItemVertical({
    super.key,
    required this.organizationName,
    required this.organizationLogoUrl,
    required this.subscriptionPrice,
    required this.organizationWebsite,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          organizationLogoUrl,
          width: 85,
          height: 85,
        ),
        const SizedBox(width: 15),
        Text(
          organizationName,
          style: const TextStyle(
            fontSize: 24,
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          organizationWebsite,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'SF Pro Display',
            color: TEXT_SECONDARY_ACCENT,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          subscriptionPrice,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            fontFamily: 'SF Pro Display',
            color: TEXT_SECONDARY,
          ),
        ),
      ],
    );
  }
}
