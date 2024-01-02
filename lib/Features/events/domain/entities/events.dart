import 'package:equatable/equatable.dart';

class Events extends Equatable {
  final String eventName;
  final String eventDate;

  const Events({required this.eventName, required this.eventDate});


  @override
  List<Object?> get props => [eventName, eventDate];
}
