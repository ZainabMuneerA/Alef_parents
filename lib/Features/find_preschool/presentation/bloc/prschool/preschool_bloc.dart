import 'package:alef_parents/Features/find_preschool/domain/usecases/get_all_preschool.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/preschool.dart';
part 'preschool_state.dart';
part 'preschool_event.dart';

class PreschoolBloc extends Bloc<PreschoolEvent, PreschoolState> {
  final GetAllPreschoolsUseCase getAllPreschool;

  PreschoolBloc({
    required this.getAllPreschool,
  }) : super(PreschoolInitial()) {
    on<PreschoolEvent>((event, emit) async {
      if (event is getAllPreschoolEvent || event is RefreshPreschoolEvent) {
        emit(LoadingPreschoolState());

        try {
       
//get the preschool 
          final failureOrPreschool = await getAllPreschool();

          emit(_mapFailureOrPreschoolToState(failureOrPreschool));
        } catch (error) {

          // Emitting ErrorPreschoolState with an appropriate error message
          emit(const ErrorPreschoolState(message: 'An error occurred'));
        }
      }
    });
  }

  PreschoolState _mapFailureOrPreschoolToState(
      Either<Failure, List<Preschool>> either) {
    return either.fold(
      (failure) => ErrorPreschoolState(message: _mapFailureToMessage(failure)),
      (preschool) => LoadedPreschoolState(preschool: preschool),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    // Map different Failure types to corresponding error messages
    if (failure is ServerFailure) {
      return 'Server failure';
    } else if (failure is EmptyCacheFailure) {
      return 'Empty cache failure';
    } else if (failure is OfflineFailure) {
      return 'Offline failure';
    } else {
      return 'Unexpected error occurred';
    }
  }
}
