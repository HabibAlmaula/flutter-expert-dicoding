part of 'watch_list_movie_bloc.dart';

abstract class WatchListMovieEvent extends Equatable {
  const WatchListMovieEvent();
}

class OnLoadWatchListMovie extends WatchListMovieEvent {
  @override
  List<Object?> get props => [];
}
