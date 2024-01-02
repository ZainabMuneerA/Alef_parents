
import '../../domain/entity/PreschoolName.dart';

class PreschoolNameModel extends PreschoolName {
  PreschoolNameModel({
    required super.preschoolName, 
  
    });

  factory PreschoolNameModel.fromJson(Map<String, dynamic> json) {
    return PreschoolNameModel(
        preschoolName: json['preschool_name'],
       );
  }
  Map<String, dynamic> toJson() {
    return {
      'preschool_name' : preschoolName,
     
    };
  }
}
