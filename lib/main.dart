import 'package:deplan_subscriptions_client/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // listen to the auth state changes
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    print('User state changed: $user');
    // redirect to the home screen if the user is authenticated
  });

  // if (kDebugMode && kIsWeb) {
  //   try {
  //     await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  runApp(const App());
}
