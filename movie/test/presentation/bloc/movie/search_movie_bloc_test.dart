import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/usecases/movie/search_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/pages/search/bloc/search_movie_bloc.dart';

class MockSearchMovies extends Mock implements SearchMovies {}

void main() {
  late SearchMovieBloc searchMovieBloc;
  late MockSearchMovies mockSearchMovies;

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchMovieBloc = SearchMovieBloc(mockSearchMovies);
  });

  test('initial state should be empty', () {
    expect(searchMovieBloc.state, SearchEmpty());
  });

  blocTest<SearchMovieBloc, SearchMovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(() => mockSearchMovies.execute(tQuery))
            .thenAnswer((realInvocation) async => Right(tMovieList));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(query: tQuery)),
      wait: const Duration(milliseconds: 700),
      expect: () => [
            SearchLoading(),
            SearchHasData(tMovieList),
          ],
      verify: (bloc) {
        verify(() => mockSearchMovies.execute(tQuery));
      });

  blocTest<SearchMovieBloc, SearchMovieState>(
      'Should emit [Loading, Error] when get searcg is unsuccessfully',
      build: () {
        when(() => mockSearchMovies.execute(tQuery)).thenAnswer(
            (realInvocation) async => const Left(ServerFailure('Server Failure')));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(query : tQuery)),
      wait: const Duration(milliseconds: 700),
      expect: () => [
            SearchLoading(),
            const SearchError('Server Failure'),
          ],
      verify: (bloc) {
        verify(() => mockSearchMovies.execute(tQuery));
      });
}
