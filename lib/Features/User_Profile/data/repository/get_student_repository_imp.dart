import 'package:alef_parents/Features/User_Profile/data/datasource/student_datasource.dart';
import 'package:alef_parents/Features/User_Profile/domain/entity/student.dart';
import 'package:alef_parents/Features/User_Profile/domain/repository/student_repository.dart';
import 'package:alef_parents/core/Network/network_info.dart';
import 'package:alef_parents/core/error/Exception.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

class StudentRepositoryImp implements StudentRepository {
  final StudentDataSource dataSource;
  final NetworkInfo networkInfo;

  StudentRepositoryImp(
    {required this.dataSource,
     required this.networkInfo});

  
  @override
  Future<Either<Failure, List<Student>>> getStudent(int userID,) async {
    if (await networkInfo.isConnected) {
      try {
        final student = await dataSource.getStudent(userID, );
        return Right(student);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
