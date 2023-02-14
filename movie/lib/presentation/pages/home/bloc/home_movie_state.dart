part of 'home_movie_bloc.dart';

class HomeMovieState extends Equatable {
  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;

  final RequestState nowPlayingMovieState;
  final RequestState popularMovieState;
  final RequestState topRatedMovieState;

  final String nowPlayingMovieMessage;
  final String popularMovieMessage;
  final String topRatedMovieMessage;

  const HomeMovieState(
      {this.nowPlayingMovies = const [],
      this.popularMovies = const [],
      this.topRatedMovies = const [],
      this.nowPlayingMovieState = RequestState.Empty,
      this.popularMovieState = RequestState.Empty,
      this.topRatedMovieState = RequestState.Empty,
      this.nowPlayingMovieMessage = '',
      this.popularMovieMessage = '',
      this.topRatedMovieMessage = ''});

  initialState() => copyWith(
      nowPlayingMovieState: RequestState.Empty,
      popularMovieState: RequestState.Empty,
      topRatedMovieState: RequestState.Empty);

  HomeMovieState nowPlayingLoading() =>
      copyWith(nowPlayingMovieState: RequestState.Loading);

  HomeMovieState popularLoading() =>
      copyWith(popularMovieState: RequestState.Loading);

  HomeMovieState topRatedLoading() =>
      copyWith(topRatedMovieState: RequestState.Loading);

  HomeMovieState nowPlayingError({required String message}) => copyWith(
      nowPlayingMovieState: RequestState.Error,
      nowPlayingMovieMessage: message);

  HomeMovieState popularError({required String message}) => copyWith(
      popularMovieState: RequestState.Error, popularMovieMessage: message);

  HomeMovieState topRatedError({required String message}) => copyWith(
      topRatedMovieState: RequestState.Error, topRatedMovieMessage: message);

  HomeMovieState nowPlayingHasData({required List<Movie> result}) => copyWith(
      nowPlayingMovies: result, nowPlayingMovieState: RequestState.Loaded);

  HomeMovieState popularHasData({required List<Movie> result}) =>
      copyWith(popularMovies: result, popularMovieState: RequestState.Loaded);

  HomeMovieState topRatedHasData({required List<Movie> result}) =>
      copyWith(topRatedMovies: result, topRatedMovieState: RequestState.Loaded);

  HomeMovieState copyWith({
    List<Movie>? nowPlayingMovies,
    List<Movie>? popularMovies,
    List<Movie>? topRatedMovies,
    RequestState? nowPlayingMovieState,
    RequestState? popularMovieState,
    RequestState? topRatedMovieState,
    String? nowPlayingMovieMessage,
    String? popularMovieMessage,
    String? topRatedMovieMessage,
  }) {
    return HomeMovieState(
        nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
        popularMovies: popularMovies ?? this.popularMovies,
        topRatedMovies: topRatedMovies ?? this.topRatedMovies,
        nowPlayingMovieState: nowPlayingMovieState ?? this.nowPlayingMovieState,
        popularMovieState: popularMovieState ?? this.popularMovieState,
        topRatedMovieState: topRatedMovieState ?? this.topRatedMovieState,
        nowPlayingMovieMessage:
            nowPlayingMovieMessage ?? this.nowPlayingMovieMessage,
        popularMovieMessage: popularMovieMessage ?? this.popularMovieMessage,
        topRatedMovieMessage:
            topRatedMovieMessage ?? this.topRatedMovieMessage);
  }

  @override
  List<Object?> get props => [
        nowPlayingMovies,
        popularMovies,
        topRatedMovies,
        nowPlayingMovieState,
        popularMovieState,
        topRatedMovieState,
        nowPlayingMovieMessage,
        popularMovieMessage,
        topRatedMovieMessage,
      ];
}
