import 'package:core/core.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:core/domain/usecases/tv/get_tv_detail.dart';
import 'package:core/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:core/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:core/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_tv_event.dart';

part 'detail_tv_state.dart';

class DetailTvBloc extends Bloc<DetailTvEvent, DetailTvState> {
  final GetTvDetail _getTvDetail;
  final GetTvRecommendations _getTvRecommendations;
  final GetWatchListStatusTv _getWatchListStatusTv;
  final SaveWatchlistTv _saveWatchlistTv;
  final RemoveWatchlistTv _removeWatchlistTv;

  DetailTvBloc({
    required GetTvDetail getTvDetail,
    required GetTvRecommendations getTvRecommendations,
    required GetWatchListStatusTv getWatchListStatusTv,
    required SaveWatchlistTv saveWatchlistTv,
    required RemoveWatchlistTv removeWatchlistTv,
  })  : _getTvDetail = getTvDetail,
        _getTvRecommendations = getTvRecommendations,
        _getWatchListStatusTv = getWatchListStatusTv,
        _saveWatchlistTv = saveWatchlistTv,
        _removeWatchlistTv = removeWatchlistTv,
        super(const DetailTvState()) {
    on<OnLoadTvDetail>(_onLoadTvDetail);
    on<OnLoadTvRecommendations>(_onLoadTvRecommendations);
    on<OnLoadWatchListTvStatus>(_onLoadWatchListTvStatus);

    on<OnSaveTvToWatchList>(_onSaveTvToWatchList);
    on<OnRemoveTvFromWatchList>(_onRemoveTvFromWatchList);
  }

  //function
  void _onLoadTvDetail(
      OnLoadTvDetail event, Emitter<DetailTvState> emit) async {
    emit(state.detailTvLoading());
    final result = await _getTvDetail.execute(event.tvId);

    result.fold((l) {
      emit(state.detailTvError(message: l.message));
    }, (r) {
      emit(state.detailTvHasData(data: r));
    });
  }

  void _onLoadTvRecommendations(
      OnLoadTvRecommendations event, Emitter<DetailTvState> emit) async {
    emit(state.recommendationTvLoading());
    final result = await _getTvRecommendations.execute(event.tvId);

    result.fold((l) {
      emit(state.recommendationTvError(message: l.message));
    }, (r) {
      emit(state.recommendationTvHasData(data: r));
    });
  }

  void _onLoadWatchListTvStatus(
      OnLoadWatchListTvStatus event, Emitter<DetailTvState> emit) async {
    final result = await _getWatchListStatusTv.execute(event.tvId);
    emit(state.copyWith(isSavedToWatchList: result));
  }

  void _onSaveTvToWatchList(
      OnSaveTvToWatchList event, Emitter<DetailTvState> emit) async {
    final result = await _saveWatchlistTv.execute(event.tvData);

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

  void _onRemoveTvFromWatchList(
      OnRemoveTvFromWatchList event, Emitter<DetailTvState> emit) async {
    final result = await _removeWatchlistTv.execute(event.tvData);

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
