import 'package:alef_parents/Features/events/data/datasources/events_datasource.dart';
import 'package:alef_parents/Features/events/domain/entities/events.dart';
import 'package:alef_parents/Features/events/domain/repositories/events_repository.dart';
import 'package:alef_parents/core/Network/network_info.dart';
import 'package:alef_parents/core/error/Exception.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

class EventsRepositoryImp implements EventsRepository {
  final EventsDatasource datasource;
    final NetworkInfo networkInfo;

  EventsRepositoryImp({required this.datasource, required this.networkInfo});


  @override
  Future<Either<Failure, List<Events>>> getEvents(int classId) async{
     if (await networkInfo.isConnected) {
      try {
        final student = await datasource.getEventsByClass(classId);
        return Right(student);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
