// ignore_for_file: non_constant_identifier_names

import '../../domain/entity/preschool.dart';
import 'addressModel.dart';

class PreschoolModel extends Preschool {
  const PreschoolModel({
    required super.preschool_id,
    required super.preschool_name,
    required super.phone,
    required super.curriculum,
    required super.description,
    required super.registration_fees,
    required super.monthly_fees,
    required super.minimum_age,
    required super.maximum_age,
    required super.address,
    required super.logo,
    required super.file,
  });

  factory PreschoolModel.fromJson(Map<String, dynamic> json) {
  List<dynamic>? mediaData = json['Preschool_Media'];
  List<String> mediaFiles = [];

  if (mediaData != null) {
    for (var mediaItem in mediaData) {
      String file = mediaItem['file'] ?? '';
      mediaFiles.add(file);
    }
  }

  return PreschoolModel(
    preschool_id: json['id'] ?? 0,
    preschool_name: json['preschool_name'] ?? '',
    phone: json['phone'],
    registration_fees: json['registration_fees'] ?? 0,
    curriculum: json['cirriculum'] ?? 'N/A',
    description: json['description'] ?? 'N/A',
    monthly_fees: json['monthly_fees'] ?? 0,
    minimum_age: json['minimum_age'] ?? 0,
    maximum_age: json['maximum_age'] ?? 0,
    address: json['Address'] != null
        ? AddressModel.fromJson(json['Address'])
        : AddressModel(
            longitude: 0,
            latitude: 0,
            area: 'Manama',
            road: 'No Road Data',
            building: 'No Building Data',
          ),
    logo: json['logo'],
    file: mediaFiles,
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
      'logo': logo,
      'Preschool_Media': [
        {'file': file}
      ],
    };
  }
}

// const defaultLogoUrl =
//     'https://st4.depositphotos.com/4329009/19956/v/1600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg';
