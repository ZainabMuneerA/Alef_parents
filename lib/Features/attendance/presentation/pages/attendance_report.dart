import 'package:alef_parents/Features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:alef_parents/Features/attendance/presentation/widgets/attendance_counter.dart';
import 'package:alef_parents/Features/attendance/presentation/widgets/attendance_piechart.dart';
import 'package:alef_parents/Features/attendance/presentation/widgets/attendance_records.dart';
import 'package:alef_parents/core/widget/app_bar.dart';
import 'package:alef_parents/core/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alef_parents/injection_container.dart' as di;

class AttendancePage extends StatelessWidget {
  final int studentId;

  const AttendancePage({
    Key? key,
    required this.studentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AttendanceBloc>()
            ..add(GetAttendanceStatus(studentId: studentId)),
        ),
      ],
      child: BlocBuilder<AttendanceBloc, AttendanceState>(
        builder: (context, state) {
          if (state is LoadedAttendanceStatus) {
            return Scaffold(
              appBar: const PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: AppBarWidget(
                  title: 'Attendance Report',
                  showBackButton: true,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: AttendancePiechartWidget(studentId: studentId),
                          ),
                          Expanded(
                            flex: 2,
                            child: AttendanceCounterWidget(studentId: studentId),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16), // Adjust the height as needed
                      Text("Attendance records"),
                      AttendanceRecordsWidget(
                        studentId: studentId,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: LoadingWidget(),
            );
          }
        },
      ),
    );
  }
}

