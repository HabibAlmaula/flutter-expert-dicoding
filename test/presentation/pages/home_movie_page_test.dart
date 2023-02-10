import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/presentation/pages/movie/home/bloc/home_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie/home/home_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeMovieBloc extends MockBloc<HomeMovieEvent, HomeMovieState>
    implements HomeMovieBloc {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late HomeMovieBloc mockHomeMovieBloc;

  setUp(() {
    mockHomeMovieBloc = MockHomeMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<HomeMovieBloc>.value(
      value: mockHomeMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should text header when loading',
      (WidgetTester tester) async {
    whenListen<HomeMovieState>(
      mockHomeMovieBloc,
      Stream<HomeMovieState>.fromIterable([
        HomeMovieState().nowPlayingLoading(),
        HomeMovieState().popularLoading(),
        HomeMovieState().topRatedLoading(),
      ]),
    );
    when(() => mockHomeMovieBloc.state)
        .thenReturn(HomeMovieState().nowPlayingLoading());
    when(() => mockHomeMovieBloc.state)
        .thenReturn(HomeMovieState().popularLoading());
    when(() => mockHomeMovieBloc.state)
        .thenReturn(HomeMovieState().topRatedLoading());

    final textHeaderFinder = find.byType(Text);
    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));
    expect(textHeaderFinder, findsWidgets);
  });

  testWidgets('Page should text header when loaded',
      (WidgetTester tester) async {
    whenListen<HomeMovieState>(
      mockHomeMovieBloc,
      Stream<HomeMovieState>.fromIterable([
        HomeMovieState().nowPlayingHasData(result: <Movie>[]),
        HomeMovieState().popularHasData(result: <Movie>[]),
        HomeMovieState().topRatedHasData(result: <Movie>[]),
      ]),
    );
    when(() => mockHomeMovieBloc.state)
        .thenReturn(HomeMovieState().nowPlayingHasData(result: <Movie>[]));
    when(() => mockHomeMovieBloc.state)
        .thenReturn(HomeMovieState().popularHasData(result: <Movie>[]));
    when(() => mockHomeMovieBloc.state)
        .thenReturn(HomeMovieState().topRatedHasData(result: <Movie>[]));

    final textHeaderFinder = find.byType(Text);
    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));
    expect(textHeaderFinder, findsWidgets);
  });

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    whenListen<HomeMovieState>(
      mockHomeMovieBloc,
      Stream<HomeMovieState>.fromIterable([
        HomeMovieState().nowPlayingLoading(),
        HomeMovieState().popularLoading(),
        HomeMovieState().topRatedLoading(),
      ]),
    );
    when(() => mockHomeMovieBloc.state)
        .thenReturn(HomeMovieState().nowPlayingLoading());
    when(() => mockHomeMovieBloc.state)
        .thenReturn(HomeMovieState().popularLoading());
    when(() => mockHomeMovieBloc.state)
        .thenReturn(HomeMovieState().topRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    whenListen<HomeMovieState>(
      mockHomeMovieBloc,
      Stream<HomeMovieState>.fromIterable([
        HomeMovieState().nowPlayingHasData(result: <Movie>[]),
        HomeMovieState().popularHasData(result: <Movie>[]),
        HomeMovieState().topRatedHasData(result: <Movie>[]),
      ]),
    );
    when(() => mockHomeMovieBloc.state)
        .thenReturn(HomeMovieState().nowPlayingHasData(result: <Movie>[]));
    when(() => mockHomeMovieBloc.state)
        .thenReturn(HomeMovieState().popularHasData(result: <Movie>[]));
    when(() => mockHomeMovieBloc.state)
        .thenReturn(HomeMovieState().topRatedHasData(result: <Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(listViewFinder, findsWidgets);
  });
}
