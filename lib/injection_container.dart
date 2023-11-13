// import 'dart:html';

import 'package:alef_parents/Features/Login/data/datasource/LoginDatasource.dart';
import 'package:alef_parents/Features/Login/data/repository/LoginRepositoryImp.dart';
import 'package:alef_parents/Features/Login/domain/repository/login_repository.dart';
import 'package:alef_parents/Features/Login/domain/usecases/login.dart';
import 'package:alef_parents/Features/Login/presentation/Bloc/bloc/login_bloc.dart';
import 'package:alef_parents/Features/find_preschool/data/datasources/preschool_local_datasource.dart';
import 'package:alef_parents/Features/find_preschool/data/datasources/preschool_remote_datasource.dart';
import 'package:alef_parents/Features/find_preschool/domain/usecases/get_all_preschool.dart';
import 'package:alef_parents/Features/find_preschool/domain/usecases/get_preschool_by_id.dart';
import 'package:alef_parents/Features/find_preschool/presentation/bloc/prschool/preschool_bloc.dart';
import 'package:alef_parents/Features/find_preschool/presentation/bloc/prschool/search/search_bloc.dart';
import 'package:alef_parents/core/Network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:alef_parents/Features/find_preschool/domain/repository/preschool_repository.dart';
import 'Features/find_preschool/data/repository/preschool_repository_imp.dart';
import 'Features/find_preschool/domain/usecases/get_preschool_by_name.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! feature (find preschool)

//bloc
  sl.registerFactory(() => PreschoolBloc(getAllPreschool: sl()));
  sl.registerFactory(
      () => SearchBloc(getPreschoolById: sl(), getPreschoolByName: sl()));
  sl.registerFactory(() => LoginBloc(loginUseCase: sl()));

//usecases
  sl.registerLazySingleton(() => GetAllPreschoolsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetPreschoolByIdUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetPreschoolByNameUseCase(repository: sl()));
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));

//repo
  sl.registerLazySingleton<PreschoolRepository>(() => PreschoolRepositoryImp(
      networkInfo: sl(),
      preschoolLocalDataSource: sl(),
      preschoolRemoteDataSource: sl()));

  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImp(
        networkInfo: sl(),
        loginDataSource: sl(),
      ));

//datasources
  sl.registerLazySingleton<PreschoolRemoteDataSource>(
      () => PreschoolRemoteDataSourceImp(sl()));

  sl.registerLazySingleton<PreschoolLocalDataSource>(
      () => PreschoolLocalDataSourceImp(sharedPreferences: sl()));

  sl.registerLazySingleton<LoginDataSource>(() => LoginDataSourceImp(sl()));

//! core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImp(connectionChecker: sl()));

//! external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
