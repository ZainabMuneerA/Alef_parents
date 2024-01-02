import 'package:alef_parents/Features/payment/domain/entity/paid.dart';
import 'package:alef_parents/Features/payment/domain/entity/fees.dart';
import 'package:alef_parents/Features/payment/domain/usecases/get_fees.dart';
import 'package:alef_parents/Features/payment/domain/usecases/update_payment.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:alef_parents/core/error/map_failure_to_msg.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'fees_event.dart';
part 'fees_state.dart';

class FeesBloc extends Bloc<FeesEvent, FeesState> {
  final GetFeesUseCase feesUseCase;
  final PaidFeesUseCase paidFeesUseCase;
  FeesBloc({required this.feesUseCase, required this.paidFeesUseCase})
      : super(FeesInitial()) {
    on<FeesEvent>((event, emit) async {
      if (event is GetFeesEvent) {
        emit(LoadingFeesState());

        try {
          // Debug statement to indicate that the event is being processed
          print('Event: $event');

          final failureOrFees = await feesUseCase(event.studentId);

          // Debug statement to indicate the result of the getAllPreschool() function
          print('register in bloc result: $failureOrFees');

          emit(_mapFailureOrFeesToState(failureOrFees));
        } catch (error) {
          // Debug statement to indicate any errors that occur during event processing
          print('Error during event processing: $error');

          // Emitting with an appropriate error message
          emit(ErrorFeesState(message: 'An error occurred'));
        }
      }

      if (event is PaidFeesEvent) {
        emit(LoadingFeesState());

        try {
          // Debug statement to indicate that the event is being processed
          print('Event: $event');

          final failureOrFees = await paidFeesUseCase(event.paymentId);

          // Debug statement to indicate the result of the getAllPreschool() function
          print('register in bloc result: $failureOrFees');

          emit(_mapFailureOrPaidToState(failureOrFees));
        } catch (error) {
          // Debug statement to indicate any errors that occur during event processing
          print('Error during event processing: $error');

          // Emitting  with an appropriate error message
          emit(ErrorFeesState(message: 'An error occurred'));
        }
      }
    });
  }
}

FeesState _mapFailureOrFeesToState(Either<Failure, List<Fees>> either) {
  return either.fold(
    (failure) => ErrorFeesState(message: mapFailureToMessage(failure)),
    (fees) => LoadedFeesState(fees: fees),
  );
}

FeesState _mapFailureOrPaidToState(Either<Failure, Paid> either) {
  return either.fold(
    (failure) => ErrorFeesState(message: mapFailureToMessage(failure)),
    (paid) => LoadedPaidFeesState(paid: paid),
  );
}
