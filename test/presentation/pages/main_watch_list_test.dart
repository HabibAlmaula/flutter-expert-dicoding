import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/pages/main_watch_list.dart';
import 'package:ditonton/presentation/pages/movie/watch_list/bloc/watch_list_movie_bloc.dart';
import 'package:ditonton/presentation/pages/tv/watch_list/bloc/watch_list_tv_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockWatchListMovieBloc
    extends MockBloc<WatchListMovieEvent, WatchListMovieState>
    implements WatchListMovieBloc {}

class MockWatchListTvBloc extends MockBloc<WatchListTvEvent, WatchListTvState>
    implements WatchListTvBloc {}

void main() {
  late WatchListMovieBloc _mockWatchListMovieBloc;
  late WatchListTvBloc _mockWatchListTvBloc;

  setUp(() {
    _mockWatchListMovieBloc = MockWatchListMovieBloc();
    _mockWatchListTvBloc = MockWatchListTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<WatchListMovieBloc>.value(value: _mockWatchListMovieBloc),
        BlocProvider<WatchListTvBloc>.value(value: _mockWatchListTvBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Page should display watchlist movie page when click on first tab',
      (WidgetTester tester) async {
    when(() => _mockWatchListMovieBloc.state).thenReturn(WatchListMovieState());
    when(() => _mockWatchListTvBloc.state).thenReturn(WatchListTvState());

    await tester.pumpWidget(_makeTestableWidget(MainWatchListPage()));

    final findTab = find.byType(Tab);

    expect(findTab, findsWidgets);
  });
}
