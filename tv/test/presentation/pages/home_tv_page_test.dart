import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/pages/home/bloc/home_tv_bloc.dart';
import 'package:tv/presentation/pages/home/home_tv_page.dart';

class MockHomeTvBloc extends MockBloc<HomeTvEvent, HomeTvState>
    implements HomeTvBloc {}

void main() {

  late HomeTvBloc mockHomeTvBloc;

  setUp(() {
    mockHomeTvBloc = MockHomeTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<HomeTvBloc>.value(
      value: mockHomeTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should text header when loading',
      (WidgetTester tester) async {
    whenListen<HomeTvState>(
      mockHomeTvBloc,
      Stream<HomeTvState>.fromIterable([
        const HomeTvState().nowPlayingLoading(),
        const HomeTvState().popularLoading(),
        const HomeTvState().topRatedLoading(),
      ]),
    );
    when(() => mockHomeTvBloc.state)
        .thenReturn(const HomeTvState().nowPlayingLoading());
    when(() => mockHomeTvBloc.state)
        .thenReturn(const HomeTvState().popularLoading());
    when(() => mockHomeTvBloc.state)
        .thenReturn(const HomeTvState().topRatedLoading());

    final textHeaderFinder = find.byType(Text);
    await tester.pumpWidget(makeTestableWidget(const HomeTvPage()));
    expect(textHeaderFinder, findsWidgets);
  });

  testWidgets('Page should text header when loaded',
      (WidgetTester tester) async {
    whenListen<HomeTvState>(
      mockHomeTvBloc,
      Stream<HomeTvState>.fromIterable([
        const HomeTvState().nowPlayingHasData(result: <Tv>[]),
        const HomeTvState().popularHasData(result: <Tv>[]),
        const HomeTvState().topRatedHasData(result: <Tv>[]),
      ]),
    );
    when(() => mockHomeTvBloc.state)
        .thenReturn(const HomeTvState().nowPlayingHasData(result: <Tv>[]));
    when(() => mockHomeTvBloc.state)
        .thenReturn(const HomeTvState().popularHasData(result: <Tv>[]));
    when(() => mockHomeTvBloc.state)
        .thenReturn(const HomeTvState().topRatedHasData(result: <Tv>[]));

    final textHeaderFinder = find.byType(Text);
    await tester.pumpWidget(makeTestableWidget(const HomeTvPage()));
    expect(textHeaderFinder, findsWidgets);
  });

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    whenListen<HomeTvState>(
      mockHomeTvBloc,
      Stream<HomeTvState>.fromIterable([
        const HomeTvState().nowPlayingLoading(),
        const HomeTvState().popularLoading(),
        const HomeTvState().topRatedLoading(),
      ]),
    );
    when(() => mockHomeTvBloc.state)
        .thenReturn(const HomeTvState().nowPlayingLoading());
    when(() => mockHomeTvBloc.state)
        .thenReturn(const HomeTvState().popularLoading());
    when(() => mockHomeTvBloc.state)
        .thenReturn(const HomeTvState().topRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(makeTestableWidget(const HomeTvPage()));
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    whenListen<HomeTvState>(
      mockHomeTvBloc,
      Stream<HomeTvState>.fromIterable([
        const HomeTvState().nowPlayingHasData(result: <Tv>[]),
        const HomeTvState().popularHasData(result: <Tv>[]),
        const HomeTvState().topRatedHasData(result: <Tv>[]),
      ]),
    );
    when(() => mockHomeTvBloc.state)
        .thenReturn(const HomeTvState().nowPlayingHasData(result: <Tv>[]));
    when(() => mockHomeTvBloc.state)
        .thenReturn(const HomeTvState().popularHasData(result: <Tv>[]));
    when(() => mockHomeTvBloc.state)
        .thenReturn(const HomeTvState().topRatedHasData(result: <Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const HomeTvPage()));

    expect(listViewFinder, findsWidgets);
  });
}
