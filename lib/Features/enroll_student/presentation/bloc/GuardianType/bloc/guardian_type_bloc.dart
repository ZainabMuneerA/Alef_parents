import 'package:alef_parents/Features/enroll_student/domain/usecase/GuardianType.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/Failure.dart';
import '../../../../domain/entity/guardianType.dart';

part 'guardian_type_event.dart';
part 'guardian_type_state.dart';

class GuardianTypeBloc extends Bloc<GuardianTypeEvent, GuardianTypeState> {
  final GuardianTypeUseCase guardianTypeUseCase;

  GuardianTypeBloc({
    required this.guardianTypeUseCase,
  }) : super(GuardianTypeInitial()) {
    on<GuardianTypeEvent>((event, emit) async {
      if (event is GetGuardianTypeEvent) {
        emit(LoadingGuadianType());
        try {
          // Debug statement to indicate that the event is being processed
          print('Event: $event');

          final failureOrLoged = await guardianTypeUseCase();

          // Debug statement to indicate the result of the getAllPreschool() function
          print('loging in bloc result: $failureOrLoged');

          emit(_mapFailureOrGuardTypeToState(failureOrLoged));
        } catch (error) {
          // Debug statement to indicate any errors that occur during event processing
          print('Error during event processing: $error');

          // Emitting
          emit(ErrorGuadianType(message: 'An error occurred'));
        }
      }
    });
  }
}

GuardianTypeState _mapFailureOrGuardTypeToState(
    Either<Failure, List<GuardianType>> either) {
  return either.fold(
    (failure) => ErrorGuadianType(message: _mapFailureToMessage(failure)),
    (guardianType) => LoadedGuadianType(guardianType: guardianType),
  );
}

String _mapFailureToMessage(Failure failure) {
  // Map different Failure types to corresponding error messages
  if (failure is ServerFailure) {
    return 'Server failure';
  } else if (failure is OfflineFailure) {
    return 'Offline failure';
  } else {
    return 'Unexpected error occurred';
  }
}
