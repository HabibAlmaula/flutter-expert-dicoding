import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/pages/watch_list/bloc/watch_list_movie_bloc.dart';
import 'package:movie/presentation/pages/watch_list/watchlist_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchListMovieBloc extends MockBloc<WatchListMovieEvent, WatchListMovieState>
    implements WatchListMovieBloc {}

void main() {
  late WatchListMovieBloc mockWatchListMovieBloc;

  setUp(() {
    mockWatchListMovieBloc = MockWatchListMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchListMovieBloc>.value(
      value: mockWatchListMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        whenListen<WatchListMovieState>(
          mockWatchListMovieBloc,
          Stream<WatchListMovieState>.fromIterable([
            const WatchListMovieState().watchListLoading(),
          ]),
          initialState: const WatchListMovieState(),
        );

        when(() => mockWatchListMovieBloc.state)
            .thenReturn(const WatchListMovieState().watchListLoading());

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        whenListen<WatchListMovieState>(
          mockWatchListMovieBloc,
          Stream<WatchListMovieState>.fromIterable(
              [const WatchListMovieState().watchListError(errMessage: 'Error Message')]),
          initialState: const WatchListMovieState(),
        );

        when(() => mockWatchListMovieBloc.state).thenReturn(
            const WatchListMovieState().watchListError(errMessage: 'Error Message'));

        final textFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

        expect(textFinder, findsOneWidget);
      });

  testWidgets('Page should display center lottie when empty',
          (WidgetTester tester) async {
        whenListen<WatchListMovieState>(
          mockWatchListMovieBloc,
          Stream<WatchListMovieState>.fromIterable([
            const WatchListMovieState().watchListLoading(),
            const WatchListMovieState().watchListHasData(movies: <Movie>[]),
          ]),
          initialState: const WatchListMovieState(),
        );

        when(() => mockWatchListMovieBloc.state)
            .thenReturn(const WatchListMovieState().watchListHasData(movies: <Movie>[]));

        final centerFinder = find.byType(Center);
        final lottieFinder = find.byType(Lottie);

        await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

        expect(centerFinder, findsOneWidget);
        expect(lottieFinder, findsOneWidget);
      });

  testWidgets('Page should display content when has data',
          (WidgetTester tester) async {
        whenListen<WatchListMovieState>(
          mockWatchListMovieBloc,
          Stream<WatchListMovieState>.fromIterable([
            const WatchListMovieState().watchListLoading(),
            const WatchListMovieState().watchListHasData(movies: testMovieList),
          ]),
          initialState: const WatchListMovieState(),
        );

        when(() => mockWatchListMovieBloc.state)
            .thenReturn(const WatchListMovieState().watchListHasData(movies: testMovieList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

        expect(listViewFinder, findsOneWidget);
      });
}
