import 'package:bloc/bloc.dart';
import 'package:ditonton/common/app_enum.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'home_movie_event.dart';

part 'home_movie_state.dart';

class HomeMovieBloc extends Bloc<HomeMovieEvent, HomeMovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  final GetPopularMovies _getPopularMovies;
  final GetTopRatedMovies _getTopRatedMovies;

  HomeMovieBloc({
    required GetNowPlayingMovies getNowPlayingMovies,
    required GetPopularMovies getPopularMovies,
    required GetTopRatedMovies getTopRatedMovies,
  })  : _getNowPlayingMovies = getNowPlayingMovies,
        _getPopularMovies = getPopularMovies,
        _getTopRatedMovies = getTopRatedMovies,
        super(HomeMovieState()) {
    on<OnLoadNowPlayingMovies>(_onLoadNowPlayingMovies);
    on<OnLoadPopularMovies>(_onLoadPopularMovies);
    on<OnLoadTopRatedMovies>(_onLoadTopRatedMovies);
  }

  void _onLoadNowPlayingMovies(
      OnLoadNowPlayingMovies event, Emitter<HomeMovieState> emit) async {
    emit(state.nowPlayingLoading());
    final result = await _getNowPlayingMovies.execute();
    result.fold((l) {
      emit(state.nowPlayingError(message: l.message));
    }, (r) {
      emit(state.nowPlayingHasData(result: r));
    });
  }

  void _onLoadPopularMovies(
      OnLoadPopularMovies event, Emitter<HomeMovieState> emit) async {
    emit(state.popularLoading());
    final result = await _getPopularMovies.execute();
    result.fold((l) {
      emit(state.popularError(message: l.message));
    }, (r) {
      emit(state.popularHasData(result: r));
    });
  }

  void _onLoadTopRatedMovies(
      OnLoadTopRatedMovies event, Emitter<HomeMovieState> emit) async {
    emit(state.topRatedLoading());
    final result = await _getTopRatedMovies.execute();
    result.fold((l) {
      emit(state.topRatedError(message: l.message));
    }, (r) {
      emit(state.topRatedHasData(result: r));
    });
  }
}
