import 'package:alef_parents/Features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alef_parents/injection_container.dart' as di;
import 'package:pie_chart/pie_chart.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widget/loading_widget.dart';

class AttendancePiechartWidget extends StatelessWidget {
  final int studentId;

  const AttendancePiechartWidget({
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
            Map<String, double> dataMap = {
              'Present': state.attendace.present.toDouble(),
              'Absent': state.attendace.absent.toDouble(),
            };

            return Padding(
              padding: const EdgeInsets.all(8),
              child: PieChart(
                dataMap: dataMap,
                animationDuration: const Duration(milliseconds: 800),
                chartType: ChartType.ring,
                baseChartColor: acceptanceColor,
                colorList: [
                  acceptanceColor,
                  secondaryColor,
                ],
                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: true,
                ),
                legendOptions: const LegendOptions(
                  showLegends: false,
                ),
              ),
            );
          } else {
            return  Container();
          }
        },
      ),
    );
  }
}
