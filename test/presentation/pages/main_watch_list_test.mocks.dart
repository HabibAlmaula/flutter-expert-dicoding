// Mocks generated by Mockito 5.3.2 from annotations
// in ditonton/test/presentation/pages/main_watch_list_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:ui' as _i8;

import 'package:ditonton/common/app_enum.dart' as _i6;
import 'package:ditonton/domain/entities/movie/movie.dart' as _i5;
import 'package:ditonton/domain/entities/tv/tv.dart' as _i10;
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart'
    as _i2;
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart' as _i3;
import 'package:ditonton/presentation/provider/tv/watchlist_tv_notifier.dart'
    as _i9;
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart'
    as _i4;
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
// ignore_for_file: subtype_of_sealed_class

class _FakeGetWatchlistMovies_0 extends _i1.SmartFake
    implements _i2.GetWatchlistMovies {
  _FakeGetWatchlistMovies_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetWatchlistTv_1 extends _i1.SmartFake
    implements _i3.GetWatchlistTv {
  _FakeGetWatchlistTv_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WatchlistMovieNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistMovieNotifier extends _i1.Mock
    implements _i4.WatchlistMovieNotifier {
  MockWatchlistMovieNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetWatchlistMovies get getWatchlistMovies => (super.noSuchMethod(
        Invocation.getter(#getWatchlistMovies),
        returnValue: _FakeGetWatchlistMovies_0(
          this,
          Invocation.getter(#getWatchlistMovies),
        ),
      ) as _i2.GetWatchlistMovies);
  @override
  List<_i5.Movie> get watchlistMovies => (super.noSuchMethod(
        Invocation.getter(#watchlistMovies),
        returnValue: <_i5.Movie>[],
      ) as List<_i5.Movie>);
  @override
  _i6.RequestState get watchlistState => (super.noSuchMethod(
        Invocation.getter(#watchlistState),
        returnValue: _i6.RequestState.Empty,
      ) as _i6.RequestState);
  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: '',
      ) as String);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i7.Future<void> fetchWatchlistMovies() => (super.noSuchMethod(
        Invocation.method(
          #fetchWatchlistMovies,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  void addListener(_i8.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i8.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [WatchListTvNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchListTvNotifier extends _i1.Mock
    implements _i9.WatchListTvNotifier {
  MockWatchListTvNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.GetWatchlistTv get getWatchlistTv => (super.noSuchMethod(
        Invocation.getter(#getWatchlistTv),
        returnValue: _FakeGetWatchlistTv_1(
          this,
          Invocation.getter(#getWatchlistTv),
        ),
      ) as _i3.GetWatchlistTv);
  @override
  List<_i10.Tv> get watchlistTv => (super.noSuchMethod(
        Invocation.getter(#watchlistTv),
        returnValue: <_i10.Tv>[],
      ) as List<_i10.Tv>);
  @override
  _i6.RequestState get watchlistTvState => (super.noSuchMethod(
        Invocation.getter(#watchlistTvState),
        returnValue: _i6.RequestState.Empty,
      ) as _i6.RequestState);
  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: '',
      ) as String);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i7.Future<void> fetchWatchlistTv() => (super.noSuchMethod(
        Invocation.method(
          #fetchWatchlistTv,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  void addListener(_i8.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i8.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
