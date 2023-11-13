import 'dart:convert';

import '../../../../core/error/Exception.dart';
import '../model/loginModel.dart';
import 'package:http/http.dart' as http;

abstract class LoginDataSource {
  Future<LoginModel> login(String email, String password);
}

const BASE_URL = "http://localhost:3000/users/";

class LoginDataSourceImp implements LoginDataSource {
  final http.Client client;

  LoginDataSourceImp(this.client);

  @override
  Future<LoginModel> login(String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse(BASE_URL + "login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      print("${BASE_URL + "login"}");
      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        // Decode the JSON body response
        final decodedJson = json.decode(response.body) as Map<String, dynamic>;

        final LoginModel loginModel = LoginModel.fromJson(decodedJson);

        print("Login successful");

        return loginModel;
      } else {
        throw ServerException();
      }
    } catch (error) {
      print("Error during Login: $error");
      throw error;
    }
  }
}
