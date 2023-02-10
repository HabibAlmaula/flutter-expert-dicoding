import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/presentation/pages/tv/search/bloc/search_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv/search/search_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchTvBloc extends MockBloc<SearchTvEvent, SearchTvState>
    implements SearchTvBloc {} // extend MockBloc rather than Mock

void main() {
  late MockSearchTvBloc _mockSearchTvBloc;

  setUpAll(() {
    _mockSearchTvBloc = MockSearchTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchTvBloc>.value(
      value: _mockSearchTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display Textfield with empty field',
          (WidgetTester tester) async {
        whenListen<SearchTvState>(
          _mockSearchTvBloc,
          Stream<SearchTvState>.fromIterable([
            SearchEmpty(),
          ]),
        );
        when(() => _mockSearchTvBloc.state).thenReturn(SearchEmpty());

        final textFieldFind = find.byType(TextField);

        await tester.pumpWidget(_makeTestableWidget(SearchTvPage()));

        expect(textFieldFind, findsOneWidget);
      });

  testWidgets('Page should show progress indicator when search is begin',
          (WidgetTester tester) async {
        when(() => _mockSearchTvBloc.state).thenReturn(SearchLoading());

        await tester.pumpWidget(_makeTestableWidget(SearchTvPage()));
        await tester.enterText(find.byType(TextField), 'spiderman');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        when(() => _mockSearchTvBloc.state).thenReturn(SearchLoading());

        expect(centerFinder, findsWidgets);
        expect(progressBarFinder, findsWidgets);
      });

  testWidgets('Page should show ListView when search is done, and found Movie',
          (WidgetTester tester) async {
        when(() => _mockSearchTvBloc.state).thenReturn(SearchHasData(<Tv>[]));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(SearchTvPage()));

        expect(listViewFinder, findsOneWidget);
      });
}
