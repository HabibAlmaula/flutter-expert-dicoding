import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/app_enum.dart';
import 'package:core/common/constants.dart';
import 'package:core/domain/entities/movie/genre.dart';
import 'package:ditonton/presentation/route/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:logger/logger.dart';
import 'package:movie/presentation/pages/watch_list/bloc/watch_list_movie_bloc.dart';

import 'bloc/detail_movie_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/detail-movie/:id';

  final int id;

  const MovieDetailPage({super.key, @PathParam('id') required this.id});

  @override
  MovieDetailPageState createState() => MovieDetailPageState();
}

class MovieDetailPageState extends State<MovieDetailPage> {
  late DetailMovieBloc _detailMovieBloc;

  @override
  void initState() {
    super.initState();
    _detailMovieBloc = context.read<DetailMovieBloc>();
    Future.microtask(() {
      _detailMovieBloc.add(OnLoadMovieDetail(movieId: widget.id));
      _detailMovieBloc.add(OnLoadMovieRecommendations(movieId: widget.id));
      _detailMovieBloc.add(OnLoadWatchListMovieStatus(movieId: widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailMovieBloc, DetailMovieState>(
        builder: (context, state) {
          if (state.movieDetailRequestState == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.movieDetailRequestState == RequestState.Loaded &&
              state.movieRecommendationsRequestState == RequestState.Loaded) {
            return const SafeArea(
              child: DetailContent(),
            );
          } else {
            return Text(state.movieDetailRemoteMessage);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  const DetailContent({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<DetailMovieBloc, DetailMovieState>(
      builder: (context, state) {
        var movie = state.movieDetail;
        var recommendations = state.movieRecommendations;
        var isAddedWatchlist = state.isSavedToWatchList;
        return Stack(
          children: [
            CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w500${movie?.posterPath}',
              width: screenWidth,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Container(
              margin: const EdgeInsets.only(top: 48 + 8),
              child: DraggableScrollableSheet(
                builder: (context, scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: AppConstant.kRichBlack,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 16,
                      right: 16,
                    ),
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${movie?.title}",
                                  style: AppConstant.kHeading5,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (!isAddedWatchlist) {
                                      context.read<DetailMovieBloc>().add(
                                          OnSaveMovieToWatchList(
                                              movieData: movie!));

                                      context
                                          .read<WatchListMovieBloc>()
                                          .add(OnLoadWatchListMovie());
                                      //toast
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Added to Watchlist")));
                                    } else {
                                      context.read<DetailMovieBloc>().add(
                                          OnRemoveMovieFromWatchList(
                                              movieData: movie!));
                                      context
                                          .read<WatchListMovieBloc>()
                                          .add(OnLoadWatchListMovie());
                                      //toast
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Removed from Watchlist")));
                                      // Provider.of<WatchlistMovieNotifier>(context,
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      isAddedWatchlist
                                          ? const Icon(Icons.check)
                                          : const Icon(Icons.add),
                                      const Text('Watchlist'),
                                    ],
                                  ),
                                ),
                                Text(
                                  _showGenres(movie?.genres ?? []),
                                ),
                                Text(
                                  _showDuration(movie?.runtime ?? 0),
                                ),
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: movie?.voteAverage ?? 0 / 2,
                                      itemCount: 5,
                                      itemBuilder: (context, index) => const Icon(
                                        Icons.star,
                                        color: AppConstant.kMikadoYellow,
                                      ),
                                      itemSize: 24,
                                    ),
                                    Text('${movie?.voteAverage}')
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Overview',
                                  style: AppConstant.kHeading6,
                                ),
                                Text(
                                  "${movie?.overview}",
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Recommendations',
                                  style: AppConstant.kHeading6,
                                ),
                                Builder(
                                  builder: (context) {
                                    if (state
                                            .movieRecommendationsRequestState ==
                                        RequestState.Loading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state
                                            .movieRecommendationsRequestState ==
                                        RequestState.Error) {
                                      return Text(state
                                          .movieRecommendationRemoteMessage);
                                    } else if (state
                                            .movieRecommendationsRequestState ==
                                        RequestState.Loaded) {
                                      return SizedBox(
                                        height: 150,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final movie =
                                                recommendations[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Logger().i(
                                                      "RECOMMENDATION_CLICKED");
                                                  context.pushRoute(MovieDetailRoute(id: movie.id));
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                    placeholder:
                                                        (context, url) =>
                                                            const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: recommendations.length,
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            color: Colors.white,
                            height: 4,
                            width: 48,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                // initialChildSize: 0.5,
                minChildSize: 0.25,
                // maxChildSize: 1.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: AppConstant.kRichBlack,
                foregroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    context.navigateBack();
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
