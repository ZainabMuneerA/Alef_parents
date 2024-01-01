import 'dart:convert';

import 'package:alef_parents/Features/register/data/model/RegisterModel.dart';
import 'package:alef_parents/core/.env';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/Exception.dart';
import '../../../../framework/shared_prefrences/UserPreferences.dart';

abstract class RegisterDataSource {
  Future<RegisterModel> register(String email, String name, String password);
}

// const END_POINT = "http://localhost:3000/users/";

class RegisterDataSourceImp implements RegisterDataSource {
  final http.Client client;

  RegisterDataSourceImp(this.client);

  @override
  Future<RegisterModel> register(
      String email, String name, String password) async {
    try {
      final response = await client.post(
        Uri.parse(BASE_URL + "users/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "name": name,
          "password": password,
          "role_name": "Parent"
        }),
      );

      if (response.statusCode == 201) {
        // Decode the JSON body response
        final decodedJson = json.decode(response.body);

        final RegisterModel registerModel = RegisterModel.fromJson(decodedJson);

        // Save user ID and username in shared preferences
        await UserPreferences.saveUserId(registerModel.user.id);
        await UserPreferences.saveUsername(registerModel.user.name);
        await UserPreferences.saveEmail(registerModel.user.email);
        return registerModel;
      } else {
        throw ServerException();
      }
    } catch (error) {
      rethrow;
    }
  }
}
