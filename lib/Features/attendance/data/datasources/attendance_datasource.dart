import 'dart:convert';

import 'package:alef_parents/Features/attendance/data/models/attendance_model.dart';
import 'package:alef_parents/Features/attendance/data/models/attendance_status_model.dart';
import 'package:alef_parents/core/error/Exception.dart';
import 'package:alef_parents/framework/shared_prefrences/UserPreferences.dart';
import 'package:http/http.dart' as http;

import '../../../../core/.env';

abstract class AttendanceDataSource {
  Future<List<AttendanceModel>> getAttendanceByStudentId(
    int studentId,
  );

  Future<AttendanceStatusModel> getAttendanceStatus(
    int studentId,
  );
}

class AttendanceDataSourceImp implements AttendanceDataSource {
  final http.Client client;

  AttendanceDataSourceImp({required this.client});

  @override
  Future<List<AttendanceModel>> getAttendanceByStudentId(int studentId) async {
        final String? authToken = await UserPreferences.getToken();

    try {
      final response = await client.get(
        Uri.parse("${BASE_URL}attendance/$studentId"),
        headers: {"Content-Type": "application/json","Authorization": "Bearer $authToken",},
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Decode the JSON body response
        final decodedJson = json.decode(response.body);

        final List<AttendanceModel> attendanceModel = decodedJson
            .map<AttendanceModel>((jsonattendanceModel) =>
                AttendanceModel.fromJson(jsonattendanceModel))
            .toList();

        return attendanceModel;
      } else {
        throw ServerException();
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<AttendanceStatusModel> getAttendanceStatus(int studentId) async {
    try {
            final String? authToken = await UserPreferences.getToken();

      final response = await client.get(
        Uri.parse("${BASE_URL}attendance/status/$studentId"),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $authToken",},
      );
      if (response.statusCode == 200) {
        // Decode the JSON body response
        final decodedJson = json.decode(response.body);

        final AttendanceStatusModel attendanceStatusModel =
            AttendanceStatusModel.fromJson(decodedJson);
        return attendanceStatusModel;
      } else {
        throw ServerException();
      }
    } catch (error) {
      rethrow;
    }
  }
}
