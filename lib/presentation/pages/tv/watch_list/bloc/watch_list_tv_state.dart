part of 'watch_list_tv_bloc.dart';

class WatchListTvState extends Equatable {
  final List<Tv> tv;
  final RequestState requestState;
  final String message;

  const WatchListTvState({
    this.tv = const [],
    this.requestState = RequestState.Empty,
    this.message = "",
  });

  watchListLoading() => copyWith(requestState: RequestState.Loading);

  watchListHasData({required List<Tv> tv}) =>
      copyWith(requestState: RequestState.Loaded, tv: tv);

  watchListError({required String errMessage}) =>
      copyWith(requestState: RequestState.Error, message: errMessage);

  WatchListTvState copyWith(
      {List<Tv>? tv, RequestState? requestState, String? message}) {
    return WatchListTvState(
        tv: tv ?? this.tv,
        requestState: requestState ?? this.requestState,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [tv, requestState, message];
}
