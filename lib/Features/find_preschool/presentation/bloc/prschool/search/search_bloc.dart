import 'package:alef_parents/Features/find_preschool/domain/entity/preschool.dart';
import 'package:alef_parents/Features/find_preschool/domain/usecases/get_preschool_by_id.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/Failure.dart';
import '../../../../domain/usecases/get_preschool_by_name.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetPreschoolByIdUseCase getPreschoolById;
  final GetPreschoolByNameUseCase getPreschoolByName;

  SearchBloc({
    required this.getPreschoolById,
    required this.getPreschoolByName,
  }) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      if (event is GetPreschoolByIdEvent) {
        emit(LoadingSearchState());

        try {
          final failureOrPreschool = await getPreschoolById(event.id);
          // Debug statement to indicate the result of the get Preschool(id) function
          print('getAllPreschool result: $failureOrPreschool');

          emit(_mapFailureOrPreschoolIDToState(failureOrPreschool));
        } catch (e) {
          print("Found an error: $e");
          emit(ErrorSearchState(message: "An Error Occurred"));
        }
      }
      if (event is GetPreschoolByNameEvent) {
        emit(LoadingSearchState());

        try {
          final failureOrPreschool = await getPreschoolByName(event.name);
          // Debug statement to indicate the result of the get Preschool(id) function
          print('getAllPreschool result: $failureOrPreschool');

          emit(_mapFailureOrPreschoolToState(failureOrPreschool));
        } catch (e) {
          print("Found an error: $e");
          emit(ErrorSearchState(message: "An Error Occurred"));
        }
      }
    });
  }

  SearchState _mapFailureOrPreschoolToState(
      Either<Failure, List<Preschool>> either) {
    return either.fold(
      (failure) => ErrorSearchState(message: _mapFailureToMessage(failure)),
      (preschool) => LoadedSearchState(preschool: preschool),
    );
  }

   SearchState _mapFailureOrPreschoolIDToState(
    Either<Failure, Preschool> either,
  ) {
    return either.fold(
      (failure) => ErrorSearchState(message: _mapFailureToMessage(failure)),
      (preschool) => LoadedSearchIdState(preschool: preschool),
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

//!testtt

// class SearchBloc extends Bloc<SearchEvent, SearchState> {
//   final GetPreschoolByIdUseCase getPreschoolById;
//   final GetPreschoolByNameUseCase getPreschoolByName;

//   SearchBloc({
//     required this.getPreschoolById,
//     required this.getPreschoolByName,
//   }) : super(SearchInitial());

//   @override
//   Stream<SearchState> mapEventToState(SearchEvent event) async* {
//     if (event is GetPreschoolByIdEvent) {
//       yield LoadingSearchState();

//       try {
//         final failureOrPreschool = await getPreschoolById(event.id);
//         print('getPreschoolById result: $failureOrPreschool');

//         yield failureOrPreschool.fold(
//           (failure) => ErrorSearchState(message: _mapFailureToMessage(failure)),
//           (preschool) => LoadedSearchState(preschool: preschool),
//         );
//       } catch (e) {
//         print("Found an error: $e");
//         yield ErrorSearchState(message: "An Error Occurred");
//       }
//     }

//     if (event is GetPreschoolByNameEvent) {
//       yield LoadingSearchState();

//       try {
//         final failureOrPreschool = await getPreschoolByName(event.name);
//         print('getPreschoolByName result: $failureOrPreschool');

//         yield failureOrPreschool.fold(
//           (failure) => ErrorSearchState(message: _mapFailureToMessage(failure)),
//           (preschool) => LoadedSearchState(preschool: preschool),
//         );
//       } catch (e) {
//         print("Found an error: $e");
//         yield ErrorSearchState(message: "An Error Occurred");
//       }
//     }
//   }

//   String _mapFailureToMessage(Failure failure) {
//     if (failure is ServerFailure) {
//       return 'Server failure';
//     } else if (failure is EmptyCacheFailure) {
//       return 'Empty cache failure';
//     } else if (failure is OfflineFailure) {
//       return 'Offline failure';
//     } else {
//       return 'Unexpected error occurred';
//     }
//   }
// }