import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  // const Failure([List properties = const <dynamic>[]]) : super();
}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  final String? message;

  ServerFailure({this.message});
  @override
  List<Object?> get props => [message];
}
class NoDataYetFailure extends Failure {
  final String message;

  NoDataYetFailure({required this.message});

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return 'NoDataYetFailure: $message';
  }
}

class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}
