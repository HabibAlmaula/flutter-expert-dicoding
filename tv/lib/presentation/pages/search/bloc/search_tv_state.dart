part of 'search_tv_bloc.dart';

abstract class SearchTvState extends Equatable {
  const SearchTvState();
}

class SearchEmpty extends SearchTvState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchTvState {
  @override
  List<Object?> get props => [];
}

class SearchError extends SearchTvState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchHasData extends SearchTvState {
  final List<Tv> result;

  const SearchHasData(this.result);

  @override
  List<Object?> get props => [result];
}
