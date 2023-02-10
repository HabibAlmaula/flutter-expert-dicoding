import 'package:auto_route/auto_route.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/app_enum.dart';
import 'package:ditonton/presentation/pages/movie/home/bloc/home_movie_bloc.dart';
import 'package:ditonton/presentation/route/app_router.dart';
import 'package:ditonton/presentation/widgets/movie_list_home.dart';
import 'package:ditonton/presentation/widgets/sub_heading_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  static const ROUTE_NAME = "movie";

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
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
        title: Text('Movies'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
              context.pushRoute(SearchRoute());
            },
            icon: Icon(Icons.search),
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
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.nowPlayingMovieState ==
                          RequestState.Loaded) {
                        return MovieListHome(movies: state.nowPlayingMovies);
                      } else {
                        return Text('Failed');
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
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.popularMovieState ==
                          RequestState.Loaded) {
                        return MovieListHome(movies: state.popularMovies);
                      } else {
                        return Text('Failed');
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
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.topRatedMovieState ==
                          RequestState.Loaded) {
                        return MovieListHome(movies: state.topRatedMovies);
                      } else {
                        return Text('Failed');
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
