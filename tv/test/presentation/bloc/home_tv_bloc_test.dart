import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:core/domain/usecases/tv/get_popular_tv.dart';
import 'package:core/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/pages/home/bloc/home_tv_bloc.dart';

class MockGetNowPlayingTv extends Mock implements GetNowPlayingTv {}

class MockGetPopularTv extends Mock implements GetPopularTv {}

class MockGetTopRatedTv extends Mock implements GetTopRatedTv {}

void main() {
  late HomeTvBloc homeTvBloc;
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late MockGetPopularTv mockGetPopularTv;
  late MockGetTopRatedTv mockGetTopRatedTv;

  final tTv = Tv(
    backdropPath: 'backdropPath',
    firstAirDate: "2022-02-02",
    genreIds: const [1, 1, 1],
    id: 1,
    name: "name",
    originCountry: const ["c"],
    originalLanguage: "c",
    originalName: "name",
    overview: "overview",
    popularity: 1,
    posterPath: "posterPath",
    voteAverage: 1.1,
    voteCount: 1,
  );
  final tTvList = <Tv>[tTv];

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    mockGetPopularTv = MockGetPopularTv();
    mockGetTopRatedTv = MockGetTopRatedTv();
    homeTvBloc = HomeTvBloc(
        getNowPlayingTv: mockGetNowPlayingTv,
        getPopularTv: mockGetPopularTv,
        getTopRatedTv: mockGetTopRatedTv);
  });

  group('get now playing tv', () {
    test('initialState should be Empty', () {
      expect(homeTvBloc.state, const HomeTvState().initialState());
    });

    blocTest<HomeTvBloc, HomeTvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(() => mockGetNowPlayingTv.execute())
              .thenAnswer((invocation) async => Right(tTvList));
          return homeTvBloc;
        },
        act: (bloc) => bloc.add(OnLoadNowPlayingTv()),
        expect: () => [
              const HomeTvState().nowPlayingLoading(),
              const HomeTvState().nowPlayingHasData(result: tTvList)
            ],
        verify: (bloc) {
          verify(() => mockGetNowPlayingTv.execute());
        });

    blocTest<HomeTvBloc, HomeTvState>(
        'Should emit [Loading, Error] when get data is unsuccessfully',
        build: () {
          when(() => mockGetNowPlayingTv.execute()).thenAnswer(
              (invocation) async => Left(ServerFailure('Server Failure')));
          return homeTvBloc;
        },
        act: (bloc) => bloc.add(OnLoadNowPlayingTv()),
        expect: () => [
              const HomeTvState().nowPlayingLoading(),
              const HomeTvState().nowPlayingError(message: 'Server Failure')
            ],
        verify: (bloc) {
          verify(() => mockGetNowPlayingTv.execute());
        });
  });

  group('get popular Tv', () {
    test('initialState should be Empty', () {
      expect(homeTvBloc.state, const HomeTvState().initialState());
    });

    blocTest<HomeTvBloc, HomeTvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(() => mockGetPopularTv.execute())
              .thenAnswer((invocation) async => Right(tTvList));
          return homeTvBloc;
        },
        act: (bloc) => bloc.add(OnLoadPopularTv()),
        expect: () => [
              const HomeTvState().popularLoading(),
              const HomeTvState().popularHasData(result: tTvList)
            ],
        verify: (bloc) {
          verify(() => mockGetPopularTv.execute());
        });

    blocTest<HomeTvBloc, HomeTvState>(
        'Should emit [Loading, Error] when get data is unsuccessfully',
        build: () {
          when(() => mockGetPopularTv.execute()).thenAnswer(
              (invocation) async => Left(ServerFailure('Server Failure')));
          return homeTvBloc;
        },
        act: (bloc) => bloc.add(OnLoadPopularTv()),
        expect: () => [
              const HomeTvState().popularLoading(),
              const HomeTvState().popularError(message: 'Server Failure')
            ],
        verify: (bloc) {
          verify(() => mockGetPopularTv.execute());
        });
  });

  group('get top rated Tv', () {
    test('initialState should be Empty', () {
      expect(homeTvBloc.state, const HomeTvState().initialState());
    });

    blocTest<HomeTvBloc, HomeTvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(() => mockGetTopRatedTv.execute())
              .thenAnswer((invocation) async => Right(tTvList));
          return homeTvBloc;
        },
        act: (bloc) => bloc.add(OnLoadTopRatedTv()),
        expect: () => [
              const HomeTvState().topRatedLoading(),
              const HomeTvState().topRatedHasData(result: tTvList)
            ],
        verify: (bloc) {
          verify(() => mockGetTopRatedTv.execute());
        });

    blocTest<HomeTvBloc, HomeTvState>(
        'Should emit [Loading, Error] when get data is unsuccessfully',
        build: () {
          when(() => mockGetTopRatedTv.execute()).thenAnswer(
              (invocation) async => Left(ServerFailure('Server Failure')));
          return homeTvBloc;
        },
        act: (bloc) => bloc.add(OnLoadTopRatedTv()),
        expect: () => [
              const HomeTvState().topRatedLoading(),
              const HomeTvState().topRatedError(message: 'Server Failure')
            ],
        verify: (bloc) {
          verify(() => mockGetTopRatedTv.execute());
        });
  });
}
