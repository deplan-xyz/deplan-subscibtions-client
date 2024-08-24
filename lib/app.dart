import 'package:deplan_subscriptions_client/screens/subsciptions_home.dart';
import 'package:flutter/material.dart';
import 'package:deplan_subscriptions_client/screens/confirm_subsciption.dart';
import 'package:deplan_subscriptions_client/screens/entry_point.dart';
import 'package:deplan_subscriptions_client/screens/signin.dart';
import 'package:deplan_subscriptions_client/theme/app_theme.dart';
import 'package:deplan_subscriptions_client/constants/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DePlan Subscriptions',
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(),
      initialRoute: Routes.entryPoint,
      routes: {
        Routes.signin: (context) => const Signin(),
        Routes.entryPoint: (context) => const AppEntryPoint(),
        Routes.subscriptionsHome: (context) => const SubsciptionsHome(),
        Routes.confirmSubscription: (context) => const ConfirmSubsciption(),
      },
    );
  }
}
