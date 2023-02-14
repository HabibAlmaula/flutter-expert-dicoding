import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/pages/watch_list/bloc/watch_list_tv_bloc.dart';
import 'package:tv/presentation/pages/watch_list/watchlist_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchListTvBloc extends MockBloc<WatchListTvEvent, WatchListTvState>
    implements WatchListTvBloc {}

void main() {
  late WatchListTvBloc mockWatchListTvBloc;

  setUp(() {
    mockWatchListTvBloc = MockWatchListTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchListTvBloc>.value(
      value: mockWatchListTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    whenListen<WatchListTvState>(
      mockWatchListTvBloc,
      Stream<WatchListTvState>.fromIterable([
        const WatchListTvState().watchListLoading(),
      ]),
      initialState: const WatchListTvState(),
    );

    when(() => mockWatchListTvBloc.state)
        .thenReturn(const WatchListTvState().watchListLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    whenListen<WatchListTvState>(
      mockWatchListTvBloc,
      Stream<WatchListTvState>.fromIterable([
        const WatchListTvState().watchListError(errMessage: 'Error Message')
      ]),
      initialState: const WatchListTvState(),
    );

    when(() => mockWatchListTvBloc.state).thenReturn(
        const WatchListTvState().watchListError(errMessage: 'Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display center lottie when empty',
      (WidgetTester tester) async {
    whenListen<WatchListTvState>(
      mockWatchListTvBloc,
      Stream<WatchListTvState>.fromIterable([
        const WatchListTvState().watchListLoading(),
        const WatchListTvState().watchListHasData(tv: <Tv>[]),
      ]),
      initialState: const WatchListTvState(),
    );

    when(() => mockWatchListTvBloc.state)
        .thenReturn(const WatchListTvState().watchListHasData(tv: <Tv>[]));

    final centerFinder = find.byType(Center);
    final lottieFinder = find.byType(Lottie);

    await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(lottieFinder, findsOneWidget);
  });

  testWidgets('Page should display content when has data',
          (WidgetTester tester) async {
        whenListen<WatchListTvState>(
          mockWatchListTvBloc,
          Stream<WatchListTvState>.fromIterable([
            const WatchListTvState().watchListLoading(),
            const WatchListTvState().watchListHasData(tv: testTvList),
          ]),
          initialState: const WatchListTvState(),
        );

        when(() => mockWatchListTvBloc.state)
            .thenReturn(const WatchListTvState().watchListHasData(tv: testTvList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

        expect(listViewFinder, findsOneWidget);
      });
}
