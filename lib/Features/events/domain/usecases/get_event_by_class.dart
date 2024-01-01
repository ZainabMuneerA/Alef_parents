import 'package:alef_parents/Features/events/domain/entities/events.dart';
import 'package:alef_parents/Features/events/domain/repositories/events_repository.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

class GetEventByClass {
  final EventsRepository repository;

  GetEventByClass({required this.repository});
  Future<Either<Failure, List<Events>>> call(int classId) {
    return repository.getEvents(classId);
  }
}
