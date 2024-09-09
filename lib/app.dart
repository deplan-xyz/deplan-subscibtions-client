import 'dart:async';
import 'dart:io';

import 'package:deplan_subscriptions_client/models.dart';
import 'package:deplan_subscriptions_client/screens/subsciptions_home.dart';
import 'package:deplan_subscriptions_client/screens/subscription_details.dart';
import 'package:deplan_subscriptions_client/utilities/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:deplan_subscriptions_client/screens/confirm_subsciption.dart';
import 'package:deplan_subscriptions_client/screens/signin.dart';
import 'package:deplan_subscriptions_client/theme/app_theme.dart';
import 'package:deplan_subscriptions_client/constants/routes.dart';
import 'package:uni_links/uni_links.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  FirebaseAuth get auth => FirebaseAuth.instance;
  StreamSubscription? _sub;
  // naviation key
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    if (!kIsWeb && Platform.isIOS) {
      // Only handle deep links for iOS if the platform is iOS
      _handleIncomingLinks();
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  void _navigateToConfirmSubscription(String orgId) {
    _navigatorKey.currentState!.pushNamed(
      Routes.confirmSubscription,
      arguments: orgId,
    );
  }

  void _handleIncomingLinks() async {
    // Handle deep link when the app is already running (iOS only)
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null && uri.queryParameters.containsKey('orgId')) {
        String orgId = uri.queryParameters['orgId'] ?? '';
        print('OrgId found on iOS: $orgId');

        _navigateToConfirmSubscription(orgId);
      }
    }, onError: (err) {
      // Handle error
      print('Error: $err');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'DePlan Subscriptions',
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(),
      onGenerateRoute: (settings) {
        return handleQueryParamsParameter(settings);
      },
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      initialRoute: '/',
      routes: {
        Routes.signin: (context) => const Signin(),
        Routes.subscriptionsHome: (context) => const SubsciptionsHome(),
        Routes.confirmSubscription: (context) => const ConfirmSubsciption(
              orgId: 'default',
            ),
        Routes.subscriptionDetails: (context) => SubscriptionDetails(
              subscriptionData:
                  ModalRoute.of(context)!.settings.arguments as Subscription,
              selectedDate: DateTime.now(),
            ),
      },
    );
  }
}
