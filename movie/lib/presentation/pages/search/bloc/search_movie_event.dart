part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();
}

class OnQueryChanged extends SearchMovieEvent {
  final String query;

  const OnQueryChanged({required this.query});

  @override
  List<Object> get props => [query];
}
