import 'dart:convert';
import 'package:alef_parents/Features/payment/data/model/fees_model.dart';
import 'package:alef_parents/Features/payment/data/model/paid_model.dart';
import 'package:alef_parents/Features/payment/domain/entity/paid.dart';
import 'package:alef_parents/core/.env';
import 'package:alef_parents/core/error/Exception.dart';
import 'package:http/http.dart' as http;

abstract class FeesDataSource {
  Future<List<FeesModel>> getFees(
    int studentId,
  );

  Future<Paid> paidFees(
    int paymentId,
  );
}

// const END_POINT = "http://localhost:3000/payments/";

class FeesDataSourceImp implements FeesDataSource {
  final http.Client client;

  FeesDataSourceImp(this.client);

  @override
  Future<List<FeesModel>> getFees(
    int studentId,
  ) async {
    try {
      final response = await client.get(
        Uri.parse(BASE_URL +'payments/?student_id='+studentId.toString()),
        headers: {"Content-Type": "application/json"},
      );
      print(BASE_URL +'payments/?student_id='+studentId.toString());
      print("Response status code: ${response.statusCode}");
      // print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        // Decode the JSON body response
        final decodedJson = json.decode(response.body);

        final List<FeesModel> paymentModel = decodedJson
            .map<FeesModel>((jsonPreschoolModel) =>
                FeesModel.fromJson(jsonPreschoolModel))
            .toList();

        return paymentModel;
      } else {
        throw ServerException();
      }
    } catch (error) {
      print("Error during get fees: $error");
      throw error;
    }
  }
  
  @override
  Future<Paid> paidFees(int paymentId) async{
    try {
      final response = await client.put(
        Uri.parse(BASE_URL + 'payments/'+paymentId.toString()),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"status": "Paid"}),
      );
      print(BASE_URL + paymentId.toString());
      print("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
          // Decode the response body
        final decodedData = json.decode(response.body) as Map<String, dynamic>;

        // Create a PreschoolModel object from the decoded data
        final PaidModel paidModel =
            PaidModel.fromJson(decodedData);

        return paidModel;
      } else {
        throw ServerException();
      }
    } catch (error) {
      print("Error during get fees: $error");
      throw error;
    }
  }
}
