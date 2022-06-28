// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

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
          routeData: routeData, child: const SplashPage());
    },
    MainRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const MainPage());
    },
    HomeMovieRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: HomeMoviePage());
    },
    HomeTvRoute.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: HomeTvPage());
    },
    SearchRoute.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: SearchPage());
    },
    SearchTvRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: SearchTvPage());
    },
    PopularMoviesRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: PopularMoviesPage());
    },
    TopRatedMoviesRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: TopRatedMoviesPage());
    },
    MovieDetailRoute.name: (routeData) {
      final args = routeData.argsAs<MovieDetailRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData, child: MovieDetailPage(id: args.id));
    },
    TvDetailRoute.name: (routeData) {
      final args = routeData.argsAs<TvDetailRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData, child: TvDetailPage(id: args.id));
    },
    PopularTvRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: PopularTvPage());
    },
    TopRatedTvRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: TopRatedTvPage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('/#redirect',
            path: '/', redirectTo: '/splash-page', fullMatch: true),
        RouteConfig(SplashRoute.name,
            path: '/splash-page',
            usesPathAsKey: true,
            children: [
              RouteConfig('*#redirect',
                  path: '*',
                  parent: SplashRoute.name,
                  redirectTo: '',
                  fullMatch: true)
            ]),
        RouteConfig(MainRoute.name, path: '/main-page', usesPathAsKey: true),
        RouteConfig(HomeMovieRoute.name, path: '/movie', usesPathAsKey: true),
        RouteConfig(HomeTvRoute.name, path: '/home-tv', usesPathAsKey: true),
        RouteConfig(SearchRoute.name, path: '/search', usesPathAsKey: true),
        RouteConfig(SearchTvRoute.name,
            path: '/search-tv', usesPathAsKey: true),
        RouteConfig(PopularMoviesRoute.name,
            path: '/popular-movie', usesPathAsKey: true),
        RouteConfig(TopRatedMoviesRoute.name,
            path: '/top-rated-movie', usesPathAsKey: true),
        RouteConfig(MovieDetailRoute.name,
            path: '/detail-movie', usesPathAsKey: true),
        RouteConfig(TvDetailRoute.name,
            path: '/detail-tv/:id', usesPathAsKey: true),
        RouteConfig(PopularTvRoute.name,
            path: '/popular-tv', usesPathAsKey: true),
        RouteConfig(TopRatedTvRoute.name,
            path: '/top-rated-tv', usesPathAsKey: true)
      ];
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(SplashRoute.name,
            path: '/splash-page', initialChildren: children);

  static const String name = 'SplashRoute';
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute() : super(MainRoute.name, path: '/main-page');

  static const String name = 'MainRoute';
}

/// generated route for
/// [HomeMoviePage]
class HomeMovieRoute extends PageRouteInfo<void> {
  const HomeMovieRoute() : super(HomeMovieRoute.name, path: '/movie');

  static const String name = 'HomeMovieRoute';
}

/// generated route for
/// [HomeTvPage]
class HomeTvRoute extends PageRouteInfo<void> {
  const HomeTvRoute() : super(HomeTvRoute.name, path: '/home-tv');

  static const String name = 'HomeTvRoute';
}

/// generated route for
/// [SearchPage]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute() : super(SearchRoute.name, path: '/search');

  static const String name = 'SearchRoute';
}

/// generated route for
/// [SearchTvPage]
class SearchTvRoute extends PageRouteInfo<void> {
  const SearchTvRoute() : super(SearchTvRoute.name, path: '/search-tv');

  static const String name = 'SearchTvRoute';
}

/// generated route for
/// [PopularMoviesPage]
class PopularMoviesRoute extends PageRouteInfo<void> {
  const PopularMoviesRoute()
      : super(PopularMoviesRoute.name, path: '/popular-movie');

  static const String name = 'PopularMoviesRoute';
}

/// generated route for
/// [TopRatedMoviesPage]
class TopRatedMoviesRoute extends PageRouteInfo<void> {
  const TopRatedMoviesRoute()
      : super(TopRatedMoviesRoute.name, path: '/top-rated-movie');

  static const String name = 'TopRatedMoviesRoute';
}

/// generated route for
/// [MovieDetailPage]
class MovieDetailRoute extends PageRouteInfo<MovieDetailRouteArgs> {
  MovieDetailRoute({required int id})
      : super(MovieDetailRoute.name,
            path: '/detail-movie', args: MovieDetailRouteArgs(id: id));

  static const String name = 'MovieDetailRoute';
}

class MovieDetailRouteArgs {
  const MovieDetailRouteArgs({required this.id});

  final int id;

  @override
  String toString() {
    return 'MovieDetailRouteArgs{id: $id}';
  }
}

/// generated route for
/// [TvDetailPage]
class TvDetailRoute extends PageRouteInfo<TvDetailRouteArgs> {
  TvDetailRoute({required int id})
      : super(TvDetailRoute.name,
            path: '/detail-tv/:id', args: TvDetailRouteArgs(id: id));

  static const String name = 'TvDetailRoute';
}

class TvDetailRouteArgs {
  const TvDetailRouteArgs({required this.id});

  final int id;

  @override
  String toString() {
    return 'TvDetailRouteArgs{id: $id}';
  }
}

/// generated route for
/// [PopularTvPage]
class PopularTvRoute extends PageRouteInfo<void> {
  const PopularTvRoute() : super(PopularTvRoute.name, path: '/popular-tv');

  static const String name = 'PopularTvRoute';
}

/// generated route for
/// [TopRatedTvPage]
class TopRatedTvRoute extends PageRouteInfo<void> {
  const TopRatedTvRoute() : super(TopRatedTvRoute.name, path: '/top-rated-tv');

  static const String name = 'TopRatedTvRoute';
}
