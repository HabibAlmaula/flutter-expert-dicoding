import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'home_movie_page_test.mocks.dart';

@GenerateMocks([MovieListNotifier, NavigationProvider])
void main() {
  late MockMovieListNotifier mockNotifier;
  late MockNavigationProvider mockNavigationProvider;

  setUp(() {
    mockNotifier = MockMovieListNotifier();
    mockNavigationProvider = MockNavigationProvider();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MovieListNotifier>.value(value: mockNotifier),
        ChangeNotifierProvider<NavigationProvider>.value(
            value: mockNavigationProvider),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should text header when loading', (WidgetTester tester) async {
    when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loading);
    when(mockNotifier.popularMoviesState).thenReturn(RequestState.Loading);
    when(mockNotifier.topRatedMoviesState).thenReturn(RequestState.Loading);

    final textHeaderFinder = find.byType(Text);
    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));
    expect(textHeaderFinder, findsWidgets);
  });

  testWidgets('Page should text header when loaded', (WidgetTester tester) async {
    when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularMoviesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.topRatedMoviesState).thenReturn(RequestState.Loaded);

    when(mockNotifier.nowPlayingMovies).thenReturn(<Movie>[]);
    when(mockNotifier.popularMovies).thenReturn(<Movie>[]);
    when(mockNotifier.topRatedMovies).thenReturn(<Movie>[]);

    final textHeaderFinder = find.byType(Text);
    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));
    expect(textHeaderFinder, findsWidgets);
  });

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loading);
    when(mockNotifier.popularMoviesState).thenReturn(RequestState.Loading);
    when(mockNotifier.topRatedMoviesState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));
    expect(progressBarFinder, findsWidgets);
  });
  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularMoviesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.topRatedMoviesState).thenReturn(RequestState.Loaded);

    when(mockNotifier.nowPlayingMovies).thenReturn(<Movie>[]);
    when(mockNotifier.popularMovies).thenReturn(<Movie>[]);
    when(mockNotifier.topRatedMovies).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(listViewFinder, findsWidgets);
  });
}
