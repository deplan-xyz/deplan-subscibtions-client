import 'package:deplan_subscriptions_client/api/auth.dart';
import 'package:deplan_subscriptions_client/components/screen_wrapper.dart';
import 'package:deplan_subscriptions_client/constants/routes.dart';
import 'package:deplan_subscriptions_client/screens/confirm_subsciption.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppInitController extends StatefulWidget {
  const AppInitController({super.key});

  @override
  State<AppInitController> createState() => _AppInitControllerState();
}

class _AppInitControllerState extends State<AppInitController> {
  String? _orgId;
  String? _redirectUrl;
  String? _data;

  @override
  void initState() {
    super.initState();
    _handleQueryParameters();
  }

  Future<void> _initAuth(BuildContext ctx) async {
    await _signInWithAppleIfNeeded(ctx);
    _navigateToConfirmSubscription(ctx);
  }

  _signInWithAppleIfNeeded(BuildContext ctx) async {
    if (!Auth.isUserAuthenticated) {
      await Auth.signInWithApple();
    }
  }

  void _handleQueryParameters() {
    // Get the current URL
    final Uri uri = Uri.base;

    // Access query parameters
    final Map<String, String> queryParams = uri.queryParameters;

    // Process query parameters
    String? orgId = queryParams['orgId'];
    String? redirectUrl = queryParams['redirectUrl'];
    String? data = queryParams['data'];

    // You can decode the JSON data if necessary
    if (data != null) {
      setState(() {
        _orgId = orgId;
        _redirectUrl = redirectUrl;
        _data = data;
      });
    }
  }

  _navigateToSubscriptionsHome(BuildContext ctx) {
    return Navigator.pushReplacementNamed(ctx, Routes.subscriptionsHome);
  }

  _navigateToConfirmSubscriptionPage(BuildContext ctx) {
    return Navigator.pushReplacement(
      ctx,
      MaterialPageRoute(
        builder: (context) => ConfirmSubsciption(
          orgId: _orgId!,
          redirectUrl: _redirectUrl!,
          data: _data!,
        ),
      ),
    );
  }

  _navigateToConfirmSubscription(BuildContext ctx) {
    final shouldNavigateToConfirm =
        _orgId != null && _redirectUrl != null && _data != null;
    if (shouldNavigateToConfirm) {
      _navigateToConfirmSubscriptionPage(ctx);
    } else {
      _navigateToSubscriptionsHome(ctx);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Center(
        child: FutureBuilder(
          future: _initAuth(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CupertinoActivityIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
