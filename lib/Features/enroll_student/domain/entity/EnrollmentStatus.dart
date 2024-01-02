import 'package:equatable/equatable.dart';

import '../../data/model/ApplicationModel.dart';
import '../../data/model/preschooNameModel.dart';

class EnrollmentStatus extends Equatable {
  final int id;
  final String studentName;
  final String enrollmentStatus;
  final PreschoolNameModel? preschool;

  const EnrollmentStatus(
      {required this.id,
        required this.studentName,
      required this.enrollmentStatus,
      this.preschool});

  @override
  List<Object?> get props => [
    id,
        studentName,
        enrollmentStatus,
      ];
}
