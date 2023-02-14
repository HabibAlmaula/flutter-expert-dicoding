import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/search_tv.dart';
import 'package:ditonton/presentation/pages/tv/search/bloc/search_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchTv extends Mock implements SearchTv {}

void main() {
  late SearchTvBloc searchTvBloc;
  late MockSearchTv mockSearchTv;

  final tTvModel = Tv(
    backdropPath: 'backdropPath',
    firstAirDate: "2022-02-02",
    genreIds: [1, 1, 1],
    id: 1,
    name: "name",
    originCountry: ["c"],
    originalLanguage: "c",
    originalName: "name",
    overview: "overview",
    popularity: 1,
    posterPath: "posterPath",
    voteAverage: 1.1,
    voteCount: 1,
  );
  final tTvList = <Tv>[tTvModel];
  final tQuery = 'umbrella';

  setUp(() {
    mockSearchTv = MockSearchTv();
    searchTvBloc = SearchTvBloc(searchTv: mockSearchTv);
  });

  test('initial state should be empty', () {
    expect(searchTvBloc.state, SearchEmpty());
  });

  blocTest<SearchTvBloc, SearchTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(() => mockSearchTv.execute(tQuery))
            .thenAnswer((realInvocation) async => Right(tTvList));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 700),
      expect: () => [
            SearchLoading(),
            SearchHasData(tTvList),
          ],
      verify: (bloc) {
        verify(() => mockSearchTv.execute(tQuery));
      });

  blocTest<SearchTvBloc, SearchTvState>(
      'Should emit [Loading, Error] when get searcg is unsuccessfully',
      build: () {
        when(() => mockSearchTv.execute(tQuery)).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 700),
      expect: () => [
            SearchLoading(),
            SearchError('Server Failure'),
          ],
      verify: (bloc) {
        verify(() => mockSearchTv.execute(tQuery));
      });

  blocTest<SearchTvBloc, SearchTvState>(
      'Should emit [Loading, HasData with Empty] when query is Empty',
      build: () {
        when(() => mockSearchTv.execute(""))
            .thenAnswer((realInvocation) async => Right(<Tv>[]));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged("")),
      wait: const Duration(milliseconds: 700),
      expect: () => [
            SearchLoading(),
            SearchHasData(<Tv>[]),
          ],
      verify: (bloc) {
        verify(() => mockSearchTv.execute(""));
      });
}
