import 'package:alef_parents/Features/notification/presentation/widgets/NotificationList.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Padding(

        padding:const EdgeInsets.fromLTRB(16,16,16,16),
        child: Notifications(),
      ),
    );
  }

}
