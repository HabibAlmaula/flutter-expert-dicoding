import 'package:auto_route/auto_route.dart';
import 'package:ditonton/common/app_enum.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/main_page.dart';
import 'package:ditonton/presentation/pages/main_watch_list.dart';
import 'package:ditonton/presentation/pages/movie/home/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movie/detail/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie/list_movie/list_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/popular/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/search/search_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/splash_page.dart';
import 'package:ditonton/presentation/pages/tv/home/home_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/popular/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/search/search_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/top_rated/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/detail/tv_detail_page.dart';
import 'package:flutter/material.dart';

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
    path: PopularMoviesPage.ROUTE_NAME,
    page: PopularMoviesPage,
  ),
  AutoRoute(
    usesPathAsKey: true,
    path: TopRatedMoviesPage.ROUTE_NAME,
    page: TopRatedMoviesPage,
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
  AutoRoute(
    usesPathAsKey: true,
    path: PopularTvPage.ROUTE_NAME,
    page: PopularTvPage,
  ),
  AutoRoute(
    usesPathAsKey: true,
    path: TopRatedTvPage.ROUTE_NAME,
    page: TopRatedTvPage,
  ),
])
class AppRouter extends _$AppRouter {}
