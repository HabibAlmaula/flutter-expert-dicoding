import 'package:auto_route/auto_route.dart';
import 'package:core/common/app_enum.dart';
import 'package:core/common/constants.dart';
import 'package:ditonton/presentation/route/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/widgets/movie_list_home.dart';
import 'package:movie/presentation/widgets/sub_heading_home.dart';

import 'bloc/home_movie_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  static const ROUTE_NAME = "movie";

  const HomeMoviePage({super.key});

  @override
  HomeMoviePageState createState() => HomeMoviePageState();
}

class HomeMoviePageState extends State<HomeMoviePage> {
  late HomeMovieBloc _homeMovieBloc;

  @override
  void initState() {
    super.initState();
    _homeMovieBloc = context.read<HomeMovieBloc>();
    Future.microtask(() {
      _homeMovieBloc.add(OnLoadNowPlayingMovies());
      _homeMovieBloc.add(OnLoadPopularMovies());
      _homeMovieBloc.add(OnLoadTopRatedMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
              context.pushRoute(SearchRoute());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<HomeMovieBloc, HomeMovieState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                Future.microtask(() {
                  _homeMovieBloc.add(OnLoadNowPlayingMovies());
                  _homeMovieBloc.add(OnLoadPopularMovies());
                  _homeMovieBloc.add(OnLoadTopRatedMovies());
                });
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Now Playing',
                      style: AppConstant.kHeading6,
                    ),
                    Builder(builder: (context) {
                      if (state.nowPlayingMovieState == RequestState.Loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.nowPlayingMovieState ==
                          RequestState.Loaded) {
                        return MovieListHome(movies: state.nowPlayingMovies);
                      } else {
                        return const Text('Failed');
                      }
                    }),
                    SubHeadingHome(
                        title: 'Popular',
                        onTap: () =>
                            // Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
                            context.pushRoute(ListMoviesRoute(
                                moviesType: FilterType.Popular))),
                    // context.push(PopularMoviesPage.ROUTE_NAME)),
                    Builder(builder: (context) {
                      if (state.popularMovieState == RequestState.Loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.popularMovieState ==
                          RequestState.Loaded) {
                        return MovieListHome(movies: state.popularMovies);
                      } else {
                        return const Text('Failed');
                      }
                    }),
                    SubHeadingHome(
                        title: 'Top Rated',
                        onTap: () =>
                            // Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
                            context.pushRoute(ListMoviesRoute(
                                moviesType: FilterType.TopRated))),
                    // context.push(TopRatedMoviesPage.ROUTE_NAME)),
                    Builder(builder: (context) {
                      if (state.topRatedMovieState == RequestState.Loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.topRatedMovieState ==
                          RequestState.Loaded) {
                        return MovieListHome(movies: state.topRatedMovies);
                      } else {
                        return const Text('Failed');
                      }
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
