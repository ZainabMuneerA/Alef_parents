part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class LoadingSearchState extends SearchState {}

class LoadedSearchState extends SearchState {
  final List<Preschool>  preschool;

  LoadedSearchState({required this.preschool});

}
class LoadedGradesState extends SearchState {
  final List<String>  grades;

  LoadedGradesState({required this.grades});

}
class LoadedSearchIdState extends SearchState {
  final Preschool  preschool;

  LoadedSearchIdState({required this.preschool});

}

class ErrorSearchState extends SearchState {
  final String message;

  ErrorSearchState({required this.message});

  @override
  List<Object> get props => [message];
}
