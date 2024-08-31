import 'package:deplan_subscriptions_client/screens/subsciptions_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deplan_subscriptions_client/screens/confirm_subsciption.dart';
import 'package:deplan_subscriptions_client/screens/entry_point.dart';
import 'package:deplan_subscriptions_client/screens/signin.dart';
import 'package:deplan_subscriptions_client/theme/app_theme.dart';
import 'package:deplan_subscriptions_client/constants/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  FirebaseAuth get auth => FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser;
    final bool isUserAuthenticated = user != null;

    return MaterialApp(
      title: 'DePlan Subscriptions',
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(),
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      initialRoute:
          isUserAuthenticated ? Routes.subscriptionsHome : Routes.entryPoint,
      routes: {
        Routes.signin: (context) => const Signin(),
        Routes.entryPoint: (context) => const AppEntryPoint(),
        Routes.subscriptionsHome: (context) => const SubsciptionsHome(),
        Routes.confirmSubscription: (context) => const ConfirmSubsciption(),
      },
    );
  }
}
