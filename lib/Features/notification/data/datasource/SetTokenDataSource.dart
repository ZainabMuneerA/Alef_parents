import 'dart:convert';

import 'package:alef_parents/Features/notification/data/model/SetTokenModel.dart';
import 'package:alef_parents/framework/shared_prefrences/UserPreferences.dart';
import 'package:http/http.dart' as http;

import '../../../../core/.env';
import '../../../../core/error/Exception.dart';

abstract class SetTokenDataSource {
  void setToken(String uid, String token);
}



class SetTokenDataSourceImp implements SetTokenDataSource {
  final http.Client client;

  SetTokenDataSourceImp(this.client);

@override
void setToken(String uid, String token) async {
  try {
 final String? authToken = await UserPreferences.getToken();

    final response = await client.post(
      Uri.parse("${BASE_URL}notifications/setToken"),
      headers: {"Content-Type": "application/json",    "Authorization": "Bearer $authToken",},
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
      print("HTTP Error during token register: ${response.statusCode}");
      print("Response body: ${response.body}");
      throw ServerException();
    }
  } catch (error) {
    print("Error during token register: $error");
    throw error;
  }
}

}
