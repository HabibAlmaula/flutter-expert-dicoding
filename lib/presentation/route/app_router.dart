library app_router;
import 'package:about/about_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:ditonton/presentation/pages/main_page.dart';
import 'package:ditonton/presentation/pages/main_watch_list.dart';
import 'package:ditonton/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/detail/movie_detail_page.dart';
import 'package:movie/presentation/pages/home/home_movie_page.dart';
import 'package:movie/presentation/pages/list_movie/list_movies_page.dart';
import 'package:movie/presentation/pages/search/search_page.dart';
import 'package:tv/presentation/pages/detail/tv_detail_page.dart';
import 'package:tv/presentation/pages/home/home_tv_page.dart';
import 'package:tv/presentation/pages/list_tv/list_tv_page.dart';
import 'package:tv/presentation/pages/search/search_tv_page.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(
    usesPathAsKey: true,
    initial: true,
    path: SplashPage.ROUTE_NAME,
    page: SplashPage,
    children: [
      RedirectRoute(path: '*', redirectTo: ''),
    ],
  ),
  AutoRoute(
      usesPathAsKey: true,
      path: MainPage.routeName,
      page: MainPage,
      children: [
        AutoRoute(
          usesPathAsKey: true,
          path: HomeMoviePage.ROUTE_NAME,
          page: HomeMoviePage,
        ),
        AutoRoute(
          usesPathAsKey: true,
          path: HomeTvPage.ROUTE_NAME,
          page: HomeTvPage,
        ),
        AutoRoute(
          usesPathAsKey: true,
          path: MainWatchListPage.ROUTE_NAME,
          page: MainWatchListPage,
        ),
        AutoRoute(
          usesPathAsKey: true,
          path: AboutPage.ROUTE_NAME,
          page: AboutPage,
        ),
      ]),
  AutoRoute(
    usesPathAsKey: true,
    path: ListMoviesPage.ROUTE_NAME,
    page: ListMoviesPage,
  ),
  AutoRoute(
    usesPathAsKey: true,
    path: ListTvPage.ROUTE_NAME,
    page: ListTvPage,
  ),
  AutoRoute(
    usesPathAsKey: true,
    path: SearchPage.ROUTE_NAME,
    page: SearchPage,
  ),
  AutoRoute(
    usesPathAsKey: true,
    path: SearchTvPage.ROUTE_NAME,
    page: SearchTvPage,
  ),
  AutoRoute(
    usesPathAsKey: true,
    path: MovieDetailPage.ROUTE_NAME,
    page: MovieDetailPage,
  ),
  AutoRoute(
    usesPathAsKey: true,
    path: TvDetailPage.ROUTE_NAME,
    page: TvDetailPage,
  ),
])
class AppRouter extends _$AppRouter {}
