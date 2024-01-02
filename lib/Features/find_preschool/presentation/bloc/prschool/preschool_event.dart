

part of 'preschool_bloc.dart';

abstract class PreschoolEvent extends Equatable {
  const PreschoolEvent();
  List<Object> get props => [];
}
class getAllPreschoolEvent extends PreschoolEvent{}

class RefreshPreschoolEvent extends PreschoolEvent{}
