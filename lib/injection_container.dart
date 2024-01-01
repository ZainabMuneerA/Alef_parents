// import 'dart:html';

import 'package:alef_parents/Features/Login/data/datasource/LoginDatasource.dart';
import 'package:alef_parents/Features/Login/data/repository/LoginRepositoryImp.dart';
import 'package:alef_parents/Features/Login/domain/repository/login_repository.dart';
import 'package:alef_parents/Features/Login/domain/usecases/login.dart';
import 'package:alef_parents/Features/Login/presentation/Bloc/bloc/login_bloc.dart';
import 'package:alef_parents/Features/Schedule_page/data/datasource/appointment_datasource.dart';
import 'package:alef_parents/Features/Schedule_page/data/repository/appointment_repository.dart';
import 'package:alef_parents/Features/Schedule_page/domain/repository/appointment_repository.dart';
import 'package:alef_parents/Features/Schedule_page/domain/usecases/appointment_usecase.dart';
import 'package:alef_parents/Features/Schedule_page/domain/usecases/get_time_slots.dart';
import 'package:alef_parents/Features/Schedule_page/presentation/bloc/appointment/appointment_bloc.dart';
import 'package:alef_parents/Features/Schedule_page/presentation/bloc/time/bloc/time_bloc.dart';
import 'package:alef_parents/Features/User_Profile/data/datasource/student_datasource.dart';
import 'package:alef_parents/Features/User_Profile/data/datasource/student_evaluation_datasource.dart'
    as se;
import 'package:alef_parents/Features/User_Profile/data/repository/get_student_evaluation.dart';
import 'package:alef_parents/Features/User_Profile/data/repository/get_student_repository_imp.dart';
import 'package:alef_parents/Features/User_Profile/domain/repository/student_evaluation_repsitory.dart';
import 'package:alef_parents/Features/User_Profile/domain/repository/student_repository.dart';
import 'package:alef_parents/Features/User_Profile/domain/usecase/get_student_usecase.dart';
import 'package:alef_parents/Features/User_Profile/domain/usecase/get_studnet_evaluation.dart';
import 'package:alef_parents/Features/User_Profile/presentation/bloc/student/student_bloc.dart';
import 'package:alef_parents/Features/User_Profile/presentation/bloc/student_evaluation/student_evaluation_bloc.dart';
import 'package:alef_parents/Features/attendance/data/datasources/attendance_datasource.dart';
import 'package:alef_parents/Features/attendance/data/repositories/attendance_repository_imp.dart';
import 'package:alef_parents/Features/attendance/domain/repositories/attendance_repository.dart';
import 'package:alef_parents/Features/attendance/domain/usecases/get_attendance_by_student.dart';
import 'package:alef_parents/Features/attendance/domain/usecases/get_attendance_status.dart';
import 'package:alef_parents/Features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:alef_parents/Features/enroll_student/data/datasource/ApplicationRemoteData.dart';
import 'package:alef_parents/Features/enroll_student/data/datasource/GuardianTypeRemoteData.dart';
import 'package:alef_parents/Features/enroll_student/data/repository/ApplicationRepositortImp.dart';
import 'package:alef_parents/Features/enroll_student/data/repository/GuardianRepositoryImp.dart';
import 'package:alef_parents/Features/enroll_student/domain/repository/Application_repository.dart';
import 'package:alef_parents/Features/enroll_student/domain/repository/guardianType_repository.dart';
import 'package:alef_parents/Features/enroll_student/domain/usecase/ApplyToPreschool.dart';
import 'package:alef_parents/Features/enroll_student/domain/usecase/GetMyApplication.dart';
import 'package:alef_parents/Features/enroll_student/domain/usecase/GuardianType.dart';
import 'package:alef_parents/Features/enroll_student/presentation/bloc/Application/application_bloc.dart';
import 'package:alef_parents/Features/enroll_student/presentation/bloc/GuardianType/bloc/guardian_type_bloc.dart';
import 'package:alef_parents/Features/events/data/datasources/events_datasource.dart';
import 'package:alef_parents/Features/events/data/repositories/events_repository_imp.dart';
import 'package:alef_parents/Features/events/domain/repositories/events_repository.dart';
import 'package:alef_parents/Features/events/domain/usecases/get_event_by_class.dart';
import 'package:alef_parents/Features/events/presentation/bloc/events_bloc.dart';
import 'package:alef_parents/Features/find_preschool/data/datasources/preschool_local_datasource.dart';
import 'package:alef_parents/Features/find_preschool/data/datasources/preschool_remote_datasource.dart';
import 'package:alef_parents/Features/find_preschool/data/repository/preschool_repository_imp.dart';
import 'package:alef_parents/Features/find_preschool/domain/usecases/get_all_preschool.dart';
import 'package:alef_parents/Features/find_preschool/domain/usecases/get_preschool_by_id.dart';
import 'package:alef_parents/Features/find_preschool/domain/usecases/get_preschool_by_name.dart';
import 'package:alef_parents/Features/find_preschool/domain/usecases/get_preschool_grade.dart';
import 'package:alef_parents/Features/find_preschool/domain/usecases/get_recommended_preschool.dart';
import 'package:alef_parents/Features/find_preschool/presentation/bloc/prschool/preschool_bloc.dart';
import 'package:alef_parents/Features/find_preschool/presentation/bloc/search/search_bloc.dart';
import 'package:alef_parents/Features/outstanding/data/datasources/outstanding_datasource.dart';
import 'package:alef_parents/Features/outstanding/data/repositories/outstanding_repository_imp.dart';
import 'package:alef_parents/Features/outstanding/domain/repositories/outstanding_repository.dart';
import 'package:alef_parents/Features/outstanding/domain/usecases/get_outstanding_usecase.dart';
import 'package:alef_parents/Features/outstanding/domain/usecases/update_outstanding_usecase.dart';
import 'package:alef_parents/Features/outstanding/presentation/bloc/bloc/outstanding_bloc.dart';
import 'package:alef_parents/Features/payment/data/datasource/fees_datasource.dart';
import 'package:alef_parents/Features/payment/data/repository/fees_repository_imp.dart';
import 'package:alef_parents/Features/payment/domain/repository/fees_repository.dart';
import 'package:alef_parents/Features/payment/domain/usecases/get_fees.dart';
import 'package:alef_parents/Features/payment/domain/usecases/update_payment.dart';
import 'package:alef_parents/Features/payment/presentation/bloc/fees/fees_bloc.dart';
import 'package:alef_parents/Features/payment/presentation/bloc/payment/payment_bloc.dart';
import 'package:alef_parents/Features/register/data/datasource/RegisterDatasource.dart';
import 'package:alef_parents/Features/register/data/repository/registerRepositoryImp.dart';
import 'package:alef_parents/Features/register/domain/repository/registration_repository.dart';
import 'package:alef_parents/Features/register/domain/usecase/register.dart';
import 'package:alef_parents/Features/register/presentation/Bloc/register/register_bloc.dart';
import 'package:alef_parents/core/Network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'package:alef_parents/Features/find_preschool/domain/repository/preschool_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! feature (find preschool)

//?bloc
  sl.registerFactory(() => PreschoolBloc(getAllPreschool: sl()));
  sl.registerFactory(() => SearchBloc(
      getPreschoolById: sl(),
      getPreschoolByName: sl(),
      getRecommendedPreschool: sl(),
      getPreschoolGrades: sl()));
  sl.registerFactory(() => LoginBloc(loginUseCase: sl()));
  sl.registerFactory(() => GuardianTypeBloc(guardianTypeUseCase: sl()));
  sl.registerFactory(() => ApplicationBloc(
      applyToPreschoolUseCase: sl(), getApplicationUseCase: sl()));
  sl.registerFactory(() => RegisterBloc(registerUseCase: sl()));
  sl.registerFactory(() => AppointmentBloc(appointmentUseCase: sl()));
  sl.registerFactory(() => TimeBloc(getAvailableTime: sl()));
  sl.registerFactory(() => PaymentBloc());
  sl.registerFactory(() => FeesBloc(
        feesUseCase: sl(),
        paidFeesUseCase: sl(),
      ));
  sl.registerFactory(() => StudentBloc(getStudentUseCase: sl()));
  sl.registerFactory(
      () => OutstandingBloc(outstandingUsecase: sl(), upadteOutstanding: sl()));
  sl.registerFactory(
      () => StudentEvaluationBloc(getStudentEvaluationUseCase: sl()));
  sl.registerFactory(() => EventsBloc(getEventByClass: sl()));
  sl.registerFactory(() =>
      AttendanceBloc(getAttendanceByStudentId: sl(), attendanceStatus: sl()));

//?usecases
  sl.registerLazySingleton(() => GetAllPreschoolsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetPreschoolByIdUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetPreschoolByNameUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetPreschoolGrades(repository: sl()));

  sl.registerLazySingleton(
      () => GetRecommendedPreschoolUseCase(repository: sl()));
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => GuardianTypeUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetApplicationUseCase(repository: sl()));
  sl.registerLazySingleton(() => ApplyToPreschoolUseCase(repository: sl()));
  sl.registerLazySingleton(() => RegisterUseCase(repository: sl()));
  sl.registerLazySingleton(() => AppointmentUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetTimeSlotsUseCase(repository: sl()));
  sl.registerFactory(() => GetFeesUseCase(repository: sl()));
  sl.registerLazySingleton(() => PaidFeesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetStudentUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => GetOutstandingUsecase(outstandingRepository: sl()));
  sl.registerLazySingleton(
      () => UpadteOutstandingUsecase(outstandingRepository: sl()));
  sl.registerLazySingleton(() => GetStudentEvaluationUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetEventByClass(repository: sl()));
  sl.registerLazySingleton(() => AttendanceUseCase(repository: sl()));
  sl.registerLazySingleton(() => AttendanceStatusUseCase(repository: sl()));

//?repo
  sl.registerLazySingleton<PreschoolRepository>(() => PreschoolRepositoryImp(
      networkInfo: sl(),
      preschoolLocalDataSource: sl(),
      preschoolRemoteDataSource: sl()));

  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImp(
        networkInfo: sl(),
        loginDataSource: sl(),
      ));

  sl.registerLazySingleton<GuardianTypeRepository>(() =>
      GuardianTypeRepositoryImp(guardianDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<ApplicationRepository>(() =>
      ApplicationRepositoryImp(applicationRemoteData: sl(), networkInfo: sl()));

  sl.registerLazySingleton<RegisterRepository>(
      () => RegisterRepositoryImp(dataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<AppointmentRepository>(
      () => AppointmentRepositoryImp(dataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<FeesRepository>(
      () => FeesRepositoryImp(dataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<StudentRepository>(
      () => StudentRepositoryImp(dataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<OutstandingRepository>(() =>
      OutstandingRepositoryImp(outstandingDatasource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<StudentEvaluationRepository>(() =>
      StudentEvaluationRepositoryImp(dataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<EventsRepository>(
      () => EventsRepositoryImp(datasource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<AttendanceRepository>(
      () => AttendanceRepositoryImp(dataSource: sl(), networkInfo: sl()));

//? datasources
  sl.registerLazySingleton<PreschoolRemoteDataSource>(
      () => PreschoolRemoteDataSourceImp(sl()));

  sl.registerLazySingleton<PreschoolLocalDataSource>(
      () => PreschoolLocalDataSourceImp(sharedPreferences: sl()));

  sl.registerLazySingleton<LoginDataSource>(() => LoginDataSourceImp(sl()));

  sl.registerLazySingleton<GuardianDataSource>(
      () => GuardianDataSourceImp(client: sl()));

  sl.registerLazySingleton<ApplicationRemoteData>(
      () => ApplicationDioDataImp(dio: sl()));

  // sl.registerLazySingleton<ApplicationRemoteData>(
  //   () => ApplicationRemoteDataImp(client: sl()));

  sl.registerLazySingleton<RegisterDataSource>(
      () => RegisterDataSourceImp(sl()));

  sl.registerLazySingleton<AppointmentDataSource>(
      () => AppointmentDataSourceImp(sl()));

  sl.registerLazySingleton<FeesDataSource>(() => FeesDataSourceImp(sl()));

  sl.registerLazySingleton<StudentDataSource>(() => StudentDataSourceImp(sl()));

  sl.registerLazySingleton<OutstandingDatasource>(
      () => OutstandingDatasourceImp(client: sl()));

  sl.registerLazySingleton<se.StudentEvaluationDataSource>(
      () => se.StudentDataSourceImp(client: sl()));

  sl.registerLazySingleton<EventsDatasource>(
      () => EventDatasourceImp(client: sl()));

  sl.registerLazySingleton<AttendanceDataSource>(
      () => AttendanceDataSourceImp(client: sl()));

//! core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImp(connectionChecker: sl()));

//! external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => dio.Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
