import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/presentation/pages/movie/watch_list/bloc/watch_list_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetWatchListMovies extends Mock implements GetWatchlistMovies {}

void main() {
  late WatchListMovieBloc _watchListMovieBloc;
  late MockGetWatchListMovies _mockGetWatchListMovies;

  setUp(() {
    _mockGetWatchListMovies = MockGetWatchListMovies();
    _watchListMovieBloc =
        WatchListMovieBloc(getWatchlistMovies: _mockGetWatchListMovies);
  });

  test('initial state should be empty', () {
    expect(_watchListMovieBloc.state, WatchListMovieState());
  });

  blocTest<WatchListMovieBloc, WatchListMovieState>(
      'should change movies data when data is gotten successfully',
      build: () {
        when(() => _mockGetWatchListMovies.execute())
            .thenAnswer((realInvocation) async => Right([testWatchlistMovie]));
        return _watchListMovieBloc;
      },
      act: (bloc) => bloc.add(OnLoadWatchListMovie()),
      expect: () => [
            WatchListMovieState().watchListLoading(),
            WatchListMovieState()
                .watchListHasData(movies: [testWatchlistMovie]),
          ],
      verify: (bloc) {
        verify(() => _mockGetWatchListMovies.execute());
      });

  blocTest<WatchListMovieBloc, WatchListMovieState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => _mockGetWatchListMovies.execute())
            .thenAnswer((realInvocation) async => Left(DatabaseFailure("Can't get data")));
        return _watchListMovieBloc;
      },
      act: (bloc) => bloc.add(OnLoadWatchListMovie()),
      expect: () => [
        WatchListMovieState().watchListLoading(),
        WatchListMovieState().watchListError(errMessage: "Can't get data")
      ],
      verify: (bloc) {
        verify(() => _mockGetWatchListMovies.execute());
      });
}
