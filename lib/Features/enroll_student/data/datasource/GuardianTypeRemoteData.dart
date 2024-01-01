import 'dart:convert';

import 'package:alef_parents/Features/enroll_student/data/model/GuardianTypeModel.dart';
import 'package:http/http.dart' as http;

import '../../../../core/.env';
import '../../../../core/error/Exception.dart';

abstract class GuardianDataSource {
  Future<List<GuardianTypeModel>> guardianType();
}

// const BASE_URL = "http://localhost:3000/staticValues/";

class GuardianDataSourceImp implements GuardianDataSource {
  final http.Client client;

  GuardianDataSourceImp({required this.client});

  @override
  Future<List<GuardianTypeModel>> guardianType() async {
    try {
      final response = await client.get(
        Uri.parse(BASE_URL + "staticValues/guardianTypes"),
        headers: {"Content-Type": "application/json"},
      );

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        // Decode the JSON body response
        final List decodedJson = json.decode(response.body) as List;

        final List<GuardianTypeModel> guardianTypeModel = decodedJson
            .map<GuardianTypeModel>((guardianTypeModel) =>
                GuardianTypeModel.fromJson(guardianTypeModel))
            .toList();

        print("successful");

        return guardianTypeModel;
      } else {
        throw ServerException();
      }
    } catch (error) {
      print("Error during guard fetch: $error");
      throw error;
    }
  }
}
