import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/pages/home/bloc/home_movie_bloc.dart';
import 'package:movie/presentation/pages/home/home_movie_page.dart';

class MockHomeMovieBloc extends MockBloc<HomeMovieEvent, HomeMovieState>
    implements HomeMovieBloc {}

void main() {

  late HomeMovieBloc mockHomeMovieBloc;

  setUp(() {
    mockHomeMovieBloc = MockHomeMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
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
        const HomeMovieState().nowPlayingLoading(),
        const HomeMovieState().popularLoading(),
        const HomeMovieState().topRatedLoading(),
      ]),
    );
    when(() => mockHomeMovieBloc.state)
        .thenReturn(const HomeMovieState().nowPlayingLoading());
    when(() => mockHomeMovieBloc.state)
        .thenReturn(const HomeMovieState().popularLoading());
    when(() => mockHomeMovieBloc.state)
        .thenReturn(const HomeMovieState().topRatedLoading());

    final textHeaderFinder = find.byType(Text);
    await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));
    expect(textHeaderFinder, findsWidgets);
  });

  testWidgets('Page should text header when loaded',
      (WidgetTester tester) async {
    whenListen<HomeMovieState>(
      mockHomeMovieBloc,
      Stream<HomeMovieState>.fromIterable([
        const HomeMovieState().nowPlayingHasData(result: <Movie>[]),
        const HomeMovieState().popularHasData(result: <Movie>[]),
        const HomeMovieState().topRatedHasData(result: <Movie>[]),
      ]),
    );
    when(() => mockHomeMovieBloc.state)
        .thenReturn(const HomeMovieState().nowPlayingHasData(result: <Movie>[]));
    when(() => mockHomeMovieBloc.state)
        .thenReturn(const HomeMovieState().popularHasData(result: <Movie>[]));
    when(() => mockHomeMovieBloc.state)
        .thenReturn(const HomeMovieState().topRatedHasData(result: <Movie>[]));

    final textHeaderFinder = find.byType(Text);
    await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));
    expect(textHeaderFinder, findsWidgets);
  });

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    whenListen<HomeMovieState>(
      mockHomeMovieBloc,
      Stream<HomeMovieState>.fromIterable([
        const HomeMovieState().nowPlayingLoading(),
        const HomeMovieState().popularLoading(),
        const HomeMovieState().topRatedLoading(),
      ]),
    );
    when(() => mockHomeMovieBloc.state)
        .thenReturn(const HomeMovieState().nowPlayingLoading());
    when(() => mockHomeMovieBloc.state)
        .thenReturn(const HomeMovieState().popularLoading());
    when(() => mockHomeMovieBloc.state)
        .thenReturn(const HomeMovieState().topRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    whenListen<HomeMovieState>(
      mockHomeMovieBloc,
      Stream<HomeMovieState>.fromIterable([
        const HomeMovieState().nowPlayingHasData(result: <Movie>[]),
        const HomeMovieState().popularHasData(result: <Movie>[]),
        const HomeMovieState().topRatedHasData(result: <Movie>[]),
      ]),
    );
    when(() => mockHomeMovieBloc.state)
        .thenReturn(const HomeMovieState().nowPlayingHasData(result: <Movie>[]));
    when(() => mockHomeMovieBloc.state)
        .thenReturn(const HomeMovieState().popularHasData(result: <Movie>[]));
    when(() => mockHomeMovieBloc.state)
        .thenReturn(const HomeMovieState().topRatedHasData(result: <Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

    expect(listViewFinder, findsWidgets);
  });
}
