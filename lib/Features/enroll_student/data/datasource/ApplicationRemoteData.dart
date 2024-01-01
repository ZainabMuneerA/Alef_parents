import 'dart:convert';
// import 'dart:js_interop';

import 'package:alef_parents/Features/enroll_student/data/model/ApplicationModel.dart';
import 'package:alef_parents/Features/enroll_student/data/model/Enrollment.dart';
import 'package:alef_parents/Features/enroll_student/domain/entity/Application.dart';
import 'package:alef_parents/Features/enroll_student/domain/entity/ApplicationRequest.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';

import '../../../../core/.env';
import '../../../../core/error/Exception.dart';
import '../model/EnrollmentStatusModel.dart';

abstract class ApplicationRemoteData {
  Future<List<EnrollmentStatusModel>> getAllApplication(int id);
  Future<EnrollmentModel> enrollStudent(ApplicationRequest request);
  Future<List<EnrollmentStatusModel>> cancelApplication(int id);
}

// const BASE_URL = 'http://localhost:3000/applications';
// const BASE_URL = 'http://192.168.0.105/applications';

// class ApplicationRemoteDataImp implements ApplicationRemoteData {
//   final http.Client client;

//   ApplicationRemoteDataImp({required this.client});

//   @override
// Future<EnrollmentModel> enrollStudent(ApplicationRequest request) async {
//   try {
//     final response = await client.post(
//       Uri.parse('$BASE_URL/'),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(request.toJson()),
//     );
//     print(response.body);
//     print(response.request);

//     if (response.statusCode == 201) {
//       //return the Enrollment model
//       final decodedJson = json.decode(response.body) as Map<String, dynamic>;
//       return EnrollmentModel.fromJson(decodedJson);
//     } else {
//       throw ServerException();
//     }
//   } catch (error) {
//     print("Error during enroll student $error");
//     throw error;
//   }
// }
//!!!!workss!!!

//   Future<EnrollmentModel> enrollStudent(ApplicationRequest request) async {
//     try {
//       var requestUri = Uri.parse('$BASE_URL/');

//       var multipartRequest = http.MultipartRequest('POST', requestUri)
//         ..fields.addAll(request
//             .toJson()
//             .map((key, value) => MapEntry(key, value.toString())))
//         ..files.add(await http.MultipartFile.fromPath(
//           'personal_picture',
//           request.personalPicturePath.path,
//         ))
//         ..files.add(await http.MultipartFile.fromPath(
//           'certificate_of_birth',
//           request.certificateOfBirthPath.path,
//         ))
//         ..files.add(await http.MultipartFile.fromPath(
//           'passport',
//           request.passportPath.path,
//         ));

//       var response = await multipartRequest.send();
//       var responseBody = await response.stream.bytesToString();

//       print(responseBody);

//       if (response.statusCode == 201) {
//         final decodedJson = json.decode(responseBody) as Map<String, dynamic>;
//         return EnrollmentModel.fromJson(decodedJson);
//       } else {
//         throw ServerException();
//       }
//     } catch (error) {
//       print("Error during enroll student $error");
//       throw error;
//     }
//   }

//   @override
//   Future<List<EnrollmentStatusModel>> getAllApplication(int id) async {
//     try {
//       final response = await client.get(
//         Uri.parse(BASE_URL + "?user_id=$id"),
//         headers: {"Content-Type": "application/json"},
//       );

//       print(BASE_URL + "?user_id=$id");
//       print("Response status code: ${response.statusCode}");
//       print("Response body: ${response.body}");

//       if (response.statusCode == 200) {
//         // Decode the response body
//         final decodedData = json.decode(response.body) as List;

//         // Create a Model object from the decoded data
//         final List<EnrollmentStatusModel> applicationModel = decodedData
//             .map<EnrollmentStatusModel>((jsonApplicationModel) =>
//                 EnrollmentStatusModel.fromJson(jsonApplicationModel))
//             .toList();
//         // Return the fetched
//         return applicationModel;
//       } else {
//         throw ServerException();
//       }
//     } catch (error) {
//       print("Error during applicationModel $error");
//       throw error;
//     }
//   }
// }

//! using dio
class ApplicationDioDataImp implements ApplicationRemoteData {
  final Dio _dio;

  ApplicationDioDataImp({required Dio dio}) : _dio = dio;

  @override
  Future<EnrollmentModel> enrollStudent(ApplicationRequest request) async {
    try {
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
      print(formData.fields);
      _dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));

      final response = await _dio.post(
        '${BASE_URL}applications',
        data: formData,
      );

      // Check for success or handle the response as needed
      if (response.statusCode == 201) {
        final Map<String, dynamic> decodedJson = response.data;
        // Now proceed with creating the EnrollmentModel
        final enrollmentModel = EnrollmentModel.fromJson(decodedJson);
        print(enrollmentModel);
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
      throw dioError;
    }
  }

  // Future<EnrollmentModel> enrollStudent(ApplicationRequest request) async {
  //   print("Enrolling student.........");
  //   try {
  //     FormData formData = FormData.fromMap({
  //       'email': request.email,
  //       'preschool_id': request.preschoolId,
  //       'guardian_type': request.guardianType,
  //       'student_name': request.studentName,
  //       'guardian_name': request.guardianName,
  //       'student_CPR': request.studentCPR,
  //       'gender': request.gender,
  //       'grade': request.grade,
  //       'phone': request.phone,
  //       'student_DOB': request.studentDOB,
  //       'medical_history': request.medicalHistory,
  //       'created_by': request.createdBy,
  //       'personal_picture': MultipartFile.fromFileSync(
  //         request.personalPicturePath.path,
  //         filename: 'personal_picture',
  //       ),
  //       'certificate_of_birth': MultipartFile.fromFileSync(
  //         request.certificateOfBirthPath.path,
  //         filename: 'certificate_of_birth',
  //       ),
  //       'passport': MultipartFile.fromFileSync(
  //         request.passportPath.path,
  //         filename: 'passport',
  //       ),
  //     });

  //     // Debug: Print formData for inspection
  //     print("FormData: ${formData.fields}");
  //     print("Personal Picture Path: ${request.personalPicturePath.path}");
  //     print(
  //         "Certificate of Birth Path: ${request.certificateOfBirthPath.path}");
  //     print("Passport Path: ${request.passportPath.path}");

  //     final response = await _dio.post(
  //       '$BASE_URL/',
  //       data: formData,
  //     );

  //     // Debug: Print response status code
  //     print("Response Status Code: ${response.statusCode}");

  //     // Check for success or handle the response as needed
  //     if (response.statusCode == 201) {
  //       final Map<String, dynamic> decodedJson = response.data;
  //       // Now proceed with creating the EnrollmentModel
  //       final enrollmentModel = EnrollmentModel.fromJson(decodedJson);
  //       return enrollmentModel;
  //     } else {
  //       // Handle other status codes
  //       print("Unhandled Status Code: ${response.statusCode}");
  //       throw ServerException();
  //     }
  //   } catch (dioError) {
  //     // Handle other exceptions
  //     print("Error during enroll student $dioError");
  //     throw dioError;
  //   }
  // }

  // ApplicationRequest appRequest = ApplicationRequest(
  //     email: request.email,
  //     preschoolId: request.preschoolId,
  //     guardianType: request.guardianType,
  //     studentName: request.studentName,
  //     guardianName: request.guardianName,
  //     studentCPR: request.studentCPR,
  //     gender: request.gender,
  //     grade: request.grade,
  //     phone: request.phone,
  //     studentDOB: request.studentDOB,
  //     medicalHistory: request.medicalHistory,
  //     createdBy: request.createdBy,
  //     personalPicturePath: request.personalPicturePath,
  //     certificateOfBirthPath: request.certificateOfBirthPath,
  //     passportPath: request.passportPath); // create an instance of ApplicationRequest

  // String jsonString = appRequest.toJsonString();
  @override
  Future<List<EnrollmentStatusModel>> getAllApplication(int id) async {
    try {
      final response = await _dio.get(
        '${BASE_URL}applications/?user_id=$id',
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200) {
        print(response.data);
        final List<dynamic> decodedData = response.data;

        final List<EnrollmentStatusModel> enrollmentStatus = decodedData
            .map<EnrollmentStatusModel>((jsonEnrollmentStatus) =>
                EnrollmentStatusModel.fromJson(jsonEnrollmentStatus))
            .toList();
        print(enrollmentStatus);
        // return the data
        return enrollmentStatus;
      } else if (response.statusCode == 404) {
        print("there is an error check this ");
        print('the endpointtt: $BASE_URL/applications/?user_id=$id');
        throw ServerException();
      } else {
        throw ServerException();
      }
    } catch (error) {
      print("Error during applicationModel $error");
      throw error;
    }
  }

  @override
  Future<List<EnrollmentStatusModel>> cancelApplication(int id) async {
    try {
      // Create the JSON body
      final Map<String, dynamic> cancelBody = {"status": "Cancelled"};

      final response = await _dio.put(
        '${BASE_URL}applications/$id',
        options: Options(headers: {"Content-Type": "application/json"}),
        data: cancelBody, // Pass the JSON body here
      );

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = response.data;

        final List<EnrollmentStatusModel> enrollmentStatus = decodedData
            .map<EnrollmentStatusModel>((jsonEnrollmentStatus) =>
                EnrollmentStatusModel.fromJson(jsonEnrollmentStatus))
            .toList();
        print(enrollmentStatus);
        // Return the data
        return enrollmentStatus;
      } else if (response.statusCode == 404) {
        print("There is an error, check this");
        throw ServerException();
      } else {
        throw ServerException();
      }
    } catch (error) {
      print("Error during applicationModel $error");
      throw error;
    }
  }

//   Future<EnrollmentModel> enrollStudent(ApplicationRequest request) async {
//   print("Enrolling student.........");
//   try {
//     // Create an instance of ApplicationRequest
//     ApplicationRequest appRequest = ApplicationRequest(
//       email: request.email,
//       preschoolId: request.preschoolId,
//       guardianType: request.guardianType,
//       studentName: request.studentName,
//       guardianName: request.guardianName,
//       studentCPR: request.studentCPR,
//       gender: request.gender,
//       grade: request.grade,
//       phone: request.phone,
//       studentDOB: request.studentDOB,
//       medicalHistory: request.medicalHistory,
//       createdBy: request.createdBy,
//       personalPicturePath: request.personalPicturePath,
//       certificateOfBirthPath: request.certificateOfBirthPath,
//       passportPath: request.passportPath,
//     );

//     // Create FormData and add other fields
//     FormData formData = FormData();
//     formData.fields.addAll(appRequest.toJson().entries.map(
//         (entry) => MapEntry<String, String>(entry.key, entry.value.toString())));

//     // Add file chunks to formData
//     formData.files.add(
//       MapEntry(
//         'personal_picture',
//         await MultipartFile.fromFile(
//           request.personalPicturePath.path,
//           filename: 'personal_picture',
//           contentType: MediaType('application', 'octet-stream'),
//         ),
//       ),
//     );

//     // Add other files similarly

//     // Debug: Print formData for inspection
//     print("FormData: ${formData.fields}");

//     // Make the Dio POST request
//     final response = await _dio.post(
//       '$BASE_URL/',
//       data: formData,
//       options: Options(
//         headers: {'Transfer-Encoding': 'chunked'},
//       ),
//     );

//     // Debug: Print response status code
//     print("Response Status Code: ${response.statusCode}");

//     // Check for success or handle the response as needed
//     if (response.statusCode == 201) {
//       final Map<String, dynamic> decodedJson = response.data;
//       // Now proceed with creating the EnrollmentModel
//       final enrollmentModel = EnrollmentModel.fromJson(decodedJson);
//       return enrollmentModel;
//     } else {
//       // Handle other status codes
//       print("Unhandled Status Code: ${response.statusCode}");
//       throw ServerException();
//     }
//   } catch (dioError) {
//     // Handle other exceptions
//     print("Error during enroll student $dioError");
//     throw dioError;
//   }
// }
}
