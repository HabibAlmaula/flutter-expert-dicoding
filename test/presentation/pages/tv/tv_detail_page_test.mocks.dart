// Mocks generated by Mockito 5.2.0 from annotations
// in ditonton/test/presentation/pages/tv/tv_detail_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i12;
import 'dart:ui' as _i13;

import 'package:ditonton/common/state_enum.dart' as _i10;
import 'package:ditonton/domain/entities/tv/tv.dart' as _i11;
import 'package:ditonton/domain/entities/tv/tv_detail.dart' as _i7;
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart' as _i2;
import 'package:ditonton/domain/usecases/tv/get_tv_recommendations.dart' as _i3;
import 'package:ditonton/domain/usecases/tv/get_watchlist_status_tv.dart'
    as _i4;
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart' as _i8;
import 'package:ditonton/domain/usecases/tv/remove_watchlist_tv.dart' as _i6;
import 'package:ditonton/domain/usecases/tv/save_watchlist_tv.dart' as _i5;
import 'package:ditonton/presentation/provider/tv/tv_detail_notifier.dart'
    as _i9;
import 'package:ditonton/presentation/provider/tv/watchlist_tv_notifier.dart'
    as _i14;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetTvDetail_0 extends _i1.Fake implements _i2.GetTvDetail {}

class _FakeGetTvRecommendations_1 extends _i1.Fake
    implements _i3.GetTvRecommendations {}

class _FakeGetWatchListStatusTv_2 extends _i1.Fake
    implements _i4.GetWatchListStatusTv {}

class _FakeSaveWatchlistTv_3 extends _i1.Fake implements _i5.SaveWatchlistTv {}

class _FakeRemoveWatchlistTv_4 extends _i1.Fake
    implements _i6.RemoveWatchlistTv {}

class _FakeTvDetail_5 extends _i1.Fake implements _i7.TvDetail {}

class _FakeGetWatchlistTv_6 extends _i1.Fake implements _i8.GetWatchlistTv {}

/// A class which mocks [TvDetailNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvDetailNotifier extends _i1.Mock implements _i9.TvDetailNotifier {
  MockTvDetailNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTvDetail get getTvDetail =>
      (super.noSuchMethod(Invocation.getter(#getTvDetail),
          returnValue: _FakeGetTvDetail_0()) as _i2.GetTvDetail);
  @override
  _i3.GetTvRecommendations get getTvRecommendations => (super.noSuchMethod(
      Invocation.getter(#getTvRecommendations),
      returnValue: _FakeGetTvRecommendations_1()) as _i3.GetTvRecommendations);
  @override
  _i4.GetWatchListStatusTv get getWatchListStatusTv => (super.noSuchMethod(
      Invocation.getter(#getWatchListStatusTv),
      returnValue: _FakeGetWatchListStatusTv_2()) as _i4.GetWatchListStatusTv);
  @override
  _i5.SaveWatchlistTv get saveWatchlistTv =>
      (super.noSuchMethod(Invocation.getter(#saveWatchlistTv),
          returnValue: _FakeSaveWatchlistTv_3()) as _i5.SaveWatchlistTv);
  @override
  _i6.RemoveWatchlistTv get removeWatchlistTv =>
      (super.noSuchMethod(Invocation.getter(#removeWatchlistTv),
          returnValue: _FakeRemoveWatchlistTv_4()) as _i6.RemoveWatchlistTv);
  @override
  _i7.TvDetail get tv => (super.noSuchMethod(Invocation.getter(#tv),
      returnValue: _FakeTvDetail_5()) as _i7.TvDetail);
  @override
  _i10.RequestState get tvState =>
      (super.noSuchMethod(Invocation.getter(#tvState),
          returnValue: _i10.RequestState.Empty) as _i10.RequestState);
  @override
  List<_i11.Tv> get tvRecommendations =>
      (super.noSuchMethod(Invocation.getter(#tvRecommendations),
          returnValue: <_i11.Tv>[]) as List<_i11.Tv>);
  @override
  _i10.RequestState get recommendationState =>
      (super.noSuchMethod(Invocation.getter(#recommendationState),
          returnValue: _i10.RequestState.Empty) as _i10.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get isAddedtoWatchlistTv =>
      (super.noSuchMethod(Invocation.getter(#isAddedtoWatchlistTv),
          returnValue: false) as bool);
  @override
  String get watchlistMessage =>
      (super.noSuchMethod(Invocation.getter(#watchlistMessage), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i12.Future<void> fetchTvDetail(int? id) => (super.noSuchMethod(
      Invocation.method(#fetchTvDetail, [id]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i12.Future<void>);
  @override
  _i12.Future<void> addWatchlist(_i7.TvDetail? tv) => (super.noSuchMethod(
      Invocation.method(#addWatchlist, [tv]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i12.Future<void>);
  @override
  _i12.Future<void> removeFromWatchlistTv(_i7.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#removeFromWatchlistTv, [tv]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i12.Future<void>);
  @override
  _i12.Future<void> loadWatchlistStatusTv(int? id) => (super.noSuchMethod(
      Invocation.method(#loadWatchlistStatusTv, [id]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i12.Future<void>);
  @override
  void addListener(_i13.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i13.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}

/// A class which mocks [WatchListTvNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchListTvNotifier extends _i1.Mock
    implements _i14.WatchListTvNotifier {
  MockWatchListTvNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.GetWatchlistTv get getWatchlistTv =>
      (super.noSuchMethod(Invocation.getter(#getWatchlistTv),
          returnValue: _FakeGetWatchlistTv_6()) as _i8.GetWatchlistTv);
  @override
  List<_i11.Tv> get watchlistTv =>
      (super.noSuchMethod(Invocation.getter(#watchlistTv),
          returnValue: <_i11.Tv>[]) as List<_i11.Tv>);
  @override
  _i10.RequestState get watchlistTvState =>
      (super.noSuchMethod(Invocation.getter(#watchlistTvState),
          returnValue: _i10.RequestState.Empty) as _i10.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i12.Future<void> fetchWatchlistTv() => (super.noSuchMethod(
      Invocation.method(#fetchWatchlistTv, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i12.Future<void>);
  @override
  void addListener(_i13.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i13.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}
