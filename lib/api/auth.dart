import 'package:deplan_subscriptions_client/api/base_api.dart';
import 'package:deplan_subscriptions_client/app_storage.dart';
import 'package:deplan_subscriptions_client/constants/common.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Auth {
  static String deplanAuthToken = '';
  static Dio get client {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        followRedirects: true,
      ),
    );
  }

  static Future<void> _getAndSetDeplanAuthToken() async {
    final deplantokenfromStorage =
        await appStorage.getValue(deplanAuthTokenKey);
    if (deplantokenfromStorage == null) {
      final deplantoken = await Auth.getDeplanAuthToken();
      Auth.deplanAuthToken = deplantoken;
      await appStorage.write(deplanAuthTokenKey, deplantoken);
      print('Deplan token set in storage');
    } else {
      print('Deplan token found in storage');
      Auth.deplanAuthToken = deplantokenfromStorage;
    }
  }

  static Future<UserCredential> signInWithApple() async {
    final appleProvider = OAuthProvider("apple.com")
      ..addScope('name')
      ..addScope('email');

    if (kIsWeb) {
      final authResponse =
          await FirebaseAuth.instance.signInWithPopup(appleProvider);
      await _getAndSetDeplanAuthToken();
      return authResponse;
    } else {
      final authResponse =
          await FirebaseAuth.instance.signInWithProvider(appleProvider);
      await _getAndSetDeplanAuthToken();
      return authResponse;
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Auth.deplanAuthToken = '';
  }

  static Future<String> getDeplanAuthToken() async {
    final firebaseUserId = FirebaseAuth.instance.currentUser?.uid;
    final response =
        await client.post('/auth/signin/firebase', data: {firebaseUserId});
    return response.data['token'];
  }

  static User? get currentUser => FirebaseAuth.instance.currentUser;
  static bool get isUserAuthenticated => currentUser != null;
  static Future<String?>? get authToken => currentUser?.getIdToken();

  static onUserLoggedIn(Function(User) callback) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        callback(user);
      }
    });
  }

  static onUserLoggedOut(Function() callback) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        callback();
      }
    });
  }
}
