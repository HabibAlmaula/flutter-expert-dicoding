import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/pages/tv/detail/bloc/detail_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv/detail/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';


import '../../../dummy_data/dummy_objects.dart';

class MockDetailTvBloc extends MockBloc<DetailTvEvent, DetailTvState>
    implements DetailTvBloc {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late DetailTvBloc _mockDetailTvBloc;

  setUp(() async {
    _mockDetailTvBloc = MockDetailTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<DetailTvBloc>.value(
      value: _mockDetailTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final TvDetail = testTvDetail;
  final id = TvDetail.id;

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        whenListen(
          _mockDetailTvBloc,
          Stream<DetailTvState>.fromIterable([
            DetailTvState().detailTvLoading(),
          ]),
        );
        when(() => _mockDetailTvBloc.state)
            .thenReturn(DetailTvState().detailTvLoading());

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(
          id: id,
        )));
        await tester.pump();

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

  // testWidgets(
  //     'Watchlist button should display add icon when Tv not added to watchlist',
  //     (WidgetTester tester) async {
  //   whenListen(
  //     _mockDetailTvBloc,
  //     Stream.fromIterable([
  //       DetailTvState().detailTvLoading(),
  //       DetailTvState().detailTvHasData(data: testTvDetail),
  //       DetailTvState().copyWith(isSavedToWatchList: false),
  //     ]),
  //     initialState: DetailTvState(),
  //   );
  //
  //   when(() => _mockDetailTvBloc.state)
  //       .thenReturn(DetailTvState().detailTvLoading());
  //   when(() => _mockDetailTvBloc.state).thenReturn(
  //       DetailTvState().detailTvHasData(data: testTvDetail));
  //   when(() => _mockDetailTvBloc.state)
  //       .thenReturn(DetailTvState().copyWith(isSavedToWatchList: false));
  //
  //   final iconFinder = find.byIcon(Icons.add);
  //
  //   await tester.pumpWidget(_makeTestableWidget(TvDetailPage(
  //     id: id,
  //   )));
  //   await tester.pump();
  //
  //   expect(iconFinder, findsOneWidget);
  // });

  // testWidgets(
  //     'Watchlist button should display add icon when Tv not added to watchlist',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.TvState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.Tv).thenReturn(testTvDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.TvRecommendations).thenReturn(<Tv>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //
  //   final watchlistButtonIcon = find.byIcon(Icons.add);
  //
  //   await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));
  //
  //   expect(watchlistButtonIcon, findsOneWidget);
  // });
  //
  // testWidgets(
  //     'Watchlist button should dispay check icon when Tv is added to wathclist',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.TvState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.Tv).thenReturn(testTvDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.TvRecommendations).thenReturn(<Tv>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(true);
  //
  //   final watchlistButtonIcon = find.byIcon(Icons.check);
  //
  //   await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));
  //
  //   expect(watchlistButtonIcon, findsOneWidget);
  // });
  //
  // testWidgets(
  //     'Watchlist button should display Snackbar when added to watchlist',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.TvState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.Tv).thenReturn(testTvDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.TvRecommendations).thenReturn(<Tv>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //   when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');
  //
  //   final watchlistButton = find.byType(ElevatedButton);
  //
  //   await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));
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
  //   when(mockNotifier.TvState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.Tv).thenReturn(testTvDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.TvRecommendations).thenReturn(<Tv>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //   when(mockNotifier.watchlistMessage).thenReturn('Failed');
  //
  //   final watchlistButton = find.byType(ElevatedButton);
  //
  //   await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));
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
