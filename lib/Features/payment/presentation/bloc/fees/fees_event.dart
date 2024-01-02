part of 'fees_bloc.dart';

sealed class FeesEvent extends Equatable {
  const FeesEvent();

  @override
  List<Object> get props => [];
}

class GetFeesEvent extends FeesEvent {
  final int studentId;

  GetFeesEvent({required this.studentId});

  @override
  List<Object> get props => [studentId];
}

class PaidFeesEvent extends FeesEvent {
  final int paymentId;

  PaidFeesEvent({required this.paymentId});

  @override
  List<Object> get props => [paymentId];
}
