import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:ditonton/presentation/pages/tv/watch_list/bloc/watch_list_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetWatchListTv extends Mock implements GetWatchlistTv {}

void main() {
  late WatchListTvBloc _watchListTvBloc;
  late MockGetWatchListTv _mockGetWatchListTv;

  setUp(() {
    _mockGetWatchListTv = MockGetWatchListTv();
    _watchListTvBloc =
        WatchListTvBloc(getWatchlistTv: _mockGetWatchListTv);
  });

  test('initial state should be empty', () {
    expect(_watchListTvBloc.state, WatchListTvState());
  });

  blocTest<WatchListTvBloc, WatchListTvState>(
      'should change movies data when data is gotten successfully',
      build: () {
        when(() => _mockGetWatchListTv.execute())
            .thenAnswer((realInvocation) async => Right([testWatchlistTv]));
        return _watchListTvBloc;
      },
      act: (bloc) => bloc.add(OnLoadWatchListTv()),
      expect: () => [
        WatchListTvState().watchListLoading(),
        WatchListTvState()
            .watchListHasData(tv: [testWatchlistTv]),
      ],
      verify: (bloc) {
        verify(() => _mockGetWatchListTv.execute());
      });

  blocTest<WatchListTvBloc, WatchListTvState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => _mockGetWatchListTv.execute())
            .thenAnswer((realInvocation) async => Left(DatabaseFailure("Can't get data")));
        return _watchListTvBloc;
      },
      act: (bloc) => bloc.add(OnLoadWatchListTv()),
      expect: () => [
        WatchListTvState().watchListLoading(),
        WatchListTvState().watchListError(errMessage: "Can't get data")
      ],
      verify: (bloc) {
        verify(() => _mockGetWatchListTv.execute());
      });
}
