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
    path: SplashPage.routeName,
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
          path: HomeMoviePage.routeName,
          page: HomeMoviePage,
        ),
        AutoRoute(
          usesPathAsKey: true,
          path: HomeTvPage.routeName,
          page: HomeTvPage,
        ),
        AutoRoute(
          usesPathAsKey: true,
          path: MainWatchListPage.routeName,
          page: MainWatchListPage,
        ),
        AutoRoute(
          usesPathAsKey: true,
          path: AboutPage.routeName,
          page: AboutPage,
        ),
      ]),
  AutoRoute(
    usesPathAsKey: true,
    path: ListMoviesPage.routeName,
    page: ListMoviesPage,
  ),
  AutoRoute(
    usesPathAsKey: true,
    path: ListTvPage.routeName,
    page: ListTvPage,
  ),
  AutoRoute(
    usesPathAsKey: true,
    path: SearchPage.routeName,
    page: SearchPage,
  ),
  AutoRoute(
    usesPathAsKey: true,
    path: SearchTvPage.routeName,
    page: SearchTvPage,
  ),
  AutoRoute(
    maintainState: false,
    usesPathAsKey: true,
    path: MovieDetailPage.routeName,
    page: MovieDetailPage,
  ),
  AutoRoute(
    maintainState: false,
    usesPathAsKey: true,
    path: TvDetailPage.routeName,
    page: TvDetailPage,
  ),
])
class AppRouter extends _$AppRouter {}
