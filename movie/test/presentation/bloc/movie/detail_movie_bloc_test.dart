import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/usecases/movie/get_movie_detail.dart';
import 'package:core/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movie/get_watchlist_status.dart';
import 'package:core/domain/usecases/movie/remove_watchlist.dart';
import 'package:core/domain/usecases/movie/save_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/pages/detail/bloc/detail_movie_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';

//mock useCases
class MockGetMovieDetail extends Mock implements GetMovieDetail {}

class MockGetMovieRecommendation extends Mock
    implements GetMovieRecommendations {}

class MockGetWatchListStatus extends Mock implements GetWatchListStatus {}

class MockSaveWatchList extends Mock implements SaveWatchlist {}

class MockRemoveWatchList extends Mock implements RemoveWatchlist {}

void main() {
  late DetailMovieBloc detailMovieBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendation mockGetMovieRecommendation;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchList mockSaveWatchList;
  late MockRemoveWatchList mockRemoveWatchList;

  const tId = 1;
  const isAdded = true;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendation = MockGetMovieRecommendation();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchList = MockSaveWatchList();
    mockRemoveWatchList = MockRemoveWatchList();
    detailMovieBloc = DetailMovieBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendation,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchList,
      removeWatchlist: mockRemoveWatchList,
    );
  });

  void _arrangeUsecase() {
    when(() => mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
    when(() => mockGetMovieRecommendation.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  group('Get Movie Detail', () {
    test('initial state should be Empty', () {
      expect(detailMovieBloc.state, const DetailMovieState().initialDetail());
    });
    blocTest<DetailMovieBloc, DetailMovieState>(
        'should get movie detail data from the usecase',
        build: () {
          _arrangeUsecase();
          return detailMovieBloc;
        },
        act: (bloc) => bloc.add(const OnLoadMovieDetail(movieId: tId)),
        verify: (bloc) {
          verify(() => mockGetMovieDetail.execute(tId));
        });

    blocTest<DetailMovieBloc, DetailMovieState>(
        'should emit [Loading, HasData] when detail movie gotten successfully',
        build: () {
          _arrangeUsecase();
          return detailMovieBloc;
        },
        act: (bloc) => bloc.add(const OnLoadMovieDetail(movieId: tId)),
        expect: () => [
              const DetailMovieState().detailMovieLoading(),
              const DetailMovieState().detailMovieHasData(data: testMovieDetail)
            ],
        verify: (bloc) {
          verify(() => mockGetMovieDetail.execute(tId));
        });

    blocTest<DetailMovieBloc, DetailMovieState>(
        'should emit [Loading, Error] when get detail movie unsuccessfully',
        build: () {
          when(() => mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return detailMovieBloc;
        },
        act: (bloc) => bloc.add(const OnLoadMovieDetail(movieId: tId)),
        expect: () => [
              const DetailMovieState().detailMovieLoading(),
              const DetailMovieState().detailMovieError(message: 'Server Failure')
            ],
        verify: (bloc) {
          verify(() => mockGetMovieDetail.execute(tId));
        });
  });

  group('Get Movie Recommendation', () {
    test('initial state should be Empty', () {
      expect(detailMovieBloc.state, const DetailMovieState().initialDetail());
    });
    blocTest<DetailMovieBloc, DetailMovieState>(
        'should get movie recommendation data from the usecase',
        build: () {
          _arrangeUsecase();
          return detailMovieBloc;
        },
        act: (bloc) => bloc.add(const OnLoadMovieRecommendations(movieId: tId)),
        verify: (bloc) {
          verify(() => mockGetMovieRecommendation.execute(tId));
        });

    blocTest<DetailMovieBloc, DetailMovieState>(
        'should emit [Loading, HasData] when recommendation movie gotten successfully',
        build: () {
          _arrangeUsecase();
          return detailMovieBloc;
        },
        act: (bloc) => bloc.add(const OnLoadMovieRecommendations(movieId: tId)),
        expect: () => [
              const DetailMovieState().recommendationMovieLoading(),
              const DetailMovieState().recommendationMovieHasData(data: tMovies)
            ],
        verify: (bloc) {
          verify(() => mockGetMovieRecommendation.execute(tId));
        });

    blocTest<DetailMovieBloc, DetailMovieState>(
        'should emit [Loading, Error] when get recommendation movie unsuccessfully',
        build: () {
          when(() => mockGetMovieRecommendation.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return detailMovieBloc;
        },
        act: (bloc) => bloc.add(const OnLoadMovieRecommendations(movieId: tId)),
        expect: () => [
              const DetailMovieState().recommendationMovieLoading(),
              const DetailMovieState()
                  .recommendationMovieError(message: 'Server Failure')
            ],
        verify: (bloc) {
          verify(() => mockGetMovieRecommendation.execute(tId));
        });
  });

  group('Get WatchList Movie', () {
    test('initial state should be Empty', () {
      expect(detailMovieBloc.state, const DetailMovieState().initialDetail());
    });
    blocTest<DetailMovieBloc, DetailMovieState>(
        'should get watchlist status from the usecase',
        build: () {
          when(() => mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => isAdded);
          return detailMovieBloc;
        },
        act: (bloc) => bloc.add(const OnLoadWatchListMovieStatus(movieId: tId)),
        verify: (bloc) {
          verify(() => mockGetWatchListStatus.execute(tId));
        });

    blocTest<DetailMovieBloc, DetailMovieState>(
        'should execute save watchlist when function called',
        build: () {
          when(() => mockSaveWatchList.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Added to Watchlist'));
          return detailMovieBloc;
        },
        act: (bloc) =>
            bloc.add(OnSaveMovieToWatchList(movieData: testMovieDetail)),
        verify: (bloc) {
          verify(() => mockSaveWatchList.execute(testMovieDetail));
        });

    blocTest<DetailMovieBloc, DetailMovieState>(
        'should execute remove watchlist when function called',
        build: () {
          when(() => mockRemoveWatchList.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Removed from Watchlist'));
          return detailMovieBloc;
        },
        act: (bloc) =>
            bloc.add(OnRemoveMovieFromWatchList(movieData: testMovieDetail)),
        verify: (bloc) {
          verify(() => mockRemoveWatchList.execute(testMovieDetail));
        });

    blocTest<DetailMovieBloc, DetailMovieState>(
        'should execute remove watchlist when function called',
        build: () {
          when(() => mockRemoveWatchList.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Removed from Watchlist'));
          return detailMovieBloc;
        },
        act: (bloc) =>
            bloc.add(OnRemoveMovieFromWatchList(movieData: testMovieDetail)),
        verify: (bloc) {
          verify(() => mockRemoveWatchList.execute(testMovieDetail));
        });

    blocTest<DetailMovieBloc, DetailMovieState>(
        'should update watchlist message when add watchlist failed',
        build: () {
          when(() => mockSaveWatchList.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
          return detailMovieBloc;
        },
        expect: () => [
              const DetailMovieState().copyWith(
                  isSavedToWatchList: false, watchListMessage: 'Failed')
            ],
        act: (bloc) =>
            bloc.add(OnSaveMovieToWatchList(movieData: testMovieDetail)),
        verify: (bloc) {
          verify(() => mockSaveWatchList.execute(testMovieDetail));
        });

    blocTest<DetailMovieBloc, DetailMovieState>(
        'should update watchlist message when remove watchlist failed',
        build: () {
          when(() => mockRemoveWatchList.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
          return detailMovieBloc;
        },
        expect: () => [
          const DetailMovieState().copyWith(
              isSavedToWatchList: true, watchListMessage: 'Failed')
        ],
        act: (bloc) =>
            bloc.add(OnRemoveMovieFromWatchList(movieData: testMovieDetail)),
        verify: (bloc) {
          verify(() => mockRemoveWatchList.execute(testMovieDetail));
        });
  });
}
