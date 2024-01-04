import 'package:alef_parents/Features/User_Profile/presentation/bloc/student_evaluation/student_evaluation_bloc.dart';
import 'package:alef_parents/core/widget/app_bar.dart';
import 'package:alef_parents/core/widget/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:alef_parents/injection_container.dart' as di;

class StudentEvaluationPage extends StatefulWidget {
  final int studentId;

  const StudentEvaluationPage({Key? key, required this.studentId})
      : super(key: key);

  @override
  _StudentEvaluationPageState createState() => _StudentEvaluationPageState();
}

class _StudentEvaluationPageState extends State<StudentEvaluationPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StudentEvaluationBloc>(
          create: (_) => di.sl<StudentEvaluationBloc>()
            ..add(GetStudentEvaluationEvent(id: widget.studentId)),
        )
      ],
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBarWidget(
            title: 'Student Evaluation Report',
            showBackButton: true,
          ),
        ),
        body: StudentEvaluationReport(studentId: widget.studentId.toString()),
      ),
    );
  }
}

class StudentEvaluationReport extends StatelessWidget {
  final String studentId;

  const StudentEvaluationReport({Key? key, required this.studentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentEvaluationBloc, StudentEvaluationState>(
      builder: (context, state) {
        if (state is NoDataState) {
          return DialogFb1(
            isError: true,
            subText: state.message,
            btnText: 'OK',
            onPressed: () {
              Navigator.pop(context);
            },
          );
        }

        if (state is LoadedEvaluationStudentState) {
          return Scaffold(
            body: PDFView(
              pdfData: state.pdf,
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
