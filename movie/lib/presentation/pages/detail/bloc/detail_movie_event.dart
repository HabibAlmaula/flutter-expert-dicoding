part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();
}

class OnLoadMovieDetail extends DetailMovieEvent {
  final dynamic movieId;

  const OnLoadMovieDetail({required this.movieId});

  @override
  List<Object> get props => [movieId];
}

class OnLoadMovieRecommendations extends DetailMovieEvent {
  final dynamic movieId;

  const OnLoadMovieRecommendations({required this.movieId});

  @override
  List<Object> get props => [movieId];
}

class OnLoadWatchListMovieStatus extends DetailMovieEvent {
  final dynamic movieId;

  const OnLoadWatchListMovieStatus({required this.movieId});

  @override
  List<Object> get props => [movieId];
}

class OnSaveMovieToWatchList extends DetailMovieEvent {
  final MovieDetail movieData;

  const OnSaveMovieToWatchList({required this.movieData});

  @override
  List<Object> get props => [movieData];
}

class OnRemoveMovieFromWatchList extends DetailMovieEvent {
  final MovieDetail movieData;

  const OnRemoveMovieFromWatchList({required this.movieData});

  @override
  List<Object> get props => [movieData];
}
