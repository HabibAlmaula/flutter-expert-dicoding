
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/presentation/pages/movie/search_page.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'search_page_test.mocks.dart';

@GenerateMocks([MovieSearchNotifier])
void main() {
  late MockMovieSearchNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieSearchNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieSearchNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display Textfield with empty field',
          (WidgetTester tester) async {
        when(mockNotifier.state).thenReturn(RequestState.Empty);

        final textFieldFind = find.byType(TextField);

        await tester.pumpWidget(_makeTestableWidget(SearchPage()));

        expect(textFieldFind, findsOneWidget);
      });

  testWidgets('Page should show progress indicator when search is begin',
          (WidgetTester tester) async {
        when(mockNotifier.state).thenReturn(RequestState.Loading);

        await tester.pumpWidget(_makeTestableWidget(SearchPage()));
        await tester.enterText(find.byType(TextField), 'spiderman');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        when(mockNotifier.state).thenReturn(RequestState.Loading);

        expect(centerFinder, findsWidgets);
        expect(progressBarFinder, findsWidgets);
      });

  testWidgets('Page should show ListView when search is done, and found Movie',
          (WidgetTester tester) async {
        when(mockNotifier.state).thenReturn(RequestState.Loaded);
        when(mockNotifier.searchResult).thenReturn(<Movie>[]);

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(SearchPage()));

        expect(listViewFinder, findsOneWidget);
      });
}