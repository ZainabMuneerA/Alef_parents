
import 'package:alef_parents/Features/enroll_student/domain/entity/Enrollment.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/Failure.dart';
import '../entity/ApplicationRequest.dart';
import '../entity/EnrollmentStatus.dart';

abstract class ApplicationRepository {

  //usecases
  Future<Either<Failure, Enrollment>> applyToPreschool(ApplicationRequest request);

   
  Future<Either<Failure, List<EnrollmentStatus>>> getApplications(int id);

  Future<Either<Failure, List<EnrollmentStatus>>> cancelApplications(int id);
}