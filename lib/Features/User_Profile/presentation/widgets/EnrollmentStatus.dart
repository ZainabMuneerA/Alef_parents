import 'package:alef_parents/core/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../enroll_student/domain/entity/EnrollmentStatus.dart';

class EnrollmentStatusList extends StatelessWidget {
  final String kidName;
  final String preschoolName;
  final String status;

  const EnrollmentStatusList({
    Key? key,
    required this.kidName,
    required this.preschoolName,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert status and comparison strings to lowercase for case-insensitive comparison
    String lowercaseStatus = status.toLowerCase();

    // Define background color based on status
    Color backgroundColor = Colors.grey; // Default color
    if (lowercaseStatus == 'pending') {
      backgroundColor = accentColor;
    } else if (lowercaseStatus == 'waitlist') {
      backgroundColor = additionalColor;
    } else if (lowercaseStatus == 'rejected' ||
        lowercaseStatus == 'cancelled') {
      backgroundColor = secondaryColor;
    } else if (lowercaseStatus == 'accepted') {
      backgroundColor = const Color.fromRGBO(178, 219, 154, 1);
    }

    // Check if the status is not 'cancelled' or 'rejected' to make the container clickable
    bool isClickable =
        lowercaseStatus != 'cancelled' && lowercaseStatus != 'rejected';

    return GestureDetector(
      onTap: isClickable
          ? () {
              // Handle the onTap event for clickable containers
              // You can navigate to a different page or perform other actions here
              showApplicationBottomSheet(context);
            }
          : null, // Set onTap to null if the container is not clickable
      child: Container(
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
                      kidName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      preschoolName,
                      style: const TextStyle(fontSize: 14),
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
                      fontSize: 16,
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
      ),
    );
  }

  void showApplicationBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: 220,
              child: Container(
                padding: const EdgeInsets.fromLTRB(
                  16.0,
                  8,
                  16,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text('Cancel Application?'),
                      onTap: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    ),
                    const Divider(),
                    // const Spacer(),
                    SizedBox(
                      width: 430,
                      height: 61,
                      child: ElevatedButton(
                        onPressed: () {
                          //TODO add cancel
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(secondaryColor),
                        ),
                        child: const Text(
                          "Cancel Application",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class EnrollmentStatusListing extends StatelessWidget {
  final List<EnrollmentStatus> enrollmentSatus;

  EnrollmentStatusListing({required this.enrollmentSatus});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: enrollmentSatus.length,
      itemBuilder: (context, index) {
        final status = enrollmentSatus[index];

        return Padding(
          padding: const EdgeInsets.only(
            bottom: 16,
          ),
          child: GestureDetector(
            onTap: () {
              // Your onTap logic
            },
            child: EnrollmentStatusList(
              kidName: status.studentName,
              preschoolName: status.preschool?.preschoolName ?? 'N/A',
              status: status.enrollmentStatus,
            ),
          ),
        );
      },
    );
  }
}
