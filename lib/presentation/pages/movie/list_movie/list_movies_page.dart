import 'package:ditonton/common/app_enum.dart';
import 'package:ditonton/presentation/pages/movie/home/bloc/home_movie_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/list-movie';
  final FilterType moviesType;

  const ListMoviesPage({required this.moviesType});

  @override
  _ListMoviesPageState createState() => _ListMoviesPageState();
}

class _ListMoviesPageState extends State<ListMoviesPage> {
  late String _title;
  late HomeMovieBloc _homeMovieBloc;

  @override
  void initState() {
    super.initState();
    //initialize bloc;
    _homeMovieBloc = context.read<HomeMovieBloc>();
    //initialize title
    switch (widget.moviesType) {
      case FilterType.NowPlaying:
        _title = "Now Playing Movies";
        _homeMovieBloc.add(OnLoadNowPlayingMovies());
        break;
      case FilterType.Popular:
        _title = "Popular Movies";
        _homeMovieBloc.add(OnLoadPopularMovies());
        break;
      case FilterType.TopRated:
        _title = "Top Rated Movies";
        _homeMovieBloc.add(OnLoadTopRatedMovies());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: BlocBuilder<HomeMovieBloc, HomeMovieState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Builder(
              builder: (context) {
                switch (widget.moviesType) {
                  case FilterType.NowPlaying:
                    if (state.nowPlayingMovieState == RequestState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.nowPlayingMovieState ==
                        RequestState.Loaded) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return MovieCard(
                              movie: state.nowPlayingMovies[index]);
                        },
                        itemCount: state.nowPlayingMovies.length,
                      );
                    } else {
                      return Center(
                        key: Key('error_message'),
                        child: Text(state.nowPlayingMovieMessage),
                      );
                    }
                  case FilterType.Popular:
                    if (state.popularMovieState == RequestState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.popularMovieState == RequestState.Loaded) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return MovieCard(movie: state.popularMovies[index]);
                        },
                        itemCount: state.popularMovies.length,
                      );
                    } else {
                      return Center(
                        key: Key('error_message'),
                        child: Text(state.popularMovieMessage),
                      );
                    }
                  case FilterType.TopRated:
                    if (state.topRatedMovieState == RequestState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.topRatedMovieState ==
                        RequestState.Loaded) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return MovieCard(movie: state.topRatedMovies[index]);
                        },
                        itemCount: state.topRatedMovies.length,
                      );
                    } else {
                      return Center(
                        key: Key('error_message'),
                        child: Text(state.topRatedMovieMessage),
                      );
                    }
                }
              },
            ),
          );
        },
      ),
    );
  }
}
