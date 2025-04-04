import 'package:alef_parents/Features/User_Profile/presentation/bloc/student/student_bloc.dart';
import 'package:alef_parents/Features/User_Profile/presentation/widgets/StudentDropDown.dart';
import 'package:alef_parents/Features/enroll_student/presentation/bloc/Application/application_bloc.dart';
import 'package:alef_parents/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/loading_widget.dart';
import 'EnrollmentStatus.dart';

class TabPair {
  final Tab tab;
  final Widget view;
  TabPair({required this.tab, required this.view});
}

List<TabPair> TabPairs = [
  TabPair(
    tab: Tab(
      text: 'My Kids',
    ),
    view: BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is LoadingStudentState) {
          return LoadingWidget();
        } else if (state is LoadedStudentState) {
          // Create a StudentDropDown for each student
          List<StudentDropDown> dropDowns = state.student.map((student) {
            return StudentDropDown(
              studentName: student.name,
              studentGrade: student.grade,
              studentId: student.id,
              classId: student.classID,
            );
          }).toList();
          return ListView(
            children: dropDowns,
          );
        } else {
          return LoadingWidget();
        }
      },
    ),
  ),
  TabPair(
    tab: Tab(
      text: 'My Application',
    ),
    view: BlocBuilder<ApplicationBloc, ApplicationState>(
      builder: (context, state) {
        if (state is LoadingApplicationState) {
          return LoadingWidget();
        } else if (state is LoadedApplicationState) {
          return EnrollmentStatusListing(
            enrollmentSatus: state.application,
          );
        } else {
          return LoadingWidget();
        }
      },
    ),
  ),
];

class TabBarAndTabViews extends StatefulWidget {
  @override
  _TabBarAndTabViewsState createState() => _TabBarAndTabViewsState();
}

class _TabBarAndTabViewsState extends State<TabBarAndTabViews>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: TabPairs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(6),
              child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                    color: primaryColor,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: TabPairs.map((tabPair) => tabPair.tab).toList()),
            ),
          ),

          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: TabPairs.map((tabPair) => tabPair.view).toList()),
          ),
        ],
      ),
    );
  }
}
