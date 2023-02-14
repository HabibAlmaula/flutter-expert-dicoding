part of 'search_movie_bloc.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();
}

class SearchEmpty extends SearchMovieState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchMovieState {
  @override
  List<Object?> get props => [];
}

class SearchError extends SearchMovieState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchHasData extends SearchMovieState {
  final List<Movie> result;

  const SearchHasData(this.result);

  @override
  List<Object?> get props => [result];
}
