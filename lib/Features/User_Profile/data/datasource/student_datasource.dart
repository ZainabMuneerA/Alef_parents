import 'dart:convert';

import 'package:alef_parents/Features/User_Profile/data/model/student_model.dart';
import 'package:alef_parents/core/.env';
import 'package:alef_parents/core/error/Exception.dart';
import 'package:alef_parents/framework/services/auth/auth.dart';
import 'package:alef_parents/framework/shared_prefrences/UserPreferences.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

abstract class StudentDataSource {
  Future<List<StudentModel>> getStudent(int userId);
}

// const END_POINT = "http://localhost:3000/student";

class StudentDataSourceImp implements StudentDataSource {
  final http.Client client;

  StudentDataSourceImp(this.client);

  @override
  Future<List<StudentModel>> getStudent(
    int userID,
  ) async {
    try {
      String? authToken = await AuthenticationUtils.getUserToken();
      // final String? authToken = await UserPreferences.getToken();

      final response = await client.get(
        Uri.parse("${BASE_URL}student?user_id= $userID"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        // Decode the JSON body response
        final decodedJson = json.decode(response.body);

        final List<StudentModel> studentModel = decodedJson
            .map<StudentModel>(
                (jsonstudentModel) => StudentModel.fromJson(jsonstudentModel))
            .toList();

        print("successful");

        return studentModel;
      } else {
        throw ServerException();
      }
    } catch (error) {
      print("Error during get student: $error and status");
      throw error;
    }
  }
}
