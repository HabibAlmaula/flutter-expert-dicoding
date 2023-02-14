part of 'watch_list_movie_bloc.dart';

class WatchListMovieState extends Equatable {
  final List<Movie> movies;
  final RequestState requestState;
  final String message;

  const WatchListMovieState({
    this.movies = const [],
    this.requestState = RequestState.Empty,
    this.message = "",
  });

  WatchListMovieState watchListLoading() => copyWith(requestState: RequestState.Loading);

  WatchListMovieState watchListHasData({required List<Movie> movies}) =>
      copyWith(requestState: RequestState.Loaded, movies: movies);

  WatchListMovieState watchListError({required String errMessage}) =>
      copyWith(requestState: RequestState.Error, message: errMessage);

  WatchListMovieState copyWith(
      {List<Movie>? movies, RequestState? requestState, String? message}) {
    return WatchListMovieState(
        movies: movies ?? this.movies,
        requestState: requestState ?? this.requestState,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [movies, requestState, message];
}
