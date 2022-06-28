import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/main_watch_list.dart';
import 'package:ditonton/presentation/provider/tv/watchlist_tv_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'movie_detail_page_test.mocks.dart';
import 'tv/tv_detail_page_test.mocks.dart';

@GenerateMocks([WatchlistMovieNotifier, WatchListTvNotifier])
void main() {
  late MockWatchlistMovieNotifier mockNotifier;
  late MockWatchListTvNotifier mockWatchListTvNotifier;

  setUp(() {
    mockNotifier = MockWatchlistMovieNotifier();
    mockWatchListTvNotifier = MockWatchListTvNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WatchlistMovieNotifier>.value(
            value: mockNotifier),
        ChangeNotifierProvider<WatchListTvNotifier>.value(
            value: mockWatchListTvNotifier),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Page should display watchlist movie page when click on first tab',
      (WidgetTester tester) async {
    when(mockNotifier.watchlistState).thenReturn(RequestState.Empty);
    when(mockWatchListTvNotifier.watchlistTvState)
        .thenReturn(RequestState.Empty);
    when(mockNotifier.message).thenReturn("");
    when(mockWatchListTvNotifier.message).thenReturn("");

    await tester.pumpWidget(_makeTestableWidget(MainWatchList()));
    // await tester.tap(find.byType(Tab).at(0));
    // await tester.pump();

    final findTab = find.byType(Tab);

    expect(findTab, findsWidgets);
  });
}
