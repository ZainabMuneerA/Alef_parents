part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetPreschoolByIdEvent extends SearchEvent {
  final int id;

  GetPreschoolByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetPreschoolByNameEvent extends SearchEvent{
final String name;

  GetPreschoolByNameEvent(this.name);

  @override
  List<Object> get props => [name];
}
