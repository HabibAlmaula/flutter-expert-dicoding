import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/pages/movie/watch_list/bloc/watch_list_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie/watch_list/watchlist_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchListMovieBloc extends MockBloc<WatchListMovieEvent, WatchListMovieState>
    implements WatchListMovieBloc {}

void main() {
  late WatchListMovieBloc _mockWatchListMovieBloc;

  setUp(() {
    _mockWatchListMovieBloc = MockWatchListMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchListMovieBloc>.value(
      value: _mockWatchListMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        whenListen<WatchListMovieState>(
          _mockWatchListMovieBloc,
          Stream<WatchListMovieState>.fromIterable([
            WatchListMovieState().watchListLoading(),
          ]),
          initialState: WatchListMovieState(),
        );

        when(() => _mockWatchListMovieBloc.state)
            .thenReturn(WatchListMovieState().watchListLoading());

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        whenListen<WatchListMovieState>(
          _mockWatchListMovieBloc,
          Stream<WatchListMovieState>.fromIterable(
              [WatchListMovieState().watchListError(errMessage: 'Error Message')]),
          initialState: WatchListMovieState(),
        );

        when(() => _mockWatchListMovieBloc.state).thenReturn(
            WatchListMovieState().watchListError(errMessage: 'Error Message'));

        final textFinder = find.byKey(Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

        expect(textFinder, findsOneWidget);
      });
}
