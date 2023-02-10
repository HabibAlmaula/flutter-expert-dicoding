part of 'detail_movie_bloc.dart';

class DetailMovieState extends Equatable {
  final MovieDetail? movieDetail;
  final List<Movie> movieRecommendations;

  final RequestState movieDetailRequestState;
  final RequestState movieRecommendationsRequestState;
  final bool isSavedToWatchList;

  final String movieDetailRemoteMessage;
  final String movieRecommendationRemoteMessage;

  final String watchListMessage;

  const DetailMovieState(
      {this.movieDetail,
      this.movieRecommendations = const [],
      this.movieDetailRequestState = RequestState.Empty,
      this.movieRecommendationsRequestState = RequestState.Empty,
      this.isSavedToWatchList = false,
      this.movieDetailRemoteMessage = '',
      this.movieRecommendationRemoteMessage = '',
      this.watchListMessage = ''});

  //populate state
  DetailMovieState initialDetail() => copyWith(
        movieDetailRequestState: RequestState.Empty,
        movieRecommendationsRequestState: RequestState.Empty,
      );

  DetailMovieState detailMovieLoading() => copyWith(
        movieDetailRequestState: RequestState.Loading,
      );

  DetailMovieState recommendationMovieLoading() => copyWith(
        movieRecommendationsRequestState: RequestState.Loading,
      );

  DetailMovieState detailMovieHasData({required MovieDetail data}) => copyWith(
        movieDetail: data,
        movieDetailRequestState: RequestState.Loaded,
      );

  DetailMovieState detailMovieError({required String message}) => copyWith(
        movieDetailRequestState: RequestState.Error,
        movieDetailRemoteMessage: message,
      );

  DetailMovieState recommendationMovieHasData({required List<Movie> data}) =>
      copyWith(
        movieRecommendationsRequestState: RequestState.Loaded,
        movieRecommendations: data,
      );

  DetailMovieState recommendationMovieError({required String message}) =>
      copyWith(
        movieRecommendationsRequestState: RequestState.Error,
        movieRecommendationRemoteMessage: message,
      );


  DetailMovieState copyWith({
    MovieDetail? movieDetail,
    List<Movie>? movieRecommendations,
    RequestState? movieDetailRequestState,
    RequestState? movieRecommendationsRequestState,
    bool? isSavedToWatchList,
    String? movieDetailRemoteMessage,
    String? movieRecommendationRemoteMessage,
    String? watchListMessage,
  }) {
    return DetailMovieState(
      movieDetail: movieDetail ?? this.movieDetail,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      movieDetailRequestState:
          movieDetailRequestState ?? this.movieDetailRequestState,
      movieRecommendationsRequestState: movieRecommendationsRequestState ??
          this.movieRecommendationsRequestState,
      isSavedToWatchList: isSavedToWatchList ?? this.isSavedToWatchList,
      movieDetailRemoteMessage:
          movieDetailRemoteMessage ?? this.movieDetailRemoteMessage,
      movieRecommendationRemoteMessage: movieRecommendationRemoteMessage ??
          this.movieRecommendationRemoteMessage,
      watchListMessage: watchListMessage ?? this.watchListMessage,
    );
  }

  @override
  List<Object?> get props => [
        movieDetail,
        movieRecommendations,
        movieDetailRequestState,
        movieRecommendationsRequestState,
        isSavedToWatchList,
        movieDetailRemoteMessage,
        movieRecommendationRemoteMessage,
        watchListMessage,
      ];
}
