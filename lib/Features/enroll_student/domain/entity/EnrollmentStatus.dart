import 'package:equatable/equatable.dart';

import '../../data/model/ApplicationModel.dart';
import '../../data/model/preschooNameModel.dart';

class EnrollmentStatus extends Equatable {
    final String studentName;
    final String enrollmentStatus;
    final PreschoolNameModel? preschool;

  EnrollmentStatus({
    required this.studentName,
    required this.enrollmentStatus,
     this.preschool
    
    });

  @override
  List<Object?> get props => [studentName, enrollmentStatus ,];
}
