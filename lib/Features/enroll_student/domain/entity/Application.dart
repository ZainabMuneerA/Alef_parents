import 'package:alef_parents/Features/find_preschool/data/model/preschool_model.dart';
import 'package:equatable/equatable.dart';

class Application extends Equatable {
  final int id;
  final String studentName;
  
  final String status;

  Application(
      {required this.id,
      required this.studentName,
    
      required this.status});

  @override
  List<Object?> get props => [id, studentName, status];
}
