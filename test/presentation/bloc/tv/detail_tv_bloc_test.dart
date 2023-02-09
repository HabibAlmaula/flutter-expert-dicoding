import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:ditonton/presentation/pages/tv/detail/bloc/detail_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetTvDetail extends Mock implements GetTvDetail {}

class MockGetTvRecommendations extends Mock implements GetTvRecommendations {}

class MockGetWatchListStatus extends Mock implements GetWatchListStatusTv {}

class MockSaveWatchList extends Mock implements SaveWatchlistTv {}

class MockRemoveWatchList extends Mock implements RemoveWatchlistTv {}

void main() {
  late DetailTvBloc detailTvBloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchList mockSaveWatchList;
  late MockRemoveWatchList mockRemoveWatchList;

  final tId = 1;
  final isAdded = true;

  final tTv = Tv(
      backdropPath: '/ciToI1GfkWmzavJIPXh9Xe0Neon.jpg',
      firstAirDate: "2019-02-15",
      genreIds: [10759, 10765, 18],
      id: 75006,
      name: "The Umbrella Academy",
      originCountry: ["US"],
      originalLanguage: "en",
      originalName: "The Umbrella Academy",
      overview:
          "A dysfunctional family of superheroes comes together to solve the mystery of their father's death, the threat of the apocalypse and more.",
      popularity: 1577.649,
      posterPath: "/scZlQQYnDVlnpxFTxaIv2g0BWnL.jpg",
      voteAverage: 8.7,
      voteCount: 7926);
  final tTvList = <Tv>[tTv];

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchList = MockSaveWatchList();
    mockRemoveWatchList = MockRemoveWatchList();

    detailTvBloc = DetailTvBloc(
        getTvDetail: mockGetTvDetail,
        getTvRecommendations: mockGetTvRecommendations,
        getWatchListStatusTv: mockGetWatchListStatus,
        saveWatchlistTv: mockSaveWatchList,
        removeWatchlistTv: mockRemoveWatchList);
  });

  void _arrangeUsecase() {
    when(() => mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    when(() => mockGetTvRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvList));
  }

  group('Get Tv Detail', () {
    test('initial state should be Empty', () {
      expect(detailTvBloc.state, DetailTvState().initialDetail());
    });
    blocTest<DetailTvBloc, DetailTvState>(
        'should get tv detail data from the usecase',
        build: () {
          _arrangeUsecase();
          return detailTvBloc;
        },
        act: (bloc) => bloc.add(OnLoadTvDetail(tvId: tId)),
        verify: (bloc) {
          verify(() => mockGetTvDetail.execute(tId));
        });

    blocTest<DetailTvBloc, DetailTvState>(
        'should emit [Loading, HasData] when detail tv gotten successfully',
        build: () {
          _arrangeUsecase();
          return detailTvBloc;
        },
        act: (bloc) => bloc.add(OnLoadTvDetail(tvId: tId)),
        expect: () => [
              DetailTvState().detailTvLoading(),
              DetailTvState().detailTvHasData(data: testTvDetail)
            ],
        verify: (bloc) {
          verify(() => mockGetTvDetail.execute(tId));
        });

    blocTest<DetailTvBloc, DetailTvState>(
        'should emit [Loading, Error] when get detail tv unsuccessfully',
        build: () {
          when(() => mockGetTvDetail.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return detailTvBloc;
        },
        act: (bloc) => bloc.add(OnLoadTvDetail(tvId: tId)),
        expect: () => [
              DetailTvState().detailTvLoading(),
              DetailTvState().detailTvError(message: 'Server Failure')
            ],
        verify: (bloc) {
          verify(() => mockGetTvDetail.execute(tId));
        });
  });

  group('Get tv Recommendation', () {
    test('initial state should be Empty', () {
      expect(detailTvBloc.state, DetailTvState().initialDetail());
    });
    blocTest<DetailTvBloc, DetailTvState>(
        'should get tv recommendation data from the usecase',
        build: () {
          _arrangeUsecase();
          return detailTvBloc;
        },
        act: (bloc) => bloc.add(OnLoadTvRecommendations(tvId: tId)),
        verify: (bloc) {
          verify(() => mockGetTvRecommendations.execute(tId));
        });

    blocTest<DetailTvBloc, DetailTvState>(
        'should emit [Loading, HasData] when recommendation tv gotten successfully',
        build: () {
          _arrangeUsecase();
          return detailTvBloc;
        },
        act: (bloc) => bloc.add(OnLoadTvRecommendations(tvId: tId)),
        expect: () => [
              DetailTvState().recommendationTvLoading(),
              DetailTvState().recommendationTvHasData(data: tTvList)
            ],
        verify: (bloc) {
          verify(() => mockGetTvRecommendations.execute(tId));
        });

    blocTest<DetailTvBloc, DetailTvState>(
        'should emit [Loading, Error] when get recommendation tv unsuccessfully',
        build: () {
          when(() => mockGetTvRecommendations.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return detailTvBloc;
        },
        act: (bloc) => bloc.add(OnLoadTvRecommendations(tvId: tId)),
        expect: () => [
              DetailTvState().recommendationTvLoading(),
              DetailTvState().recommendationTvError(message: 'Server Failure')
            ],
        verify: (bloc) {
          verify(() => mockGetTvRecommendations.execute(tId));
        });
  });

  group('Get WatchList tv', () {
    test('initial state should be Empty', () {
      expect(detailTvBloc.state, DetailTvState().initialDetail());
    });
    blocTest<DetailTvBloc, DetailTvState>(
        'should get watchlist status from the usecase',
        build: () {
          when(() => mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => isAdded);
          return detailTvBloc;
        },
        act: (bloc) => bloc.add(OnLoadWatchListTvStatus(tvId: tId)),
        verify: (bloc) {
          verify(() => mockGetWatchListStatus.execute(tId));
        });

    blocTest<DetailTvBloc, DetailTvState>(
        'should execute save watchlist when function called',
        build: () {
          when(() => mockSaveWatchList.execute(testTvDetail))
              .thenAnswer((_) async => Right('Added to Watchlist'));
          return detailTvBloc;
        },
        act: (bloc) => bloc.add(OnSaveTvToWatchList(tvData: testTvDetail)),
        verify: (bloc) {
          verify(() => mockSaveWatchList.execute(testTvDetail));
        });

    blocTest<DetailTvBloc, DetailTvState>(
        'should execute remove watchlist when function called',
        build: () {
          when(() => mockRemoveWatchList.execute(testTvDetail))
              .thenAnswer((_) async => Right('Removed from Watchlist'));
          return detailTvBloc;
        },
        act: (bloc) => bloc.add(OnRemoveTvFromWatchList(tvData: testTvDetail)),
        verify: (bloc) {
          verify(() => mockRemoveWatchList.execute(testTvDetail));
        });

    blocTest<DetailTvBloc, DetailTvState>(
        'should execute remove watchlist when function called',
        build: () {
          when(() => mockRemoveWatchList.execute(testTvDetail))
              .thenAnswer((_) async => Right('Removed from Watchlist'));
          return detailTvBloc;
        },
        act: (bloc) => bloc.add(OnRemoveTvFromWatchList(tvData: testTvDetail)),
        verify: (bloc) {
          verify(() => mockRemoveWatchList.execute(testTvDetail));
        });

    blocTest<DetailTvBloc, DetailTvState>(
        'should update watchlist message when add watchlist failed',
        build: () {
          when(() => mockSaveWatchList.execute(testTvDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
          return detailTvBloc;
        },
        expect: () => [
              DetailTvState().copyWith(
                  isSavedToWatchList: false, watchListMessage: 'Failed')
            ],
        act: (bloc) => bloc.add(OnSaveTvToWatchList(tvData: testTvDetail)),
        verify: (bloc) {
          verify(() => mockSaveWatchList.execute(testTvDetail));
        });

    blocTest<DetailTvBloc, DetailTvState>(
        'should update watchlist message when remove watchlist failed',
        build: () {
          when(() => mockRemoveWatchList.execute(testTvDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
          return detailTvBloc;
        },
        expect: () => [
              DetailTvState().copyWith(
                  isSavedToWatchList: true, watchListMessage: 'Failed')
            ],
        act: (bloc) => bloc.add(OnRemoveTvFromWatchList(tvData: testTvDetail)),
        verify: (bloc) {
          verify(() => mockRemoveWatchList.execute(testTvDetail));
        });
  });
}
