import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../utils.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    fcmToken = await _firebaseMessaging.getToken() ?? 'aaa';
    log(fcmToken.toString());
  }
}
