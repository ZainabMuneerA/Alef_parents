import 'package:alef_parents/Features/User_Profile/presentation/bloc/student_evaluation/student_evaluation_bloc.dart';
import 'package:alef_parents/Features/payment/presentation/pages/payment_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:alef_parents/injection_container.dart' as di;

class StudentDropDown extends StatefulWidget {
  final int studentId;
  final String? studentName;
  final String? studentGrade;
  final int classId;
  final ValueChanged<String>? onChanged;

  StudentDropDown({
    required this.studentId,
    required this.classId,
    this.studentName,
    this.studentGrade,
    this.onChanged,
  });

  @override
  _StudentDropDownState createState() => _StudentDropDownState();
}

class _StudentDropDownState extends State<StudentDropDown> {
  bool _isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2.0,
              blurRadius: 4.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _isDropdownOpen = !_isDropdownOpen;
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.studentName ?? '',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w100,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          widget.studentGrade ?? '',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      _isDropdownOpen
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 24.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            if (_isDropdownOpen)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white60,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2.0,
                      blurRadius: 4.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // List of default options
                    _buildDropdownOption('Payment', 'payment'),
                    _buildDropdownOption(
                        'Attendance Report', 'attendance_report'),
                    _buildDropdownOption(
                        'Evaluation Report', 'evaluation_report'),
                    _buildDropdownOption('Calendar Event', 'calendar_event'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownOption(String label, String optionId) {
    bool isPayment = label.toLowerCase() == 'payment';
    bool isAttendanceReport = label.toLowerCase() == 'attendance report';
    bool isEvaluationReport = label.toLowerCase() == 'evaluation report';

    return InkWell(
      onTap: () {
        setState(() {
          _isDropdownOpen = false;
        });

        // Check if the selected option is 'Payment'
        if (isPayment) {
          // Navigate to PaymentDetailsPage
          Navigator.pushNamed(
            context,
            '/payment-details',
            arguments: {'studentId': widget.studentId},
          );
        } else if (isAttendanceReport) {
          Navigator.pushNamed(
            context,
            '/attendance-report',
            arguments: {'studentId': widget.studentId},
          );
        } else if (isEvaluationReport) {
          // Add your logic for handling attendance or evaluation report
          // For now, let's navigate to a generic report page
          Navigator.pushNamed(
            context,
            '/student-report',
            arguments: {'studentId': widget.studentId},
          );
        } else if (label.toLowerCase() == 'calendar event') {
          // Navigate to StudentCalendarPage for calendar event
          Navigator.pushNamed(
            context,
            '/student-calendar',
            arguments: {'classId': widget.classId},
          );
        } else {
          // Include the student ID in the callback for other options
          widget.onChanged?.call('${widget.studentId}');
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 16.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w100,
                color: Colors.black,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: isPayment
                  ? IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/payment-details',
                          arguments: {
                            'studentId': widget.studentId,
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.monetization_on_outlined,
                        size: 24.0,
                        color: Colors.black,
                      ),
                    )
                  : (isAttendanceReport || isEvaluationReport)
                      ? IconButton(
                          onPressed: () {
                            // Your custom logic for handling attendance or evaluation report
                          },
                          icon: const Icon(
                            Icons.article_outlined,
                            size: 24.0,
                            color: Colors.black,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            // Your custom logic for the other options
                          },
                          icon: const Icon(
                            Icons.calendar_today,
                            size: 24.0,
                            color: Colors.black,
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

//   Widget _buildDropdownOption(String label, String optionId) {
//     bool isPayment = label.toLowerCase() == 'payment';

//     return InkWell(
//       onTap: () {
//         setState(() {
//           _isDropdownOpen = false;
//         });

//         // Check if the selected option is 'Payment'
//         if (isPayment) {
//           // Navigate to PaymentDetailsPage
//           Navigator.pushNamed(
//             context,
//             '/paymentDetails',
//             arguments: {'studentId': widget.studentId},
//           );
//         } else if (label.toLowerCase() == 'evaluation report') {
//           // Navigate to StudentReportPage for evaluation report
//           Navigator.pushNamed(
//             context,
//             '/student-report',
//             arguments: {'studentId': widget.studentId},
//           );
//         } else if (label.toLowerCase() == 'attendance report') {
//           // Add your download logic here for attendance report
//           // For now, let's navigate to AttendanceReportPage
//           Navigator.pushNamed(
//             context,
//             '/student-attendance',
//             arguments: {'studentId': widget.studentId},
//           );
//         } else if (label.toLowerCase() == 'Calendar Event') {
//           Navigator.pushNamed(
//             context,
//             '/student-calendar',
//             arguments: {'classId': widget.classId},
//           );
//         } else {
//           // Include the student ID in the callback for other options
//           widget.onChanged?.call('${widget.studentId}');
//         }
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           vertical: 12.0,
//           horizontal: 16.0,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             Align(
//               alignment: Alignment.topRight,
//               child: isPayment
//                   ? IconButton(
//                       onPressed: () {
//                         Navigator.pushNamed(
//                           context,
//                           '/payment-details',
//                           arguments: {
//                             'studentId': widget.studentId,
//                           },
//                         );
//                       },
//                       icon: const Icon(
//                         Icons.monetization_on_outlined,
//                         size: 24.0,
//                         color: Colors.black,
//                       ),
//                     )
//                   : IconButton(
//                       onPressed: () {
//                       },
//                       icon: const Icon(
//                         Icons.file_download_outlined,
//                         size: 24.0,
//                         color: Colors.black,
//                       ),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
