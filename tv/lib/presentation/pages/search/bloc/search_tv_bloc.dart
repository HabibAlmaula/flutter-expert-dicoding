import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecases/tv/search_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tv_event.dart';

part 'search_tv_state.dart';

EventTransformer<E> debounce<E>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTv _searchTv;

  SearchTvBloc({required SearchTv searchTv})
      : _searchTv = searchTv,
        super(SearchEmpty()) {
    on<OnQueryChanged>(_onQueryChanged,
        transformer: debounce(const Duration(milliseconds: 700)));
  }

  void _onQueryChanged(
      OnQueryChanged event, Emitter<SearchTvState> emit) async {
    final query = event.query;
    emit(SearchLoading());

    final result = await _searchTv.execute(query);
    result.fold((l) {
      emit(SearchError(l.message));
    }, (r) {
      emit(SearchHasData(r));
    });
  }
}
