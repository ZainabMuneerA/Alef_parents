import '../../domain/entity/address.dart';
import '../../domain/entity/preschool.dart';
import 'addressModel.dart';

class PreschoolModel extends Preschool {
  PreschoolModel({
    required super.preschool_id,
    required super.preschool_name,
    required super.registration_fees,
    required super.monthly_fees,
    required super.minimum_age,
    required super.maximum_age,
    required super.address,
  });

  factory PreschoolModel.fromJson(Map<String, dynamic> json) {
    return PreschoolModel(
      preschool_id: json['id'] ?? 0, // Provide a default value for 'preschool_id'
      preschool_name: json['preschool_name'] ?? '',
      registration_fees: json['registration_fees'] ?? 0,
      monthly_fees: json['monthly_fees'] ?? 0,
      minimum_age: json['minimum_age'] ?? 0,
      maximum_age: json['maximum_age'] ?? 0,
      address: json['Address'] != null
          ? AddressModel.fromJson(json['Address'])
          : AddressModel(
              longitude: 0,
              latitude: 0,
              area: 'No Area Data',
              road: 'No Road Data',
              building: 'No Building Data',
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': preschool_id,
      'preschool_name': preschool_name,
      'phone': phone,
      'description': description,
      'registration_fees': registration_fees,
      'monthly_fees': monthly_fees,
      'curriculum': curriculum,
      'minimum_age': minimum_age,
      'maximum_age': maximum_age,
      'address': address,
    };
  }
}
