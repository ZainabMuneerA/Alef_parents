import 'dart:convert';

import 'package:alef_parents/Features/enroll_student/data/model/GuardianTypeModel.dart';
import 'package:alef_parents/framework/services/auth/auth.dart';
import 'package:alef_parents/framework/shared_prefrences/UserPreferences.dart';
import 'package:http/http.dart' as http;

import '../../../../core/.env';
import '../../../../core/error/Exception.dart';

abstract class GuardianDataSource {
  Future<List<GuardianTypeModel>> guardianType();
}


class GuardianDataSourceImp implements GuardianDataSource {
  final http.Client client;

  GuardianDataSourceImp({required this.client});

  @override
  Future<List<GuardianTypeModel>> guardianType() async {
    try {
            String? authToken = await AuthenticationUtils.getUserToken();


      final response = await client.get(
        Uri.parse("${BASE_URL}staticValues/guardianTypes"),
        headers: {"Content-Type": "application/json","Authorization": "Bearer $authToken",},
      );


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
