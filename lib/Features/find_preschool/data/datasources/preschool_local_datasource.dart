import 'dart:convert';

import 'package:alef_parents/core/error/Exception.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/preschool_model.dart';

abstract class PreschoolLocalDataSource {
  Future<List<PreschoolModel>> getCachedPreschool();
  Future<Unit> cachedPreschool(List<PreschoolModel> preschoolModel);
}

const CACHED_PRESCHOOL = "CACHED_PRESCHOOL";

class PreschoolLocalDataSourceImp implements PreschoolLocalDataSource {
  final SharedPreferences sharedPreferences;

  PreschoolLocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<Unit> cachedPreschool(List<PreschoolModel> preschoolModel) {
    List PreschoolModelToJson = preschoolModel
        .map<Map<String, dynamic>>((PreschoolModel) => PreschoolModel.toJson())
        .toList();
    sharedPreferences.setString(
        CACHED_PRESCHOOL, json.encode(PreschoolModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PreschoolModel>> getCachedPreschool() {
    final jsonString = sharedPreferences.getString(CACHED_PRESCHOOL);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PreschoolModel> jsonToPreschoolModel = decodeJsonData
          .map<PreschoolModel>((jsonPreschoolModel) =>
              PreschoolModel.fromJson(jsonPreschoolModel))
          .toList();
      return Future.value(jsonToPreschoolModel);
    } else {
      throw EmptyCacheException();
    }
  }
}
