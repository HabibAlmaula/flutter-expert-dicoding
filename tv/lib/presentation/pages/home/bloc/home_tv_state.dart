part of 'home_tv_bloc.dart';

class HomeTvState extends Equatable {
  final List<Tv> nowPlayingTv;
  final List<Tv> popularTv;
  final List<Tv> topRatedTv;

  final RequestState nowPlayingTvState;
  final RequestState popularTvState;
  final RequestState topRatedTvState;

  final String nowPlayingTvMessage;
  final String popularTvMessage;
  final String topRatedTvMessage;

  const HomeTvState(
      {this.nowPlayingTv = const [],
      this.popularTv = const [],
      this.topRatedTv = const [],
      this.nowPlayingTvState = RequestState.Empty,
      this.popularTvState = RequestState.Empty,
      this.topRatedTvState = RequestState.Empty,
      this.nowPlayingTvMessage = '',
      this.popularTvMessage = '',
      this.topRatedTvMessage = ''});

  initialState() => copyWith(
      nowPlayingTvState: RequestState.Empty,
      popularTvState: RequestState.Empty,
      topRatedTvState: RequestState.Empty);

  HomeTvState nowPlayingEmpty() =>
      copyWith(nowPlayingTvState: RequestState.Empty);

  HomeTvState popularEmpty() => copyWith(popularTvState: RequestState.Empty);

  HomeTvState topRatedEmpty() => copyWith(topRatedTvState: RequestState.Empty);

  HomeTvState nowPlayingLoading() =>
      copyWith(nowPlayingTvState: RequestState.Loading);

  HomeTvState popularLoading() =>
      copyWith(popularTvState: RequestState.Loading);

  HomeTvState topRatedLoading() =>
      copyWith(topRatedTvState: RequestState.Loading);

  HomeTvState nowPlayingError({required String message}) => copyWith(
      nowPlayingTvState: RequestState.Error, nowPlayingTvMessage: message);

  HomeTvState popularError({required String message}) =>
      copyWith(popularTvState: RequestState.Error, popularTvMessage: message);

  HomeTvState topRatedError({required String message}) =>
      copyWith(topRatedTvState: RequestState.Error, topRatedTvMessage: message);

  HomeTvState nowPlayingHasData({required List<Tv> result}) =>
      copyWith(nowPlayingTv: result, nowPlayingTvState: RequestState.Loaded);

  HomeTvState popularHasData({required List<Tv> result}) =>
      copyWith(popularTv: result, popularTvState: RequestState.Loaded);

  HomeTvState topRatedHasData({required List<Tv> result}) =>
      copyWith(topRatedTv: result, topRatedTvState: RequestState.Loaded);

  HomeTvState copyWith({
    List<Tv>? nowPlayingTv,
    List<Tv>? popularTv,
    List<Tv>? topRatedTv,
    RequestState? nowPlayingTvState,
    RequestState? popularTvState,
    RequestState? topRatedTvState,
    String? nowPlayingTvMessage,
    String? popularTvMessage,
    String? topRatedTvMessage,
  }) {
    return HomeTvState(
        nowPlayingTv: nowPlayingTv ?? this.nowPlayingTv,
        popularTv: popularTv ?? this.popularTv,
        topRatedTv: topRatedTv ?? this.topRatedTv,
        nowPlayingTvState: nowPlayingTvState ?? this.nowPlayingTvState,
        popularTvState: popularTvState ?? this.popularTvState,
        topRatedTvState: topRatedTvState ?? this.topRatedTvState,
        nowPlayingTvMessage: nowPlayingTvMessage ?? this.nowPlayingTvMessage,
        popularTvMessage: popularTvMessage ?? this.popularTvMessage,
        topRatedTvMessage: topRatedTvMessage ?? this.topRatedTvMessage);
  }

  @override
  List<Object?> get props => [
        nowPlayingTv,
        popularTv,
        topRatedTv,
        nowPlayingTvState,
        popularTvState,
        topRatedTvState,
        nowPlayingTvMessage,
        popularTvMessage,
        topRatedTvMessage,
      ];
}
