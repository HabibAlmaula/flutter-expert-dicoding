part of 'home_movie_bloc.dart';

abstract class HomeMovieEvent extends Equatable {
  const HomeMovieEvent();
}

class OnLoadNowPlayingMovies extends HomeMovieEvent {
  @override
  List<Object> get props => [];
}

class OnLoadPopularMovies extends HomeMovieEvent {
  @override
  List<Object> get props => [];
}

class OnLoadTopRatedMovies extends HomeMovieEvent {
  @override
  List<Object> get props => [];
}
