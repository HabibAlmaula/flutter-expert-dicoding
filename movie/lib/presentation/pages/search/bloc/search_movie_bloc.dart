import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/usecases/movie/search_movies.dart';

import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_movie_event.dart';

part 'search_movie_state.dart';

EventTransformer<E> debounce<E>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies _searchMovies;

  SearchMovieBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>(_onQueryChanged,
        transformer: debounce(const Duration(milliseconds: 700)));
  }

  void _onQueryChanged(OnQueryChanged event, Emitter<SearchMovieState> emit) async {
    final query = event.query;
    emit(SearchLoading());

    final result = await _searchMovies.execute(query);
    result.fold((l) {
      emit(SearchError(l.message));
    }, (r) {
      emit(SearchHasData(r));
    });
  }
}
