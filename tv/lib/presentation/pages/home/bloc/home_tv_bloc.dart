import 'package:core/core.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:core/domain/usecases/tv/get_popular_tv.dart';
import 'package:core/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_tv_event.dart';

part 'home_tv_state.dart';

class HomeTvBloc extends Bloc<HomeTvEvent, HomeTvState> {
  final GetNowPlayingTv _getNowPlayingTv;
  final GetPopularTv _getPopularTv;
  final GetTopRatedTv _getTopRatedTv;

  HomeTvBloc(
      {required GetNowPlayingTv getNowPlayingTv,
      required GetPopularTv getPopularTv,
      required GetTopRatedTv getTopRatedTv})
      : _getNowPlayingTv = getNowPlayingTv,
        _getPopularTv = getPopularTv,
        _getTopRatedTv = getTopRatedTv,
        super(const HomeTvState()) {
    on<OnLoadNowPlayingTv>(_onLoadNowPlayingTv);
    on<OnLoadPopularTv>(_onLoadPopularTv);
    on<OnLoadTopRatedTv>(_onLoadTopRatedTv);
  }

  void _onLoadNowPlayingTv(
      OnLoadNowPlayingTv event, Emitter<HomeTvState> emit) async {
    emit(state.nowPlayingLoading());
    final result = await _getNowPlayingTv.execute();
    result.fold((l) {
      emit(state.nowPlayingError(message: l.message));
    }, (r) {
      emit(state.nowPlayingHasData(result: r));
    });
  }

  void _onLoadPopularTv(
      OnLoadPopularTv event, Emitter<HomeTvState> emit) async {
    emit(state.popularLoading());
    final result = await _getPopularTv.execute();
    result.fold((l) {
      emit(state.popularError(message: l.message));
    }, (r) {
      emit(state.popularHasData(result: r));
    });
  }

  void _onLoadTopRatedTv(
      OnLoadTopRatedTv event, Emitter<HomeTvState> emit) async {
    emit(state.topRatedLoading());
    final result = await _getTopRatedTv.execute();
    result.fold((l) {
      emit(state.topRatedError(message: l.message));
    }, (r) {
      emit(state.topRatedHasData(result: r));
    });
  }
}
