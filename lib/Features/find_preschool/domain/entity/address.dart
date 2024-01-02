
import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final double longitude;
  final double latitude;
  final String area;
  final String road;
  final String building;
  

  Address({
    required this.longitude,
    required this.latitude,
    required this.area,
    required this.road,
    required this.building,
    
  });

  
  @override
  List<Object?> get props => [
   longitude,
   latitude,
   area,
   road,
  building,
  ];
}