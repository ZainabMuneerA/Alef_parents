part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetPreschoolByIdEvent extends SearchEvent {
  final int id;

  GetPreschoolByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}



class GetPreschoolByNameEvent extends SearchEvent {
  String? name;
  int? age;
  String? area;
  double? latitude;
  double? longitude;

  GetPreschoolByNameEvent({
     this.name,
    this.age,
    this.area,
    this.latitude,
    this.longitude,
  });

  @override
  List<Object> get props => [
    name!,
    age!,
    area!,
    latitude!,
    longitude!,
  ];
}



