


import 'package:alef_parents/Features/Schedule_page/domain/entity/available_slots.dart';

class AvailableSlotsModel extends AvailableSlots {
  AvailableSlotsModel({
    required super.availableSlots
  });

factory AvailableSlotsModel.fromJson(Map<String, dynamic> json) {
  return AvailableSlotsModel(
    availableSlots: json['availableSlots'],
  );
}


  Map<String, dynamic> toJson() {
    return {
      'availableSlots': availableSlots,
   
    };
  }
  
}
