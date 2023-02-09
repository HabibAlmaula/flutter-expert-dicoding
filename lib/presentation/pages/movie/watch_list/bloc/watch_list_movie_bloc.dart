import 'package:bloc/bloc.dart';
import 'package:ditonton/common/app_enum.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';

part 'watch_list_movie_event.dart';

part 'watch_list_movie_state.dart';

class WatchListMovieBloc
    extends Bloc<WatchListMovieEvent, WatchListMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;

  WatchListMovieBloc({required GetWatchlistMovies getWatchlistMovies})
      : _getWatchlistMovies = getWatchlistMovies,
        super(WatchListMovieState()) {
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
