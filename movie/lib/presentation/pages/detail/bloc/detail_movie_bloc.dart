import 'package:core/common/app_enum.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/entities/movie/movie_detail.dart';
import 'package:core/domain/usecases/movie/get_movie_detail.dart';
import 'package:core/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movie/get_watchlist_status.dart';
import 'package:core/domain/usecases/movie/remove_watchlist.dart';
import 'package:core/domain/usecases/movie/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_movie_event.dart';

part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendation;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchList;
  final RemoveWatchlist _removeWatchList;

  DetailMovieBloc({
    required GetMovieDetail getMovieDetail,
    required GetMovieRecommendations getMovieRecommendations,
    required GetWatchListStatus getWatchListStatus,
    required SaveWatchlist saveWatchlist,
    required RemoveWatchlist removeWatchlist,
  })  : _getMovieDetail = getMovieDetail,
        _getMovieRecommendation = getMovieRecommendations,
        _getWatchListStatus = getWatchListStatus,
        _saveWatchList = saveWatchlist,
        _removeWatchList = removeWatchlist,
        super(const DetailMovieState()) {
    on<OnLoadMovieDetail>(_onLoadMovieDetail);
    on<OnLoadMovieRecommendations>(_onLoadMovieRecommendations);
    on<OnLoadWatchListMovieStatus>(_onLoadWatchListMovieStatus);

    on<OnSaveMovieToWatchList>(_onSaveMovieToWatchList);
    on<OnRemoveMovieFromWatchList>(_onRemoveMovieFromWatchList);
  }

  //function
  void _onLoadMovieDetail(
      OnLoadMovieDetail event, Emitter<DetailMovieState> emit) async {
    emit(state.detailMovieLoading());
    final result = await _getMovieDetail.execute(event.movieId);

    result.fold((l) {
      emit(state.detailMovieError(message: l.message));
    }, (r) {
      emit(state.detailMovieHasData(data: r));
    });
  }

  void _onLoadMovieRecommendations(
      OnLoadMovieRecommendations event, Emitter<DetailMovieState> emit) async {
    emit(state.recommendationMovieLoading());
    final result = await _getMovieRecommendation.execute(event.movieId);

    result.fold((l) {
      emit(state.recommendationMovieError(message: l.message));
    }, (r) {
      emit(state.recommendationMovieHasData(data: r));
    });
  }

  void _onLoadWatchListMovieStatus(
      OnLoadWatchListMovieStatus event, Emitter<DetailMovieState> emit) async {
    final result = await _getWatchListStatus.execute(event.movieId);
    emit(state.copyWith(isSavedToWatchList: result));
  }

  void _onSaveMovieToWatchList(
      OnSaveMovieToWatchList event, Emitter<DetailMovieState> emit) async {
    final result = await _saveWatchList.execute(event.movieData);

    result.fold(
        (l) => emit(state.copyWith(
              isSavedToWatchList: false,
              watchListMessage: l.message,
            )),
        (r) => emit(state.copyWith(
              isSavedToWatchList: true,
              watchListMessage: r,
            )));
  }

  void _onRemoveMovieFromWatchList(
      OnRemoveMovieFromWatchList event, Emitter<DetailMovieState> emit) async {
    final result = await _removeWatchList.execute(event.movieData);

    result.fold(
        (l) => emit(state.copyWith(
              isSavedToWatchList: true,
              watchListMessage: l.message,
            )),
        (r) => emit(state.copyWith(
              isSavedToWatchList: false,
              watchListMessage: r,
            )));
  }
}
