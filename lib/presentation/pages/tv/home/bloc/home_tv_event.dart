part of 'home_tv_bloc.dart';

@immutable
abstract class HomeTvEvent {}


class OnLoadNowPlayingTv extends HomeTvEvent {
  @override
  List<Object?> get props => [];
}

class OnLoadPopularTv extends HomeTvEvent {
  @override
  List<Object?> get props => [];
}

class OnLoadTopRatedTv extends HomeTvEvent {
  @override
  List<Object?> get props => [];
}