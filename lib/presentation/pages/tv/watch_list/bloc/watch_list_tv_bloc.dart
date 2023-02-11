import 'package:bloc/bloc.dart';
import 'package:ditonton/common/app_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

part 'watch_list_tv_event.dart';

part 'watch_list_tv_state.dart';

class WatchListTvBloc extends Bloc<WatchListTvEvent, WatchListTvState> {
  final GetWatchlistTv _getWatchlistTv;

  WatchListTvBloc({required GetWatchlistTv getWatchlistTv})
      : _getWatchlistTv = getWatchlistTv,
        super(WatchListTvState()) {
    on<OnLoadWatchListTv>(_onLoadWatchListTv);
  }

  void _onLoadWatchListTv(
      OnLoadWatchListTv event, Emitter<WatchListTvState> emit) async {
    emit(state.watchListLoading());
    final result = await _getWatchlistTv.execute();
    result.fold((l) {
      emit(state.watchListError(errMessage: l.message));
    }, (r) {
      emit(state.watchListHasData(tv: r));
    });
  }
}
