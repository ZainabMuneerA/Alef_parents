import 'package:alef_parents/Features/enroll_student/domain/entity/guardianType.dart';

class GuardianTypeModel extends GuardianType {
  GuardianTypeModel(
      {required super.id,
      required super.categoryName,
      required super.valueName});

  factory GuardianTypeModel.fromJson(Map<String, dynamic> json) {
    return GuardianTypeModel(
        id: json['id'],
        categoryName: json['CategoryName'],
        valueName: json['ValueName']);
     
  }
 Map<String, dynamic> toJson() {
    return {
      'id': id,
      'CategoryName': categoryName,
      'ValueName': valueName,
    };
  }
}


