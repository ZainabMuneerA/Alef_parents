import 'dart:convert';

import 'package:alef_parents/Features/User_Profile/domain/entity/student_evaluation.dart';
import 'package:alef_parents/core/.env';
import 'package:alef_parents/core/error/Exception.dart';
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
      final response = await client.get(
        Uri.parse(BASE_URL + "studentEvaluation/report/" + id.toString()),
        headers: {
          "Accept": "application/pdf", // Specify that you expect a PDF response
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.bodyBytes.isNotEmpty) {
          return Uint8List.fromList(response.bodyBytes);
        } else {
          throw Exception("Empty PDF response");
        }
      } else if (response.statusCode == 404) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        String message =
            jsonResponse['message'] ?? 'Evaluation has not been issued yet';
        throw NoDataYetException(message: message);
      } else {
        throw ServerException();
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
