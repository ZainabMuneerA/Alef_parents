import 'dart:convert';
import 'dart:io';

import 'package:alef_parents/Features/User_Profile/domain/entity/student_evaluation.dart';
import 'package:alef_parents/core/.env';
import 'package:alef_parents/core/error/Exception.dart';
import 'package:alef_parents/framework/services/auth/auth.dart';
import 'package:alef_parents/framework/shared_prefrences/UserPreferences.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

abstract class StudentEvaluationDataSource {
  Future<Uint8List> getStudentEvaluation(int id);
}

// const END_POINT = "http://localhost:3000/studentEvaluation/";

class StudentDataSourceImp implements StudentEvaluationDataSource {
  final http.Client client;

  StudentDataSourceImp({required this.client});

  @override
  Future<Uint8List> getStudentEvaluation(int id) async {
    try {
      String? authToken = await AuthenticationUtils.getUserToken();
      final response = await client.get(
        Uri.parse("${BASE_URL}studentEvaluation/report/$id"),
        headers: {
          "Accept": "application/pdf",
          "Authorization":
              "Bearer $authToken", // Specify that you expect a PDF response
        },
      );
      print("${BASE_URL}studentEvaluation/report/$id");
      print(response.statusCode);
      // Write the token to a file for testing
      _writeTokenToFile(authToken);

      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.bodyBytes.isNotEmpty) {
          return Uint8List.fromList(response.bodyBytes);
        } else {
          throw Exception("Empty PDF response");
        }
      } else if (response.statusCode == 404) {
        print(response.body);
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        String message =
            jsonResponse['message'] ?? 'Evaluation has not been issued yet';
        throw NoDataYetException(message: message);
      } else {
        throw ServerException();
      }
    } catch (error) {
      rethrow;
    }
  }

  void _writeTokenToFile(String? authToken) {
    try {
      File file = File(
          '/Users/zainabmuneer/StudioProjects/alef_parents/lib/testtoken.txt');
      file.writeAsStringSync('User Token: $authToken');
      print('Token written to file: ${file.path}');
    } catch (error) {
      print('Error writing token to file: $error');
    }
  }
}
