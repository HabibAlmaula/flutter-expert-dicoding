import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/pages/search/bloc/search_movie_bloc.dart';
import 'package:movie/presentation/pages/search/search_page.dart';

class MockSearchMovieBloc extends MockBloc<SearchMovieEvent, SearchMovieState>
    implements SearchMovieBloc {} // extend MockBloc rather than Mock

void main() {
  late MockSearchMovieBloc mockSearchMovieBloc;

  setUpAll(() {
    mockSearchMovieBloc = MockSearchMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchMovieBloc>.value(
      value: mockSearchMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display Textfield with empty field',
      (WidgetTester tester) async {
    whenListen<SearchMovieState>(
      mockSearchMovieBloc,
      Stream<SearchMovieState>.fromIterable([
        SearchEmpty(),
      ]),
    );
    when(() => mockSearchMovieBloc.state).thenReturn(SearchEmpty());

    final textFieldFind = find.byType(TextField);

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(textFieldFind, findsOneWidget);
  });

  testWidgets('Page should show progress indicator when search is begin',
      (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state).thenReturn(SearchLoading());

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));
    await tester.enterText(find.byType(TextField), 'spiderman');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    when(() => mockSearchMovieBloc.state).thenReturn(SearchLoading());

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should show ListView when search is done, and found Movie',
      (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state).thenReturn(const SearchHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(listViewFinder, findsOneWidget);
  });
}
