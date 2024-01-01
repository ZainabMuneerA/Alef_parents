import 'package:alef_parents/Features/events/domain/entities/events.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

abstract class EventsRepository {
  Future<Either<Failure, List<Events>>> getEvents(int classId);
}
