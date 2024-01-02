

import 'package:alef_parents/Features/attendance/domain/entities/attendance.dart';
import 'package:alef_parents/core/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class AttendanceStatusList extends StatelessWidget {
  final String date;
  final String status;

  const AttendanceStatusList({
    Key? key,
    required this.date,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert status and comparison strings to lowercase for case-insensitive comparison
    String lowercaseStatus = status.toLowerCase();

    // Define background color based on status
    Color backgroundColor = Colors.grey; // Default color
    if (lowercaseStatus == 'absent') {
      backgroundColor = secondaryColor;
    } else if (lowercaseStatus == 'present') {
      backgroundColor =  acceptanceColor;
    }

    // Format the date
    String formattedDate = DateFormat('EEEE, dd-MM-yyyy').format(DateTime.parse(date));

    return Container(
      width: 290,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 17.5,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 6.0,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class AttendanceStatusListing extends StatelessWidget {
  final List<Attendance> attendances;

  const AttendanceStatusListing({super.key, required this.attendances});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: attendances.length,
      itemBuilder: (context, index) {
        final attendance = attendances[index];

        return Padding(
          padding: const EdgeInsets.only(
            bottom: 16,
          ),
          child: GestureDetector(
            onTap: () {
              // Your onTap logic
            },
            child: AttendanceStatusList(
              status: attendance.status,
              date: attendance.date,
            
            ),
          ),
        );
      },
    );
  }
}
