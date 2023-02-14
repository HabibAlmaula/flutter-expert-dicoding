import 'package:core/core.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watch_list_movie_event.dart';

part 'watch_list_movie_state.dart';

class WatchListMovieBloc
    extends Bloc<WatchListMovieEvent, WatchListMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;

  WatchListMovieBloc({required GetWatchlistMovies getWatchlistMovies})
      : _getWatchlistMovies = getWatchlistMovies,
        super(const WatchListMovieState()) {
    on<OnLoadWatchListMovie>(_onLoadWatchListMove);
  }

  void _onLoadWatchListMove(
      OnLoadWatchListMovie event, Emitter<WatchListMovieState> emit) async {
    emit(state.watchListLoading());
    final result = await _getWatchlistMovies.execute();
    result.fold((l) {
      emit(state.watchListError(errMessage: l.message));
    }, (r) {
      emit(state.watchListHasData(movies: r));
    });
  }
}
