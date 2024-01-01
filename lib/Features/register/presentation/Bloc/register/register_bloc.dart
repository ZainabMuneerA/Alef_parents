import 'package:alef_parents/Features/register/domain/usecase/register.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/Failure.dart';
import '../../../domain/entity/register.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc({required this.registerUseCase}) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async{
      if (event is RegisterUserEvent) {
        emit(LoadingRegisterState());

        try {
          final failureOrLoged = await registerUseCase(event.email,event.name, event.password);

          emit(_mapFailureOrRegisterToState(failureOrLoged));
        } catch (error) {
          // Emitting ErrorPreschoolState with an appropriate error message
          emit(ErrorRegisterState(message: 'An error occurred'));
        }
      }
    });
  }
}
 RegisterState _mapFailureOrRegisterToState(
      Either<Failure, Register> either) {
    return either.fold(
      (failure) => ErrorRegisterState(message: _mapFailureToMessage(failure)),
      (register) => LoadedRegisterState(register: register),
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
