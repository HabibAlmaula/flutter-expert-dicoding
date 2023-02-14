import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/pages/watch_list/bloc/watch_list_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';


class MockGetWatchListTv extends Mock implements GetWatchlistTv {}

void main() {
  late WatchListTvBloc watchListTvBloc;
  late MockGetWatchListTv mockGetWatchListTv;

  setUp(() {
    mockGetWatchListTv = MockGetWatchListTv();
    watchListTvBloc =
        WatchListTvBloc(getWatchlistTv: mockGetWatchListTv);
  });

  test('initial state should be empty', () {
    expect(watchListTvBloc.state, const WatchListTvState());
  });

  blocTest<WatchListTvBloc, WatchListTvState>(
      'should change movies data when data is gotten successfully',
      build: () {
        when(() => mockGetWatchListTv.execute())
            .thenAnswer((realInvocation) async => Right([testWatchlistTv]));
        return watchListTvBloc;
      },
      act: (bloc) => bloc.add(OnLoadWatchListTv()),
      expect: () => [
        const WatchListTvState().watchListLoading(),
        const WatchListTvState()
            .watchListHasData(tv: [testWatchlistTv]),
      ],
      verify: (bloc) {
        verify(() => mockGetWatchListTv.execute());
      });

  blocTest<WatchListTvBloc, WatchListTvState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => mockGetWatchListTv.execute())
            .thenAnswer((realInvocation) async => const Left(DatabaseFailure("Can't get data")));
        return watchListTvBloc;
      },
      act: (bloc) => bloc.add(OnLoadWatchListTv()),
      expect: () => [
        const WatchListTvState().watchListLoading(),
        const WatchListTvState().watchListError(errMessage: "Can't get data")
      ],
      verify: (bloc) {
        verify(() => mockGetWatchListTv.execute());
      });
}
