import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/app_enum.dart';
import 'package:ditonton/domain/entities/movie/genre.dart';
import 'package:ditonton/presentation/pages/movie/detail/bloc/detail_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:logger/logger.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-movie';

  final int id;

  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
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
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.movieDetailRequestState == RequestState.Loaded &&
              state.movieRecommendationsRequestState == RequestState.Loaded) {
            return SafeArea(
              child: DetailContent(
                bloc: _detailMovieBloc,
              ),
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
  final DetailMovieBloc bloc;

  const DetailContent({required this.bloc});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<DetailMovieBloc, DetailMovieState>(
      listener: (context, state) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.watchListMessage)));
      },
      builder: (context, state) {
        var movie = state.movieDetail;
        var recommendations = state.movieRecommendations;
        var isAddedWatchlist = state.isSavedToWatchList;
        return Stack(
          children: [
            CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w500${movie?.posterPath}',
              width: screenWidth,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Container(
              margin: const EdgeInsets.only(top: 48 + 8),
              child: DraggableScrollableSheet(
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: kRichBlack,
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
                                  style: kHeading5,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (!isAddedWatchlist) {
                                      bloc.add(OnSaveMovieToWatchList(
                                          movieData: movie!));
                                      // Provider.of<WatchlistMovieNotifier>(context,
                                      //         listen: false)
                                      //     .fetchWatchlistMovies();
                                    } else {
                                      bloc.add(OnRemoveMovieFromWatchList(
                                          movieData: movie!));

                                      // Provider.of<WatchlistMovieNotifier>(context,
                                      //         listen: false)
                                      //     .fetchWatchlistMovies();
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      isAddedWatchlist
                                          ? Icon(Icons.check)
                                          : Icon(Icons.add),
                                      Text('Watchlist'),
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
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: kMikadoYellow,
                                      ),
                                      itemSize: 24,
                                    ),
                                    Text('${movie?.voteAverage}')
                                  ],
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Overview',
                                  style: kHeading6,
                                ),
                                Text(
                                  "${movie?.overview}",
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Recommendations',
                                  style: kHeading6,
                                ),
                                Builder(
                                  builder: (context) {
                                    if (state.movieRecommendationsRequestState ==
                                        RequestState.Loading) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state.movieRecommendationsRequestState ==
                                        RequestState.Error) {
                                      return Text(state.movieRecommendationRemoteMessage);
                                    } else if (state.movieRecommendationsRequestState ==
                                        RequestState.Loaded) {
                                      return Container(
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
                                                  // Future.microtask(() {
                                                  //   Provider.of<MovieDetailNotifier>(
                                                  //           context,
                                                  //           listen: false)
                                                  //       .fetchMovieDetail(
                                                  //           movie.id);
                                                  //   Provider.of<MovieDetailNotifier>(
                                                  //           context,
                                                  //           listen: false)
                                                  //       .loadWatchlistStatus(
                                                  //           movie.id);
                                                  // });
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                    placeholder:
                                                        (context, url) =>
                                                            Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
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
                backgroundColor: kRichBlack,
                foregroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
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
      result += genre.name + ', ';
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
