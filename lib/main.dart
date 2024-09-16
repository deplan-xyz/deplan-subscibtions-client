import 'package:deplan_subscriptions_client/api/auth.dart';
import 'package:deplan_subscriptions_client/app.dart';
import 'package:deplan_subscriptions_client/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'firebase_options.dart';

void main() async {
  final navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Main Navigator');
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // run firebase emulators:start and then uncomment this code
  // DO NOT PUSH IT TO PROD UNCOMMENTED!!!!
  if (kDebugMode && kIsWeb) {
    try {
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } catch (e) {
      print(e);
    }
  }

  Auth.onUserLoggedOut(() {
    Navigator.of(
      navigatorKey.currentContext!,
    ).pushNamedAndRemoveUntil(
      Routes.signin,
      (route) => false,
    );
  });

  runApp(const App());
}
