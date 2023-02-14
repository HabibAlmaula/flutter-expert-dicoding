part of 'detail_tv_bloc.dart';

class DetailTvState extends Equatable {
  final TvDetail? tvDetail;
  final List<Tv> tvRecommendations;

  final RequestState tvDetailRequestState;
  final RequestState tvRecommendationsRequestState;
  final bool isSavedToWatchList;

  final String tvDetailRemoteMessage;
  final String tvRecommendationRemoteMessage;

  final String watchListMessage;

  const DetailTvState(
      {this.tvDetail,
      this.tvRecommendations = const [],
      this.tvDetailRequestState = RequestState.Empty,
      this.tvRecommendationsRequestState = RequestState.Empty,
      this.isSavedToWatchList = false,
      this.tvDetailRemoteMessage = '',
      this.tvRecommendationRemoteMessage = '',
      this.watchListMessage = ''});

  //populate state
  DetailTvState initialDetail() => copyWith(
        tvDetailRequestState: RequestState.Empty,
        tvRecommendationsRequestState: RequestState.Empty,
      );

  DetailTvState detailTvLoading() => copyWith(
        tvDetailRequestState: RequestState.Loading,
      );

  DetailTvState recommendationTvLoading() => copyWith(
        tvRecommendationsRequestState: RequestState.Loading,
      );

  DetailTvState detailTvHasData({required TvDetail data}) => copyWith(
        tvDetail: data,
        tvDetailRequestState: RequestState.Loaded,
      );

  DetailTvState detailTvError({required String message}) => copyWith(
        tvDetailRequestState: RequestState.Error,
        tvDetailRemoteMessage: message,
      );

  DetailTvState recommendationTvHasData({required List<Tv> data}) => copyWith(
        tvRecommendationsRequestState: RequestState.Loaded,
        tvRecommendations: data,
      );

  DetailTvState recommendationTvError({required String message}) => copyWith(
        tvRecommendationsRequestState: RequestState.Error,
        tvRecommendationRemoteMessage: message,
      );

  DetailTvState copyWith({
    TvDetail? tvDetail,
    List<Tv>? tvRecommendations,
    RequestState? tvDetailRequestState,
    RequestState? tvRecommendationsRequestState,
    bool? isSavedToWatchList,
    String? tvDetailRemoteMessage,
    String? tvRecommendationRemoteMessage,
    String? watchListMessage,
  }) {
    return DetailTvState(
      tvDetail: tvDetail ?? this.tvDetail,
      tvRecommendations: tvRecommendations ?? this.tvRecommendations,
      tvDetailRequestState: tvDetailRequestState ?? this.tvDetailRequestState,
      tvRecommendationsRequestState:
          tvRecommendationsRequestState ?? this.tvRecommendationsRequestState,
      isSavedToWatchList: isSavedToWatchList ?? this.isSavedToWatchList,
      tvDetailRemoteMessage:
          tvDetailRemoteMessage ?? this.tvDetailRemoteMessage,
      tvRecommendationRemoteMessage:
          tvRecommendationRemoteMessage ?? this.tvRecommendationRemoteMessage,
      watchListMessage: watchListMessage ?? this.watchListMessage,
    );
  }

  @override
  List<Object?> get props => [
        tvDetail,
        tvRecommendations,
        tvDetailRequestState,
        tvRecommendationsRequestState,
        isSavedToWatchList,
        tvDetailRemoteMessage,
        tvRecommendationRemoteMessage,
        watchListMessage,
      ];
}
