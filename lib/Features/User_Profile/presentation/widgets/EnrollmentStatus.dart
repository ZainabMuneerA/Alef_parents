import 'package:alef_parents/Features/enroll_student/presentation/bloc/Application/application_bloc.dart';
import 'package:alef_parents/core/app_theme.dart';
import 'package:alef_parents/core/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enroll_student/domain/entity/EnrollmentStatus.dart';

class EnrollmentStatusList extends StatefulWidget {
  final String kidName;
  final String preschoolName;
  final String status;
  final int id;

  const EnrollmentStatusList({
    Key? key,
    required this.kidName,
    required this.preschoolName,
    required this.status,
    required this.id,
  }) : super(key: key);

  @override
  _EnrollmentStatusListState createState() => _EnrollmentStatusListState();
}

class _EnrollmentStatusListState extends State<EnrollmentStatusList> {
  @override
  Widget build(BuildContext context) {
    String lowercaseStatus = widget.status.toLowerCase();
    Color backgroundColor = Colors.grey;

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

    return BlocBuilder<ApplicationBloc, ApplicationState>(
      builder: (context, state) {
        print(state);
        if (state is LoadedApplicationState) {
          return GestureDetector(
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
                            widget.kidName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.preschoolName,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.status,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
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
        } else {
          return LoadingWidget();
        }
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
              id: status.id,
            ),
          ),
        );
      },
    );
  }
}
