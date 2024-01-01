part of 'outstanding_bloc.dart';

sealed class OutstandingEvent extends Equatable {
  const OutstandingEvent();

  @override
  List<Object> get props => [];
}

class GetOutstandingEvent extends OutstandingEvent {
  final int studentId;

  GetOutstandingEvent({required this.studentId});
  @override
  List<Object> get props => [studentId];
}

class UpdateOutstandingEvent extends OutstandingEvent {
  final int paymentId;

  UpdateOutstandingEvent({required this.paymentId});
  @override
  List<Object> get props => [paymentId];
}
