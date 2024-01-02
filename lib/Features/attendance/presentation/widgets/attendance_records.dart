import 'package:alef_parents/Features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:alef_parents/Features/attendance/presentation/widgets/attendance_list_widget.dart';
import 'package:alef_parents/core/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:alef_parents/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceRecordsWidget extends StatelessWidget {
  final int studentId;

  AttendanceRecordsWidget({
    Key? key,
    required this.studentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AttendanceBloc>()
            ..add(GetAttendanceByStudentId(studentId: studentId)),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
        child: SizedBox(
          // Wrap with SizedBox to constrain height
          height: 900, // Set the desired height or use constraints
          child: Center(
            child: BlocBuilder<AttendanceBloc, AttendanceState>(
              builder: (context, state) {
                if (state is LoadingAttendance) {
                  return const LoadingWidget();
                } else if (state is LoadedAttendance) {
                  return AttendanceStatusListing(attendances: state.attendace);
                } else if (state is ErrorAttendance) {
                  return Text(state.message); // Display an error message
                } else {
                  print(state);
                  return const Center(child: Text("Unexpected state"));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
    