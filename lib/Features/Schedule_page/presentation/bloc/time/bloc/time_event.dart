part of 'time_bloc.dart';

sealed class TimeEvent extends Equatable {
  const TimeEvent();

  @override
  List<Object> get props => [];
}

class GetAvailableTime extends TimeEvent {
  final int preschool;
  final String date;

  const GetAvailableTime(this.preschool, this.date);

  @override
  List<Object> get props => [preschool, date];
}
