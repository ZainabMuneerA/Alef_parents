// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

import '../../data/model/addressModel.dart';

class Preschool extends Equatable {
//attrubites that i need
  final int preschool_id;
  final String preschool_name;
  final String? phone;
  final String? description;
  final int registration_fees;
  final int monthly_fees;
  final String? curriculum;
  final int minimum_age;
  final int maximum_age;
  final AddressModel? address;
  final String? logo;
  final List<String>? file;

 const Preschool(
      {required this.preschool_id,
      required this.preschool_name,
      this.phone,
      this.description,
      required this.registration_fees,
      required this.monthly_fees,
      this.curriculum,
      required this.minimum_age,
      required this.maximum_age,
      this.address,
      this.logo,
      this.file,
      });

  @override
  List<Object?> get props => [
        preschool_id,
        preschool_name,
        phone,
        description,
        registration_fees,
        monthly_fees,
        curriculum,
        minimum_age,
        maximum_age,
        address,
        logo,
        file
      ];
}
