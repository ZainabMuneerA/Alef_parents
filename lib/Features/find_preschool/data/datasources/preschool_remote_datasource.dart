import 'dart:convert';

import 'package:alef_parents/Features/find_preschool/data/model/preschool_model.dart';
import 'package:alef_parents/core/error/Exception.dart';
import 'package:alef_parents/framework/shared_prefrences/UserPreferences.dart';
import 'package:http/http.dart' as http;

import '../../../../core/.env';

abstract class PreschoolRemoteDataSource {
  Future<List<PreschoolModel>> getAllPreschool();
  Future<PreschoolModel> getPreschoolById(int id);
  Future<List<PreschoolModel>> getPreschoolByName(
    String? name,
    int? age,
    String? area,
    double? latitude,
    double? longitude,
  );

  Future<List<PreschoolModel>> getRecommendedPreschool();
  Future<List<String>> getPreschoolGrades(int id);
}

class PreschoolRemoteDataSourceImp implements PreschoolRemoteDataSource {
  final http.Client client;

  PreschoolRemoteDataSourceImp(this.client);

  @override
  Future<List<PreschoolModel>> getAllPreschool() async {
    final String? authToken = await UserPreferences.getToken();
    try {
      final response = await client.get(
        Uri.parse("${BASE_URL}preschools/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );

      if (response.statusCode == 200) {
        //decode the json body response
        final List decodedJson = json.decode(response.body) as List;

        final List<PreschoolModel> preschoolModel = decodedJson
            .map<PreschoolModel>((jsonPreschoolModel) =>
                PreschoolModel.fromJson(jsonPreschoolModel))
            .toList();

        return preschoolModel;
      } else {
        throw ServerException();
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<PreschoolModel> getPreschoolById(int id) async {
    final String? authToken = await UserPreferences.getToken();

    try {
      final response = await client.get(
        Uri.parse(BASE_URL + "preschools/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );

      if (response.statusCode == 200) {
        // Decode the response body
        final decodedData = json.decode(response.body) as Map<String, dynamic>;

        // Create a PreschoolModel object from the decoded data
        final PreschoolModel preschoolModel =
            PreschoolModel.fromJson(decodedData);

        // Return the fetched PreschoolModel
        return preschoolModel;
      } else {
        throw ServerException();
      }
    } catch (error) {
      print("Error during getPreschoolById: $error");
      rethrow;
    }
  }

  @override
  Future<List<PreschoolModel>> getPreschoolByName(
    String? name,
    int? age,
    String? area,
    double? latitude,
    double? longitude,
  ) async {
    final String? authToken = await UserPreferences.getToken();

    try {
      final Map<String, dynamic> queryParameters = {};

      if (name != null) {
        queryParameters["preschool_name"] = name;
      }

      if (age != null) {
        queryParameters["age"] = age.toString();
      }

      if (area != null) {
        queryParameters["location"] = area;
      }

      if (latitude != null && longitude != null) {
        queryParameters["latitude"] = latitude.toString();
        queryParameters["longitude"] = longitude.toString();
      }

      final Uri uri = Uri.parse("${BASE_URL}preschools/")
          .replace(queryParameters: queryParameters);

      final response = await client.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );
      if (response.statusCode == 200) {
        // Decode the response body
        final decodedData = json.decode(response.body) as List;

        // Create a PreschoolModel object from the decoded data
        final List<PreschoolModel> preschoolModel = decodedData
            .map<PreschoolModel>((jsonPreschoolModel) =>
                PreschoolModel.fromJson(jsonPreschoolModel))
            .toList();
        // Return the fetched PreschoolModel
        return preschoolModel;
      } else {
        throw ServerException();
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<PreschoolModel>> getRecommendedPreschool() async {
    final String? authToken = await UserPreferences.getToken();

    try {
      final Map<String, dynamic> queryParameters = {};

      final Uri uri =
          Uri.parse("${BASE_URL}preschools/?recommended=recommended");

      final response = await client.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );

      if (response.statusCode == 200) {
        // Decode the response body
        final decodedData = json.decode(response.body) as List;

        // Create a PreschoolModel object from the decoded data
        final List<PreschoolModel> preschoolModel = decodedData
            .map<PreschoolModel>((jsonPreschoolModel) =>
                PreschoolModel.fromJson(jsonPreschoolModel))
            .toList();
        // Return the fetched PreschoolModel
        return preschoolModel;
      } else {
        throw ServerException();
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<String>> getPreschoolGrades(int id) async {
    try {
      final String? authToken = await UserPreferences.getToken();

      final Map<String, dynamic> queryParameters = {};

      final Uri uri = Uri.parse("${BASE_URL}grades?preschool=1");

      final response = await client.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );

      if (response.statusCode == 200) {
        // Decode the response body
        final decodedData = json.decode(response.body) as List;

        // Extract the 'grade' field from each item
        final List<String> grades = decodedData.map<String>((item) {
          return item['grade'].toString();
        }).toList();

        // Return the fetched grades
        return grades;
      } else {
        throw ServerException();
      }
    } catch (error) {
      rethrow;
    }
  }
}
