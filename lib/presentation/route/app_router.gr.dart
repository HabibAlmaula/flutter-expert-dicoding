// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    MainRoute.name: (routeData) {
      final args =
          routeData.argsAs<MainRouteArgs>(orElse: () => const MainRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: MainPage(key: args.key),
      );
    },
    ListMoviesRoute.name: (routeData) {
      final args = routeData.argsAs<ListMoviesRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: ListMoviesPage(
          key: args.key,
          moviesType: args.moviesType,
        ),
      );
    },
    ListTvRoute.name: (routeData) {
      final args = routeData.argsAs<ListTvRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: ListTvPage(
          key: args.key,
          tvType: args.tvType,
        ),
      );
    },
    SearchRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SearchPage(),
      );
    },
    SearchTvRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SearchTvPage(),
      );
    },
    MovieDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MovieDetailRouteArgs>(
          orElse: () => MovieDetailRouteArgs(id: pathParams.getInt('id')));
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: MovieDetailPage(
          key: args.key,
          id: args.id,
        ),
        maintainState: false,
      );
    },
    TvDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<TvDetailRouteArgs>(
          orElse: () => TvDetailRouteArgs(id: pathParams.getInt('id')));
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: TvDetailPage(
          key: args.key,
          id: args.id,
        ),
        maintainState: false,
      );
    },
    HomeMovieRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomeMoviePage(),
      );
    },
    HomeTvRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomeTvPage(),
      );
    },
    MainWatchListRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const MainWatchListPage(),
      );
    },
    AboutRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const AboutPage(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/splash-page',
          fullMatch: true,
        ),
        RouteConfig(
          SplashRoute.name,
          path: '/splash-page',
          usesPathAsKey: true,
          children: [
            RouteConfig(
              '*#redirect',
              path: '*',
              parent: SplashRoute.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        RouteConfig(
          MainRoute.name,
          path: '/main-page',
          usesPathAsKey: true,
          children: [
            RouteConfig(
              HomeMovieRoute.name,
              path: 'movie',
              parent: MainRoute.name,
              usesPathAsKey: true,
            ),
            RouteConfig(
              HomeTvRoute.name,
              path: 'home-tv',
              parent: MainRoute.name,
              usesPathAsKey: true,
            ),
            RouteConfig(
              MainWatchListRoute.name,
              path: 'main-watchlist',
              parent: MainRoute.name,
              usesPathAsKey: true,
            ),
            RouteConfig(
              AboutRoute.name,
              path: 'about',
              parent: MainRoute.name,
              usesPathAsKey: true,
            ),
          ],
        ),
        RouteConfig(
          ListMoviesRoute.name,
          path: '/list-movie',
          usesPathAsKey: true,
        ),
        RouteConfig(
          ListTvRoute.name,
          path: '/list-tv',
          usesPathAsKey: true,
        ),
        RouteConfig(
          SearchRoute.name,
          path: '/search',
          usesPathAsKey: true,
        ),
        RouteConfig(
          SearchTvRoute.name,
          path: '/search-tv',
          usesPathAsKey: true,
        ),
        RouteConfig(
          MovieDetailRoute.name,
          path: '/detail-movie/:id',
          usesPathAsKey: true,
        ),
        RouteConfig(
          TvDetailRoute.name,
          path: '/detail-tv/:id',
          usesPathAsKey: true,
        ),
      ];
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          path: '/splash-page',
          initialChildren: children,
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<MainRouteArgs> {
  MainRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          MainRoute.name,
          path: '/main-page',
          args: MainRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

class MainRouteArgs {
  const MainRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'MainRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ListMoviesPage]
class ListMoviesRoute extends PageRouteInfo<ListMoviesRouteArgs> {
  ListMoviesRoute({
    Key? key,
    required FilterType moviesType,
  }) : super(
          ListMoviesRoute.name,
          path: '/list-movie',
          args: ListMoviesRouteArgs(
            key: key,
            moviesType: moviesType,
          ),
        );

  static const String name = 'ListMoviesRoute';
}

class ListMoviesRouteArgs {
  const ListMoviesRouteArgs({
    this.key,
    required this.moviesType,
  });

  final Key? key;

  final FilterType moviesType;

  @override
  String toString() {
    return 'ListMoviesRouteArgs{key: $key, moviesType: $moviesType}';
  }
}

/// generated route for
/// [ListTvPage]
class ListTvRoute extends PageRouteInfo<ListTvRouteArgs> {
  ListTvRoute({
    Key? key,
    required FilterType tvType,
  }) : super(
          ListTvRoute.name,
          path: '/list-tv',
          args: ListTvRouteArgs(
            key: key,
            tvType: tvType,
          ),
        );

  static const String name = 'ListTvRoute';
}

class ListTvRouteArgs {
  const ListTvRouteArgs({
    this.key,
    required this.tvType,
  });

  final Key? key;

  final FilterType tvType;

  @override
  String toString() {
    return 'ListTvRouteArgs{key: $key, tvType: $tvType}';
  }
}

/// generated route for
/// [SearchPage]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute()
      : super(
          SearchRoute.name,
          path: '/search',
        );

  static const String name = 'SearchRoute';
}

/// generated route for
/// [SearchTvPage]
class SearchTvRoute extends PageRouteInfo<void> {
  const SearchTvRoute()
      : super(
          SearchTvRoute.name,
          path: '/search-tv',
        );

  static const String name = 'SearchTvRoute';
}

/// generated route for
/// [MovieDetailPage]
class MovieDetailRoute extends PageRouteInfo<MovieDetailRouteArgs> {
  MovieDetailRoute({
    Key? key,
    required int id,
  }) : super(
          MovieDetailRoute.name,
          path: '/detail-movie/:id',
          args: MovieDetailRouteArgs(
            key: key,
            id: id,
          ),
          rawPathParams: {'id': id},
        );

  static const String name = 'MovieDetailRoute';
}

class MovieDetailRouteArgs {
  const MovieDetailRouteArgs({
    this.key,
    required this.id,
  });

  final Key? key;

  final int id;

  @override
  String toString() {
    return 'MovieDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [TvDetailPage]
class TvDetailRoute extends PageRouteInfo<TvDetailRouteArgs> {
  TvDetailRoute({
    Key? key,
    required int id,
  }) : super(
          TvDetailRoute.name,
          path: '/detail-tv/:id',
          args: TvDetailRouteArgs(
            key: key,
            id: id,
          ),
          rawPathParams: {'id': id},
        );

  static const String name = 'TvDetailRoute';
}

class TvDetailRouteArgs {
  const TvDetailRouteArgs({
    this.key,
    required this.id,
  });

  final Key? key;

  final int id;

  @override
  String toString() {
    return 'TvDetailRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [HomeMoviePage]
class HomeMovieRoute extends PageRouteInfo<void> {
  const HomeMovieRoute()
      : super(
          HomeMovieRoute.name,
          path: 'movie',
        );

  static const String name = 'HomeMovieRoute';
}

/// generated route for
/// [HomeTvPage]
class HomeTvRoute extends PageRouteInfo<void> {
  const HomeTvRoute()
      : super(
          HomeTvRoute.name,
          path: 'home-tv',
        );

  static const String name = 'HomeTvRoute';
}

/// generated route for
/// [MainWatchListPage]
class MainWatchListRoute extends PageRouteInfo<void> {
  const MainWatchListRoute()
      : super(
          MainWatchListRoute.name,
          path: 'main-watchlist',
        );

  static const String name = 'MainWatchListRoute';
}

/// generated route for
/// [AboutPage]
class AboutRoute extends PageRouteInfo<void> {
  const AboutRoute()
      : super(
          AboutRoute.name,
          path: 'about',
        );

  static const String name = 'AboutRoute';
}
