import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/pages/movie/detail/bloc/detail_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie/detail/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockDetailMovieBloc extends MockBloc<DetailMovieEvent, DetailMovieState>
    implements DetailMovieBloc {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late DetailMovieBloc _mockDetailMovieBloc;

  setUp(() async {
    _mockDetailMovieBloc = MockDetailMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<DetailMovieBloc>.value(
      value: _mockDetailMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final movieDetail = testMovieDetail;
  final id = movieDetail.id;

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    whenListen(
      _mockDetailMovieBloc,
      Stream<DetailMovieState>.fromIterable([
        DetailMovieState().detailMovieLoading(),
      ]),
    );
    when(() => _mockDetailMovieBloc.state)
        .thenReturn(DetailMovieState().detailMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
      id: id,
    )));
    await tester.pump();

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  // testWidgets(
  //     'Watchlist button should display add icon when movie not added to watchlist',
  //     (WidgetTester tester) async {
  //   whenListen(
  //     _mockDetailMovieBloc,
  //     Stream.fromIterable([
  //       DetailMovieState().detailMovieLoading(),
  //       DetailMovieState().detailMovieHasData(data: testMovieDetail),
  //       DetailMovieState().copyWith(isSavedToWatchList: false),
  //     ]),
  //     initialState: DetailMovieState(),
  //   );
  //
  //   when(() => _mockDetailMovieBloc.state)
  //       .thenReturn(DetailMovieState().detailMovieLoading());
  //   when(() => _mockDetailMovieBloc.state).thenReturn(
  //       DetailMovieState().detailMovieHasData(data: testMovieDetail));
  //   when(() => _mockDetailMovieBloc.state)
  //       .thenReturn(DetailMovieState().copyWith(isSavedToWatchList: false));
  //
  //   final iconFinder = find.byIcon(Icons.add);
  //
  //   await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
  //     id: id,
  //   )));
  //   await tester.pump();
  //
  //   expect(iconFinder, findsOneWidget);
  // });

  // testWidgets(
  //     'Watchlist button should display add icon when movie not added to watchlist',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movie).thenReturn(testMovieDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //
  //   final watchlistButtonIcon = find.byIcon(Icons.add);
  //
  //   await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
  //
  //   expect(watchlistButtonIcon, findsOneWidget);
  // });
  //
  // testWidgets(
  //     'Watchlist button should dispay check icon when movie is added to wathclist',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movie).thenReturn(testMovieDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(true);
  //
  //   final watchlistButtonIcon = find.byIcon(Icons.check);
  //
  //   await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
  //
  //   expect(watchlistButtonIcon, findsOneWidget);
  // });
  //
  // testWidgets(
  //     'Watchlist button should display Snackbar when added to watchlist',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movie).thenReturn(testMovieDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //   when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');
  //
  //   final watchlistButton = find.byType(ElevatedButton);
  //
  //   await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
  //
  //   expect(find.byIcon(Icons.add), findsOneWidget);
  //
  //   await tester.tap(watchlistButton);
  //   await tester.pump();
  //
  //   expect(find.byType(SnackBar), findsOneWidget);
  //   expect(find.text('Added to Watchlist'), findsOneWidget);
  // });
  //
  // testWidgets(
  //     'Watchlist button should display AlertDialog when add to watchlist failed',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movie).thenReturn(testMovieDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //   when(mockNotifier.watchlistMessage).thenReturn('Failed');
  //
  //   final watchlistButton = find.byType(ElevatedButton);
  //
  //   await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
  //
  //   expect(find.byIcon(Icons.add), findsOneWidget);
  //
  //   await tester.tap(watchlistButton);
  //   await tester.pump();
  //
  //   expect(find.byType(Dialog), findsOneWidget);
  //   expect(find.text('Failed'), findsOneWidget);
  // });
}
