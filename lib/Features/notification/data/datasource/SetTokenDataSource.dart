
import 'dart:convert';

import 'package:alef_parents/Features/notification/data/model/SetTokenModel.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/Exception.dart';

abstract class SetTokenDataSource {
 void setToken(String uid, String token);
}

const BASE_URL = "http://localhost:3000/notifications/";

class SetTokenDataSourceImp implements SetTokenDataSource {
  final http.Client client;

  SetTokenDataSourceImp(this.client);

  @override
  void setToken(
      String uid, String token,) async {
    try {
      final response = await client.post(
        Uri.parse(BASE_URL + "setToken"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "uid": uid,
          "token": token,

        }),
      );

      
      if (response.statusCode == 201) {
        // Decode the JSON body response
         try {
        final decodedJson = json.decode(response.body);

        print("Token registration successful");
        return null;
      } catch (e) {
        print("Error decoding JSON: $e");
        throw ServerException();
      }
      } else {
        throw ServerException();
      }
    } catch (error) {
      print("Error during token register: $error");
      throw error;
    }
  }
}
