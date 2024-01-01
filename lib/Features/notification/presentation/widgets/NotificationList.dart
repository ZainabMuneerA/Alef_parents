import 'package:alef_parents/generated/intl/messages_ar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationList extends StatelessWidget {
  final String title;
  final String subtitle;

  const NotificationList({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 17.5,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 90,
              height: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Icon(
                  Icons.check_circle, // Use Icon widget here
                  size: 30, // Adjust the size as needed
                  color: Colors.green, // Set the color as needed
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //from the notification when clicked
    // final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    // Sample data for notifications
    List<Map<String, String>> notifications = [
      {
        "title": "Acceptance!",
        "subtitle": "You have been accepted at Alef preschool"
      },
      {
        "title": "message.notification!.title.toString()",
        "subtitle": "message.notification!.body.toString()"
      },
      // Add more notifications as needed
    ];

    return Column(
      children: notifications.map((notification) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: GestureDetector(
            onTap: () {
              // Navigate to PreschoolProfile using the named route and pass the preschool_id
              // Example: Navigator.pushNamed(context, '/preschool-profile', arguments: {"preschool_id": notification['preschool_id']});
            },
            child: NotificationList(
              title: notification['title'] ?? '',
              subtitle: notification['subtitle'] ?? '',
            ),
          ),
        );
      }).toList(),
    );
  }
}
