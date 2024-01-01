

import 'package:alef_parents/Features/events/domain/entities/events.dart';

class EventsModel extends Events {
  EventsModel(
      {required super.eventName,
      required super.eventDate,
  
      });

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    return EventsModel(
      eventName: json['event_name'],
      eventDate: json['event_date'],

 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_name': eventName,
      'event_date': eventDate,

    };
  }
}
