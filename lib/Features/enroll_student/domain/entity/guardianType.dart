import 'package:equatable/equatable.dart';

class GuardianType extends Equatable {
  final int id;
  final String categoryName;
  final String valueName;

  GuardianType(
      {required this.id, required this.categoryName, required this.valueName});
  factory GuardianType.fromJson(Map<String, dynamic> json) {
    return GuardianType(
        id: json['id'],
        categoryName: json['CategoryName'],
        valueName: json['ValueName']
        );
  }

  @override

  List<Object?> get props => [id, categoryName, valueName];
}
