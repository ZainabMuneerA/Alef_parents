import 'package:alef_parents/Features/enroll_student/presentation/bloc/Application/application_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Container(
      width: 290,
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
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kidName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    preschoolName,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Text(
                    status,
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
          padding: EdgeInsets.only(bottom: 16,),
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
