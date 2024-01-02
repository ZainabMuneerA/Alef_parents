import 'package:firebase_installations/firebase_installations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../Features/notification/data/datasource/SetTokenDataSource.dart';
import '../../../main.dart';
import 'package:http/http.dart' as http;


class Notifications {
  final _firebaseMessaging = FirebaseMessaging.instance;
  SetTokenDataSourceImp setTokenDataSource =
      SetTokenDataSourceImp(http.Client());

  Future<void> initiNorification(String? uid) async {
    await _firebaseMessaging.requestPermission();
    final FCMToken = await _firebaseMessaging.getToken();
    // Initialize Firebase Installations
    //  String? fid = await FirebaseInstallations.id;

  
    //send token to server
    if (FCMToken != null && uid != null) {
      setTokenDataSource.setToken(uid, FCMToken);
    }
  }

//
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      '/notification',
      arguments: message,
    );
  }

  Future<void> initPushNotification() async {
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handleMessage(message);
    });

    // Handle background messages
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // Handle messages when the app is launched
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {}
    });
  }
}
