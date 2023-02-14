import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movie/get_popular_movies.dart';
import 'package:core/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/pages/home/bloc/home_movie_bloc.dart';

class MockGetNowPlayingMovies extends Mock implements GetNowPlayingMovies {}

class MockGetPopularMovies extends Mock implements GetPopularMovies {}

class MockGetTopRatedMovies extends Mock implements GetTopRatedMovies {}

void main() {
  late HomeMovieBloc homeMovieBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

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
  final tMovieList = <Movie>[tMovie];

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    homeMovieBloc = HomeMovieBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

  group('get now playing movies', () {
    test('initialState should be Empty', () {
      expect(homeMovieBloc.state, const  HomeMovieState().initialState());
    });

    blocTest<HomeMovieBloc, HomeMovieState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(() => mockGetNowPlayingMovies.execute())
              .thenAnswer((invocation) async => Right(tMovieList));
          return homeMovieBloc;
        },
        act: (bloc) => bloc.add(OnLoadNowPlayingMovies()),
        expect: () => [
              const  HomeMovieState().nowPlayingLoading(),
              const  HomeMovieState().nowPlayingHasData(result: tMovieList)
            ],
        verify: (bloc) {
          verify(() => mockGetNowPlayingMovies.execute());
        });

    blocTest<HomeMovieBloc, HomeMovieState>(
        'Should emit [Loading, Error] when get data is unsuccessfully',
        build: () {
          when(() => mockGetNowPlayingMovies.execute()).thenAnswer(
              (invocation) async => const Left(ServerFailure('Server Failure')));
          return homeMovieBloc;
        },
        act: (bloc) => bloc.add(OnLoadNowPlayingMovies()),
        expect: () => [
              const  HomeMovieState().nowPlayingLoading(),
              const  HomeMovieState().nowPlayingError(message: 'Server Failure')
            ],
        verify: (bloc) {
          verify(() => mockGetNowPlayingMovies.execute());
        });
  });

  group('get popular movies', () {
    test('initialState should be Empty', () {
      expect(homeMovieBloc.state, const  HomeMovieState().initialState());
    });

    blocTest<HomeMovieBloc, HomeMovieState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(() => mockGetPopularMovies.execute())
              .thenAnswer((invocation) async => Right(tMovieList));
          return homeMovieBloc;
        },
        act: (bloc) => bloc.add(OnLoadPopularMovies()),
        expect: () => [
              const HomeMovieState().popularLoading(),
              const HomeMovieState().popularHasData(result: tMovieList)
            ],
        verify: (bloc) {
          verify(() => mockGetPopularMovies.execute());
        });

    blocTest<HomeMovieBloc, HomeMovieState>(
        'Should emit [Loading, Error] when get data is unsuccessfully',
        build: () {
          when(() => mockGetPopularMovies.execute()).thenAnswer(
              (invocation) async => const Left(ServerFailure('Server Failure')));
          return homeMovieBloc;
        },
        act: (bloc) => bloc.add(OnLoadPopularMovies()),
        expect: () => [
              const HomeMovieState().popularLoading(),
              const HomeMovieState().popularError(message: 'Server Failure')
            ],
        verify: (bloc) {
          verify(() => mockGetPopularMovies.execute());
        });
  });

  group('get top rated movies', () {
    test('initialState should be Empty', () {
      expect(homeMovieBloc.state, const HomeMovieState().initialState());
    });

    blocTest<HomeMovieBloc, HomeMovieState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(() => mockGetTopRatedMovies.execute())
              .thenAnswer((invocation) async => Right(tMovieList));
          return homeMovieBloc;
        },
        act: (bloc) => bloc.add(OnLoadTopRatedMovies()),
        expect: () => [
              const HomeMovieState().topRatedLoading(),
              const HomeMovieState().topRatedHasData(result: tMovieList)
            ],
        verify: (bloc) {
          verify(() => mockGetTopRatedMovies.execute());
        });

    blocTest<HomeMovieBloc, HomeMovieState>(
        'Should emit [Loading, Error] when get data is unsuccessfully',
        build: () {
          when(() => mockGetTopRatedMovies.execute()).thenAnswer(
              (invocation) async => const Left(ServerFailure('Server Failure')));
          return homeMovieBloc;
        },
        act: (bloc) => bloc.add(OnLoadTopRatedMovies()),
        expect: () => [
              const HomeMovieState().topRatedLoading(),
              const HomeMovieState().topRatedError(message: 'Server Failure')
            ],
        verify: (bloc) {
          verify(() => mockGetTopRatedMovies.execute());
        });
  });
}
