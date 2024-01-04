import 'dart:convert';

import 'package:alef_parents/Features/events/data/models/events_model.dart';
import 'package:alef_parents/Features/events/domain/entities/events.dart';
import 'package:alef_parents/core/.env';
import 'package:alef_parents/core/error/Exception.dart';
import 'package:alef_parents/framework/services/auth/auth.dart';
import 'package:alef_parents/framework/shared_prefrences/UserPreferences.dart';
import 'package:http/http.dart' as http;

abstract class EventsDatasource {
  Future<List<Events>> getEventsByClass(int classId);
}

class EventDatasourceImp implements EventsDatasource {
  final http.Client client;

  EventDatasourceImp({required this.client});

  @override
  Future<List<Events>> getEventsByClass(int classId) async {
    try {
      String? authToken = await AuthenticationUtils.getUserToken();

      final response = await client.get(
        Uri.parse("${BASE_URL}events?class_id=$classId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );
     

      if (response.statusCode == 200) {
        // Decode the JSON body response
        final Map<String, dynamic> decodedJson = json.decode(response.body);

        final List<EventsModel> eventModelList = (decodedJson['events']
                as List<dynamic>)
            .map<EventsModel>((jsonEventModel) =>
                EventsModel.fromJson(jsonEventModel as Map<String, dynamic>))
            .toList();

        print("successful");

        return eventModelList;
      } else {
        throw ServerException();
      }
    } catch (error) {
      print("Error during get event: $error");
      rethrow;
    }
  }
}
