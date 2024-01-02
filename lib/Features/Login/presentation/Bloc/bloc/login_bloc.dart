import 'package:alef_parents/Features/Login/domain/entity/login.dart';
import 'package:alef_parents/Features/Login/domain/usecases/login.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/Failure.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({
    required this.loginUseCase,
  }) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async{
    if (event is LogUserEvent) {
        emit(LoadingLoginState());

        try {
          // Debug statement to indicate that the event is being processed
          print('Event: $event');

          final failureOrLoged = await loginUseCase(event.email, event.password);

          // Debug statement to indicate the result of the getAllPreschool() function
          print('loging in bloc result: $failureOrLoged');

          emit(_mapFailureOrLogedToState(failureOrLoged));
        } catch (error) {
          // Debug statement to indicate any errors that occur during event processing
          print('Error during event processing: $error');

          // Emitting ErrorPreschoolState with an appropriate error message
          emit(ErrorLoginState(message: 'An error occurred'));
        }
      }
    });
  }


  LoginState _mapFailureOrLogedToState(
      Either<Failure, Login> either) {
    return either.fold(
      (failure) => ErrorLoginState(message: _mapFailureToMessage(failure)),
      (login) => LoadedLoginState(login: login),
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
}
