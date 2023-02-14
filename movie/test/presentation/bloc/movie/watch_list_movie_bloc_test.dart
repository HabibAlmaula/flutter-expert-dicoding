import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/pages/watch_list/bloc/watch_list_movie_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetWatchListMovies extends Mock implements GetWatchlistMovies {}

void main() {
  late WatchListMovieBloc watchListMovieBloc;
  late MockGetWatchListMovies mockGetWatchListMovies;

  setUp(() {
    mockGetWatchListMovies = MockGetWatchListMovies();
    watchListMovieBloc =
        WatchListMovieBloc(getWatchlistMovies: mockGetWatchListMovies);
  });

  test('initial state should be empty', () {
    expect(watchListMovieBloc.state, const WatchListMovieState());
  });

  blocTest<WatchListMovieBloc, WatchListMovieState>(
      'should change movies data when data is gotten successfully',
      build: () {
        when(() => mockGetWatchListMovies.execute())
            .thenAnswer((realInvocation) async => Right([testWatchlistMovie]));
        return watchListMovieBloc;
      },
      act: (bloc) => bloc.add(OnLoadWatchListMovie()),
      expect: () => [
            const WatchListMovieState().watchListLoading(),
            const WatchListMovieState()
                .watchListHasData(movies: [testWatchlistMovie]),
          ],
      verify: (bloc) {
        verify(() => mockGetWatchListMovies.execute());
      });

  blocTest<WatchListMovieBloc, WatchListMovieState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => mockGetWatchListMovies.execute())
            .thenAnswer((realInvocation) async => const Left(DatabaseFailure("Can't get data")));
        return watchListMovieBloc;
      },
      act: (bloc) => bloc.add(OnLoadWatchListMovie()),
      expect: () => [
        const WatchListMovieState().watchListLoading(),
        const WatchListMovieState().watchListError(errMessage: "Can't get data")
      ],
      verify: (bloc) {
        verify(() => mockGetWatchListMovies.execute());
      });
}
