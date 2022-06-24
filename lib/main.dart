import 'package:auto_route/auto_route.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/navigation_provider.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/tv/popular_tv_notifier.dart';
import 'package:ditonton/presentation/provider/tv/top_rated_tv_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_list_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/route/app_router.dart';
import 'package:ditonton/presentation/route/app_router_observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => di.locator<MovieListNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => di.locator<MovieDetailNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => di.locator<MovieSearchNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => di.locator<TopRatedMoviesNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => di.locator<PopularMoviesNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => di.locator<WatchlistMovieNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => di.locator<TvListNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => di.locator<TopRatedTvNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => di.locator<PopularTvNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => NavigationProvider(),
          ),
        ],
        child: MaterialApp.router(
          routeInformationParser: _appRouter.defaultRouteParser(),
          routerDelegate: AutoRouterDelegate(_appRouter,
              navigatorObservers: () => [AppRouterObserver()]),
          title: 'Flutter Demo',
          theme: ThemeData.dark().copyWith(
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: ZoomPageTransitionsBuilder()
            }),
            colorScheme: kColorScheme,
            primaryColor: kRichBlack,
            scaffoldBackgroundColor: kRichBlack,
            textTheme: kTextTheme,
          ),
          builder: (context, router) {
            return router!;
          },
        )

        // MaterialApp(
        //   title: 'Flutter Demo',
        //   theme: ThemeData.dark().copyWith(
        //     colorScheme: kColorScheme,
        //     primaryColor: kRichBlack,
        //     scaffoldBackgroundColor: kRichBlack,
        //     textTheme: kTextTheme,
        //   ),
        //   home: MainPage(),
        //   navigatorObservers: [routeObserver],
        //   onGenerateRoute: (RouteSettings settings) {
        //     switch (settings.name) {
        //       case MainPage.routeName:
        //         return MaterialPageRoute(builder: (_) => MainPage());
        //       case PopularMoviesPage.ROUTE_NAME:
        //         return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
        //       case TopRatedMoviesPage.ROUTE_NAME:
        //         return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
        //       case MovieDetailPage.ROUTE_NAME:
        //         final id = settings.arguments as int;
        //         return MaterialPageRoute(
        //           builder: (_) => MovieDetailPage(id: id),
        //           settings: settings,
        //         );
        //       case SearchPage.ROUTE_NAME:
        //         return CupertinoPageRoute(builder: (_) => SearchPage());
        //       case WatchlistMoviesPage.ROUTE_NAME:
        //         return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
        //       case AboutPage.ROUTE_NAME:
        //         return MaterialPageRoute(builder: (_) => AboutPage());
        //       default:
        //         return MaterialPageRoute(builder: (_) {
        //           return Scaffold(
        //             body: Center(
        //               child: Text('Page not found :('),
        //             ),
        //           );
        //         });
        //     }
        //   },
        // ),
        );
  }
}
