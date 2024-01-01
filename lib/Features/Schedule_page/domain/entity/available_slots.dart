


import 'package:equatable/equatable.dart';

class AvailableSlots extends Equatable{

 final List<dynamic> availableSlots;

  AvailableSlots({
    required this.availableSlots
    });

  factory AvailableSlots.fromJson(Map<String, dynamic> json) {
    return AvailableSlots(
      availableSlots: json['availableSlots']
      
      // List<String>.from(json['availableSlots']),
    );
  }
  
  @override
  List<Object?> get props => [availableSlots];
}
