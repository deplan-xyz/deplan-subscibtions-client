import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Auth {
  static Future<UserCredential> signInWithApple() async {
    final appleProvider = OAuthProvider("apple.com")
      ..addScope('email')
      ..addScope('name');

    if (kIsWeb) {
      return await FirebaseAuth.instance.signInWithPopup(appleProvider);
    } else {
      return await FirebaseAuth.instance.signInWithProvider(appleProvider);
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static User? get currentUser => FirebaseAuth.instance.currentUser;
  static bool get isUserAuthenticated => currentUser != null;
  static Future<String?>? get authToken => currentUser?.getIdToken();
}
