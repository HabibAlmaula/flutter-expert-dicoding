import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';

import 'bloc/watch_list_movie_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const routeName = '/watchlist-movie';

  const WatchlistMoviesPage({super.key});

  @override
  WatchlistMoviesPageState createState() => WatchlistMoviesPageState();
}

class WatchlistMoviesPageState extends State<WatchlistMoviesPage> with WidgetsBindingObserver{
  late WatchListMovieBloc _watchListMovieBloc;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _watchListMovieBloc = context.read<WatchListMovieBloc>();
    Future.microtask(() => _watchListMovieBloc.add(OnLoadWatchListMovie()));
    super.initState();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchListMovieBloc, WatchListMovieState>(
          builder: (context, state) {
            if (state.requestState == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.requestState == RequestState.Loaded) {
              if (state.movies.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        "assets/raw/no_data.json",
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2,
                      ),
                      const Text("No data found")
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return MovieCard(movie:movie);
                  },
                  itemCount: state.movies.length,
                );
              }
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            }
          },
        ),
      ),
    );
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _watchListMovieBloc.add(OnLoadWatchListMovie());
    }
  }
}
