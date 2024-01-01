import 'package:alef_parents/Features/outstanding/domain/entities/bill.dart';
import 'package:alef_parents/Features/outstanding/domain/entities/outstanding.dart';
import 'package:alef_parents/Features/outstanding/domain/usecases/get_outstanding_usecase.dart';
import 'package:alef_parents/Features/outstanding/domain/usecases/update_outstanding_usecase.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:alef_parents/core/error/map_failure_to_msg.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'outstanding_event.dart';
part 'outstanding_state.dart';

class OutstandingBloc extends Bloc<OutstandingEvent, OutstandingState> {
  final GetOutstandingUsecase outstandingUsecase;
  final UpadteOutstandingUsecase upadteOutstanding;
  OutstandingBloc({
    required this.outstandingUsecase,
    required this.upadteOutstanding,
  }) : super(OutstandingInitial()) {
    on<OutstandingEvent>((event, emit) async {
      if (event is GetOutstandingEvent) {
        emit(LoadingOutstandingState());
        try {
          final failureOrOutstanding =
              await outstandingUsecase(event.studentId);
          emit(_mapFailureOrOutstandingToState(failureOrOutstanding));
        } catch (e) {
          print("error in outstanding bloc $e");
          emit(ErrorOutstandingState(message: "An error occured: $e"));
        }
      }

      if (event is UpdateOutstandingEvent) {
        emit(LoadingOutstandingState());
        try {
          final failureOrUpdate = await upadteOutstanding(event.paymentId);
          emit(_mapFailureOrUpdateToState(failureOrUpdate));
        } catch (e) {
          print("error in outstanding bloc $e");
          emit(ErrorOutstandingState(message: "An error occured: $e"));
        }
      }
    });
  }
}

OutstandingState _mapFailureOrOutstandingToState(
    Either<Failure, List<Outstanding>> either) {
  return either.fold(
      (failure) => ErrorOutstandingState(message: mapFailureToMessage(failure)),
      (outstanding) => LoadedOutstandingState(outstanding: outstanding));
}

OutstandingState _mapFailureOrUpdateToState(Either<Failure, Bill> either) {
  return either.fold(
      (failure) => ErrorOutstandingState(message: mapFailureToMessage(failure)),
      (bill) => LoadedUpdateOutstandingState(bill: bill));
}
