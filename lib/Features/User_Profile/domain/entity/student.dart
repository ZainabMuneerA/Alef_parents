import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final int id;
  final int preschoolId;
  final String name;
  final String grade;
  final int userID;
  final int classID;

  Student({
    required this.id,
    required this.preschoolId,
    required this.name,
    required this.grade,
    required this.userID,
    required this.classID,
  });

  // factory Student.fromJson(Map<String, dynamic> json) {
  //   return Student(
  //     id: json['id'],
  //     preschoolId: json['preschool_id'],
  //     name: json['student_name'],
  //     grade: json['grade'],
  //     userID: json['user_id'],
  //     classID: json['"class_id"']
  //   );
  // }

  @override
  List<Object?> get props => [id, preschoolId, name, grade, userID];
}
