import '../../domain/entity/address.dart';

class AddressModel extends Address {
  AddressModel(
      {required super.longitude,
      required super.latitude,
      required super.area,
      required super.road,
      required super.building});

factory AddressModel.fromJson(Map<String, dynamic> json) {
  return AddressModel(
    longitude: (json['longitude'] is num) ? json['longitude'].toDouble() : 0.0,
    latitude: (json['latitude'] is num) ? json['latitude'].toDouble() : 0.0,
    area: json['area'] ?? 'No Area Data',
    road: json['road'] ?? 'No Road Data',
    building: json['building'] ?? 'No Building Data',
  );
}




  Map<String, dynamic> toJson() {
    return {
      'longitude': longitude,
      'latitude': latitude,
      'area': area,
      'road': road,
      'building': building,
    };
  }
}
