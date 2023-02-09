import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/pages/tv/watch_list/bloc/watch_list_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv/watch_list/watchlist_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchListTvBloc extends MockBloc<WatchListTvEvent, WatchListTvState>
    implements WatchListTvBloc {}

void main() {
  late WatchListTvBloc _mockWatchListTvBloc;

  setUp(() {
    _mockWatchListTvBloc = MockWatchListTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchListTvBloc>.value(
      value: _mockWatchListTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    whenListen<WatchListTvState>(
      _mockWatchListTvBloc,
      Stream<WatchListTvState>.fromIterable([
        WatchListTvState().watchListLoading(),
      ]),
      initialState: WatchListTvState(),
    );

    when(() => _mockWatchListTvBloc.state)
        .thenReturn(WatchListTvState().watchListLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    whenListen<WatchListTvState>(
      _mockWatchListTvBloc,
      Stream<WatchListTvState>.fromIterable(
          [WatchListTvState().watchListError(errMessage: 'Error Message')]),
      initialState: WatchListTvState(),
    );

    when(() => _mockWatchListTvBloc.state).thenReturn(
        WatchListTvState().watchListError(errMessage: 'Error Message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
