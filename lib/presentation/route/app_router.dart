import 'package:auto_route/auto_route.dart';
import 'package:ditonton/presentation/pages/main_page.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/search_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/splash_page.dart';
import 'package:ditonton/presentation/pages/tv/home_tv_page.dart';
import 'package:flutter/material.dart';
part 'app_router.gr.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(
    initial: true,
    path: SplashPage.ROUTE_NAME,
    page: SplashPage,
    children: [
      RedirectRoute(path: '*', redirectTo: ''),
    ],
  ),
  AutoRoute(
    path: MainPage.routeName,
    page: MainPage,
  ),
   AutoRoute(
    path: HomeMoviePage.ROUTE_NAME,
    page: HomeMoviePage,
  ),
  AutoRoute(
    path: HomeTvPage.ROUTE_NAME,
    page: HomeTvPage,
  ),
  AutoRoute(
    path: SearchPage.ROUTE_NAME,
    page: SearchPage,
  ),
  AutoRoute(
    path: SearchPage.ROUTE_NAME,
    page: SearchPage,
  ),
  AutoRoute(
    path: PopularMoviesPage.ROUTE_NAME,
    page: PopularMoviesPage,
  ),
  AutoRoute(
    path: TopRatedMoviesPage.ROUTE_NAME,
    page: TopRatedMoviesPage,
  ),
  AutoRoute(
    path: MovieDetailPage.ROUTE_NAME,
    page: MovieDetailPage,
  ),
])
class AppRouter extends _$AppRouter {}
