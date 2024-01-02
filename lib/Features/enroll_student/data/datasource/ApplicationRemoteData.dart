import 'dart:convert';
import 'dart:io';
// import 'dart:js_interop';

import 'package:alef_parents/Features/enroll_student/data/model/Enrollment.dart';
import 'package:alef_parents/Features/enroll_student/domain/entity/ApplicationRequest.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:alef_parents/framework/shared_prefrences/UserPreferences.dart';
import 'package:dio/dio.dart';

import '../../../../core/.env';
import '../../../../core/error/Exception.dart';
import '../model/EnrollmentStatusModel.dart';

abstract class ApplicationRemoteData {
  Future<List<EnrollmentStatusModel>> getAllApplication(int id);
  Future<EnrollmentModel> enrollStudent(ApplicationRequest request);
  Future<String> cancelApplication(int id);
}

//* using dio
class ApplicationDioDataImp implements ApplicationRemoteData {
  final Dio _dio;

  ApplicationDioDataImp({required Dio dio}) : _dio = dio;

  @override
  Future<EnrollmentModel> enrollStudent(ApplicationRequest request) async {
    try {
      final String? authToken = await UserPreferences.getToken();

      // Create FormData
      FormData formData = FormData.fromMap({
        'email': request.email,
        'preschool_id': request.preschoolId,
        'guardian_type': request.guardianType,
        'student_name': request.studentName,
        'guardian_name': request.guardianName,
        'student_CPR': request.studentCPR,
        'gender': request.gender,
        'grade': request.grade,
        'phone': request.phone,
        'student_DOB': request.studentDOB.toIso8601String(),
        'medical_history': request.medicalHistory,
        'created_by': request.createdBy,
        'personal_picture':
            await MultipartFile.fromFile(request.personalPicturePath.path),
        'certificate_of_birth':
            await MultipartFile.fromFile(request.certificateOfBirthPath.path),
        'passport': await MultipartFile.fromFile(request.passportPath.path),
      }); // create an instance of ApplicationRequest

      final response = await _dio.post('${BASE_URL}applications',
          data: formData,
          options: Options(
            headers: {
              "Content-Type": "application/json",
              //  "Authorization": "Bearer $authToken",
            },
          ));

      // Check for success or handle the response as needed
      if (response.statusCode == 201) {
        final Map<String, dynamic> decodedJson = response.data;
        // Now proceed with creating the EnrollmentModel
        final enrollmentModel = EnrollmentModel.fromJson(decodedJson);
        return enrollmentModel;
      } else if (response.statusCode == 400) {
        Map<String, dynamic> jsonResponse = json.decode(response.data);
        String message = jsonResponse['message'] ?? 'Application Error';
        throw NoDataYetException(message: message);
      } else {
        // Handle other status codes
        throw ServerException();
      }
    } catch (dioError) {
      // Handle other exceptions
      rethrow;
    }
  }

  @override
  Future<List<EnrollmentStatusModel>> getAllApplication(int id) async {
    try {
      final String? authToken = await UserPreferences.getToken();

      final response = await _dio.get(
        '${BASE_URL}applications/?user_id=$id',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        }),
      );

      if (response.statusCode == 200) {
        //  print(response.data);
        final List<dynamic> decodedData = response.data;

        final List<EnrollmentStatusModel> enrollmentStatus = decodedData
            .map<EnrollmentStatusModel>((jsonEnrollmentStatus) =>
                EnrollmentStatusModel.fromJson(jsonEnrollmentStatus))
            .toList();
        //print(enrollmentStatus);
        // return the data
        return enrollmentStatus;
      } else if (response.statusCode == 404) {
        print("there is an error check this ");
        print('the endpointtt: $BASE_URL/applications/?user_id=$id');
        throw ServerException();
      } else if (response.statusCode == 403) {
        throw ServerFailure();
      } else {
        throw ServerFailure();
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<String> cancelApplication(int id) async {
    try {
      // Create the JSON body
      final Map<String, dynamic> cancelBody = {"status": "Cancelled"};

      final response = await _dio.put(
        '${BASE_URL}applications/$id',
        options: Options(headers: {"Content-Type": "application/json"}),
        data: cancelBody, // Pass the JSON body here
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = response.data;
        final String message = decodedData['message'];

        // Return the message
        return message;
      } else {
        throw ServerException();
      }
    } catch (error) {
      rethrow;
    }
  }
}
