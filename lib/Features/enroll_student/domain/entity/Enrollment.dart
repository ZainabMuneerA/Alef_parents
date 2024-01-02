import 'package:alef_parents/Features/enroll_student/data/model/ApplicationModel.dart';
import 'package:equatable/equatable.dart';

import 'Application.dart';

class Enrollment extends Equatable {
  final String message;
  final ApplicationModel application;

  Enrollment({
  required this.message, 
  required this.application});
  
  @override
  List<Object?> get props => [message, application];


}
