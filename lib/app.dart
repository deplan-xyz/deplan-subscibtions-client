import 'package:flutter/material.dart';
import 'package:deplan_subscriptions_client/screens/confirm_subsciption.dart';
import 'package:deplan_subscriptions_client/screens/home.dart';
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
      home: const Signin(),
      initialRoute: Routes.home,
      routes: {
        Routes.home: (context) => const Home(),
        Routes.signin: (context) => const Signin(),
        Routes.confirmSubscription: (context) => const ConfirmSubsciption(),
      },
    );
  }
}
