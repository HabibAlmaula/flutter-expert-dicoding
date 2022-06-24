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
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('/#redirect',
            path: '/', redirectTo: '/splash-page', fullMatch: true),
        RouteConfig(SplashRoute.name, path: '/splash-page', children: [
          RouteConfig('*#redirect',
              path: '*',
              parent: SplashRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        RouteConfig(MainRoute.name, path: '/main-page'),
        RouteConfig(HomeMovieRoute.name, path: '/home-movie'),
        RouteConfig(HomeTvRoute.name, path: '/home-tv'),
        RouteConfig(SearchRoute.name, path: '/search'),
        RouteConfig(SearchRoute.name, path: '/search'),
        RouteConfig(PopularMoviesRoute.name, path: '/popular-movie'),
        RouteConfig(TopRatedMoviesRoute.name, path: '/top-rated-movie'),
        RouteConfig(MovieDetailRoute.name, path: '/detail')
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
  const HomeMovieRoute() : super(HomeMovieRoute.name, path: '/home-movie');

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
            path: '/detail', args: MovieDetailRouteArgs(id: id));

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
