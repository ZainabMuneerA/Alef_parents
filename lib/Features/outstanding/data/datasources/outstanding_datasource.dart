import 'dart:convert';

import 'package:alef_parents/Features/outstanding/data/models/bill_model.dart';
import 'package:alef_parents/Features/outstanding/data/models/outstanding_model.dart';
import 'package:alef_parents/Features/outstanding/domain/entities/bill.dart';
import 'package:alef_parents/core/.env';
import 'package:alef_parents/core/error/Exception.dart';
import 'package:http/http.dart' as http;

abstract class OutstandingDatasource {
  Future<List<OutstandingModel>> getOutstanding(int studentId);
  Future<BillModel> updateOutstanding(int paymentId);
}

// const END_POINT = "http://localhost:3000/payments/";

class OutstandingDatasourceImp implements OutstandingDatasource {
  final http.Client client;

  OutstandingDatasourceImp({required this.client});

  @override
  Future<List<OutstandingModel>> getOutstanding(int studentId) async {
    try {
      final response = await client.get(
          Uri.parse(BASE_URL +'payments/' + "?student_id=" + studentId.toString()),
          headers: {"Content-Type": "application/json"});
      // print(BASE_URL +'payments/' + "?student_id=" + studentId.toString());
      if (response.statusCode == 200) {
        final List decodedJson = json.decode(response.body) as List;
        final List<OutstandingModel> outstandingModel = decodedJson
            .map<OutstandingModel>((jsonOutstandingModel) =>
                OutstandingModel.fromJson(jsonOutstandingModel))
            .toList();

        return outstandingModel;
      } else {
        throw ServerException();
      }
    } catch (error) {
      print("Error during geting outstanding amount: $error");
      throw error;
    }
  }

  @override
  Future<BillModel> updateOutstanding(int paymentId) async {
    try {
      final response = await client.put(
        Uri.parse(BASE_URL +'payments/'+ paymentId.toString()),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"status": "Paid"}),
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body) as Map<String, dynamic>;
        final BillModel billModel = BillModel.fromJson(decodedData);
        return billModel;
      } else {
        throw ServerException();
      }
    } catch (error) {
      print("error during update payment $error");
      throw error;
    }
  }
}
