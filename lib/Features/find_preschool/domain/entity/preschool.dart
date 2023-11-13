import 'package:equatable/equatable.dart';

import '../../data/model/addressModel.dart';

class Preschool extends Equatable {
//attrubites that i need
  final int preschool_id;
  final String preschool_name;
  final int? phone;
  final String? description;
  final int registration_fees;
  final int monthly_fees;
  final String? curriculum;
  final int minimum_age;
  final int maximum_age;
  final AddressModel? address;


  Preschool(
      {required this.preschool_id,
      required this.preschool_name,
      this.phone,
      this.description,
      required this.registration_fees,
      required this.monthly_fees,
      this.curriculum,
      required this.minimum_age,
      required this.maximum_age,
      this.address
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
        address
      ];
}
