import 'dart:convert';

import 'package:alef_parents/Features/Schedule_page/data/model/available_slots.dart';
import 'package:alef_parents/Features/Schedule_page/data/model/scheduledModel.dart';
import 'package:alef_parents/Features/Schedule_page/domain/entity/appointment_request.dart';
import 'package:alef_parents/Features/Schedule_page/domain/entity/available_slots.dart';
import 'package:alef_parents/framework/services/auth/auth.dart';
import 'package:alef_parents/framework/shared_prefrences/UserPreferences.dart';
import 'package:http/http.dart' as http;

import '../../../../core/.env';
import '../../../../core/error/Exception.dart';
import '../../../../core/error/Failure.dart';

abstract class AppointmentDataSource {
  Future<ScheduledModel> schedule(AppointmentRequest appointmentRequest);
  Future<AvailableSlots> availableSlots(int preschoolId, String date);
}

// const BASE_URL = "http://localhost:3000/appointments/";

class AppointmentDataSourceImp implements AppointmentDataSource {
  final http.Client client;

  AppointmentDataSourceImp(this.client);

  @override
  Future<ScheduledModel> schedule(AppointmentRequest appointmentRequest) async {
    try {
      String? authToken = await AuthenticationUtils.getUserToken();

      final response = await client.post(
        Uri.parse("${BASE_URL}appointments/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
        body: json.encode(appointmentRequest.toJson()),
      );

      if (response.statusCode == 201) {
        // Decode the JSON body response
        final decodedJson = json.decode(response.body);

        final ScheduledModel scheduleModel =
            ScheduledModel.fromJson(decodedJson);

        print("appinted successful");

        return scheduleModel;
      } else {
        throw ServerException();
      }
    } catch (error) {
      print("Error during appointment datasource: $error");
      throw error;
    }
  }

  @override
  Future<AvailableSlots> availableSlots(int preschoolId, String date) async {
    //availableSlots?preschool=1&date=2023-12-04
    try {
      String? authToken = await AuthenticationUtils.getUserToken();

      final response = await client.get(
        Uri.parse(
            '${BASE_URL}appointments/availableSlots?preschool=$preschoolId&date=$date'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Decode the JSON body response
        final decodedJson = json.decode(response.body);

        final AvailableSlotsModel availableSlotsModel =
            AvailableSlotsModel.fromJson(decodedJson);

        print("appinted successful");

        return availableSlotsModel;
      } else {
        // Extract error message from the response body
        final decodedJson = json.decode(response.body);
        final errorMessage = decodedJson["message"] ?? "Server error";
        throw ServerFailure(message: errorMessage);
      }
    } catch (error) {
      print("Error during getting timex: $error");
      throw error;
    }
  }
}
