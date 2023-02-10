import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/presentation/pages/tv/home/bloc/home_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv/home/home_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeTvBloc extends MockBloc<HomeTvEvent, HomeTvState>
    implements HomeTvBloc {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late HomeTvBloc _mockHomeTvBloc;

  setUp(() {
    _mockHomeTvBloc = MockHomeTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<HomeTvBloc>.value(
      value: _mockHomeTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should text header when loading',
      (WidgetTester tester) async {
    whenListen<HomeTvState>(
      _mockHomeTvBloc,
      Stream<HomeTvState>.fromIterable([
        HomeTvState().nowPlayingLoading(),
        HomeTvState().popularLoading(),
        HomeTvState().topRatedLoading(),
      ]),
    );
    when(() => _mockHomeTvBloc.state)
        .thenReturn(HomeTvState().nowPlayingLoading());
    when(() => _mockHomeTvBloc.state)
        .thenReturn(HomeTvState().popularLoading());
    when(() => _mockHomeTvBloc.state)
        .thenReturn(HomeTvState().topRatedLoading());

    final textHeaderFinder = find.byType(Text);
    await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));
    expect(textHeaderFinder, findsWidgets);
  });

  testWidgets('Page should text header when loaded',
      (WidgetTester tester) async {
    whenListen<HomeTvState>(
      _mockHomeTvBloc,
      Stream<HomeTvState>.fromIterable([
        HomeTvState().nowPlayingHasData(result: <Tv>[]),
        HomeTvState().popularHasData(result: <Tv>[]),
        HomeTvState().topRatedHasData(result: <Tv>[]),
      ]),
    );
    when(() => _mockHomeTvBloc.state)
        .thenReturn(HomeTvState().nowPlayingHasData(result: <Tv>[]));
    when(() => _mockHomeTvBloc.state)
        .thenReturn(HomeTvState().popularHasData(result: <Tv>[]));
    when(() => _mockHomeTvBloc.state)
        .thenReturn(HomeTvState().topRatedHasData(result: <Tv>[]));

    final textHeaderFinder = find.byType(Text);
    await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));
    expect(textHeaderFinder, findsWidgets);
  });

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    whenListen<HomeTvState>(
      _mockHomeTvBloc,
      Stream<HomeTvState>.fromIterable([
        HomeTvState().nowPlayingLoading(),
        HomeTvState().popularLoading(),
        HomeTvState().topRatedLoading(),
      ]),
    );
    when(() => _mockHomeTvBloc.state)
        .thenReturn(HomeTvState().nowPlayingLoading());
    when(() => _mockHomeTvBloc.state)
        .thenReturn(HomeTvState().popularLoading());
    when(() => _mockHomeTvBloc.state)
        .thenReturn(HomeTvState().topRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    whenListen<HomeTvState>(
      _mockHomeTvBloc,
      Stream<HomeTvState>.fromIterable([
        HomeTvState().nowPlayingHasData(result: <Tv>[]),
        HomeTvState().popularHasData(result: <Tv>[]),
        HomeTvState().topRatedHasData(result: <Tv>[]),
      ]),
    );
    when(() => _mockHomeTvBloc.state)
        .thenReturn(HomeTvState().nowPlayingHasData(result: <Tv>[]));
    when(() => _mockHomeTvBloc.state)
        .thenReturn(HomeTvState().popularHasData(result: <Tv>[]));
    when(() => _mockHomeTvBloc.state)
        .thenReturn(HomeTvState().topRatedHasData(result: <Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

    expect(listViewFinder, findsWidgets);
  });
}
