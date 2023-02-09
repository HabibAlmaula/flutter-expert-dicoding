part of 'detail_tv_bloc.dart';

abstract class DetailTvEvent extends Equatable {
  const DetailTvEvent();
}
class OnLoadTvDetail extends DetailTvEvent {
  final dynamic tvId;

  const OnLoadTvDetail({required this.tvId});

  @override
  List<Object?> get props => [tvId];
}

class OnLoadTvRecommendations extends DetailTvEvent {
  final dynamic tvId;

  const OnLoadTvRecommendations({required this.tvId});

  @override
  List<Object?> get props => [tvId];
}

class OnLoadWatchListTvStatus extends DetailTvEvent {
  final dynamic tvId;

  const OnLoadWatchListTvStatus({required this.tvId});

  @override
  List<Object?> get props => [tvId];
}

class OnSaveTvToWatchList extends DetailTvEvent {
  final TvDetail tvData;

  const OnSaveTvToWatchList({required this.tvData});

  @override
  List<Object?> get props => [tvData];
}

class OnRemoveTvFromWatchList extends DetailTvEvent {
  final TvDetail tvData;

  const OnRemoveTvFromWatchList({required this.tvData});

  @override
  List<Object?> get props => [tvData];
}
