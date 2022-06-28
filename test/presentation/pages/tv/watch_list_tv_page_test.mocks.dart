// Mocks generated by Mockito 5.2.0 from annotations
// in ditonton/test/presentation/pages/watch_list_tv_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:ui' as _i7;

import 'package:ditonton/common/state_enum.dart' as _i5;
import 'package:ditonton/domain/entities/tv/tv.dart' as _i4;
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart' as _i2;
import 'package:ditonton/presentation/provider/tv/watchlist_tv_notifier.dart'
    as _i3;
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

class _FakeGetWatchlistTv_0 extends _i1.Fake implements _i2.GetWatchlistTv {}

/// A class which mocks [WatchListTvNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchListTvNotifier extends _i1.Mock
    implements _i3.WatchListTvNotifier {
  MockWatchListTvNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetWatchlistTv get getWatchlistTv =>
      (super.noSuchMethod(Invocation.getter(#getWatchlistTv),
          returnValue: _FakeGetWatchlistTv_0()) as _i2.GetWatchlistTv);
  @override
  List<_i4.Tv> get watchlistTv =>
      (super.noSuchMethod(Invocation.getter(#watchlistTv),
          returnValue: <_i4.Tv>[]) as List<_i4.Tv>);
  @override
  _i5.RequestState get watchlistTvState =>
      (super.noSuchMethod(Invocation.getter(#watchlistTvState),
          returnValue: _i5.RequestState.Empty) as _i5.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i6.Future<void> fetchWatchlistTv() =>
      (super.noSuchMethod(Invocation.method(#fetchWatchlistTv, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  void addListener(_i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i7.VoidCallback? listener) =>
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
