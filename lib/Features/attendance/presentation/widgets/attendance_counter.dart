import 'package:alef_parents/Features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:alef_parents/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:alef_parents/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceCounterWidget extends StatelessWidget {
  final int studentId;

  const AttendanceCounterWidget({
    super.key,
    required this.studentId,
  });

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
            return Column(
              children: [
                _squareContainer(
                    'Present', state.attendace.present, acceptanceColor),
                const SizedBox(height: 16), // Adjust the height as needed
                _squareContainer(
                    'Absent', state.attendace.absent, secondaryColor),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _squareContainer(String label, int count, Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w100,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            count.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
