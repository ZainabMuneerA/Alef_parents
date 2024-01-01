import 'package:firebase_installations/firebase_installations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../Features/notification/data/datasource/SetTokenDataSource.dart';
import '../../../main.dart';
import 'package:http/http.dart' as http;

// class Notifications {
// //create an instance of firebase messaging
//   final _firebaseMessageing = FirebaseMessaging.instance;

// //functoin to init the notifications
//   Future<void> initiNorification() async {
//     //request premission from user
//     await _firebaseMessageing.requestPermission();

//     //fetch the FCM token for this device
//     final FCMToken = await _firebaseMessageing.getToken();

//     //send token to the server
//     print('Token: $FCMToken');
//   }

// //handle recevied notifications
//   void handleMessage(RemoteMessage? message) {
//     if (message == null) return null;

//     navigatorKey.currentState?.pushNamed(
//       '/notification',
//       arguments: message,
//     );
//   }

// //init background and foreground settings
//   Future initPushNotification() async {
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//   }
// }

class Notifications {
  final _firebaseMessaging = FirebaseMessaging.instance;
  SetTokenDataSourceImp setTokenDataSource =
      SetTokenDataSourceImp(http.Client());

  Future<void> initiNorification(String? uid) async {
    await _firebaseMessaging.requestPermission();
    final FCMToken = await _firebaseMessaging.getToken();
    // Initialize Firebase Installations
    //  String? fid = await FirebaseInstallations.id;

    // // Get the Firebase Instance ID (FID)
  
    // print('Firebase Instance ID (FID): $fid');
    //send token to server
    if (FCMToken != null && uid != null) {
      setTokenDataSource.setToken(uid, FCMToken);
    }
  }

//not used rn
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
