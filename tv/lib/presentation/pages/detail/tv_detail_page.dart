import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie/genre.dart';
import 'package:core/domain/entities/tv/season.dart';
import 'package:ditonton/presentation/route/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:tv/presentation/pages/watch_list/bloc/watch_list_tv_bloc.dart';

import 'bloc/detail_tv_bloc.dart';

class TvDetailPage extends StatefulWidget {
  static const routeName = '/detail-tv/:id';

  final int id;

  const TvDetailPage({super.key, @PathParam('id') required this.id});

  @override
  TvDetailPageState createState() => TvDetailPageState();
}

class TvDetailPageState extends State<TvDetailPage> {
  late DetailTvBloc _detailTvBloc;

  @override
  void initState() {
    super.initState();
    _detailTvBloc = context.read<DetailTvBloc>();
    Future.microtask(() {
      _detailTvBloc.add(OnLoadTvDetail(tvId: widget.id));
      _detailTvBloc.add(OnLoadTvRecommendations(tvId: widget.id));
      _detailTvBloc.add(OnLoadWatchListTvStatus(tvId: widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailTvBloc, DetailTvState>(
        builder: (context, state) {
          if (state.tvDetailRequestState == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.tvDetailRequestState == RequestState.Loaded) {
            return const SafeArea(
              child: DetailContent(),
            );
          } else {
            return Text(state.tvDetailRemoteMessage);
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
    return BlocBuilder<DetailTvBloc, DetailTvState>(
      builder: (context, state) {
        var tv = state.tvDetail;
        var recommendations = state.tvRecommendations;
        var isAddedWatchlist = state.isSavedToWatchList;
        return Stack(
          children: [
            CachedNetworkImage(
              imageUrl: (tv?.posterPath != "null")
                  ? 'https://image.tmdb.org/t/p/w500${tv?.posterPath}'
                  : "https://www.unas.ac.id/wp-content/uploads/2021/08/placeholder-17.png",
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
                                  "${tv?.name}",
                                  style: AppConstant.kHeading5,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (!isAddedWatchlist) {
                                      context.read<DetailTvBloc>().add(
                                          OnSaveTvToWatchList(tvData: tv!));
                                      context
                                          .read<WatchListTvBloc>()
                                          .add(OnLoadWatchListTv());
                                      //toast
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Added to Watchlist")));
                                    } else {
                                      context.read<DetailTvBloc>().add(
                                          OnRemoveTvFromWatchList(tvData: tv!));

                                      context
                                          .read<WatchListTvBloc>()
                                          .add(OnLoadWatchListTv());
                                      //toast
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Removed from Watchlist")));
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
                                  _showGenres(tv!.genres),
                                ),
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: tv.voteAverage / 2,
                                      itemCount: 5,
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: AppConstant.kMikadoYellow,
                                      ),
                                      itemSize: 24,
                                    ),
                                    Text('${tv.voteAverage}')
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Overview',
                                  style: AppConstant.kHeading6,
                                ),
                                Text(
                                  tv.overview,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Current Season',
                                  style: AppConstant.kHeading6,
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                cardSeason(tv.seasons.last, context),
                                const SizedBox(height: 16),
                                Text(
                                  'Recommendations',
                                  style: AppConstant.kHeading6,
                                ),
                                Builder(
                                  builder: (context) {
                                    if (state.tvRecommendationsRequestState ==
                                        RequestState.Loading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state
                                            .tvRecommendationsRequestState ==
                                        RequestState.Error) {
                                      return Text(
                                          state.tvRecommendationRemoteMessage);
                                    } else if (state
                                            .tvRecommendationsRequestState ==
                                        RequestState.Loaded) {
                                      return SizedBox(
                                        height: 150,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final tv = recommendations[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Logger().i(
                                                      "RECOMMENDATION_CLICKED");
                                                  context.pushRoute(
                                                      TvDetailRoute(id: tv.id));
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: tv.posterPath !=
                                                            "null"
                                                        ? 'https://image.tmdb.org/t/p/w500${tv.posterPath}'
                                                        : "https://www.unas.ac.id/wp-content/uploads/2021/08/placeholder-17.png",
                                                    placeholder:
                                                        (context, url) =>
                                                            const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
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
                    context.popRoute();
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

  Widget cardSeason(Season season, BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width / 3,
                // height: MediaQuery.of(context).size.width/3,
                imageUrl: (season.posterPath != "null")
                    ? 'https://image.tmdb.org/t/p/w500${season.posterPath}'
                    : "https://www.unas.ac.id/wp-content/uploads/2021/08/placeholder-17.png",
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    season.name,
                    style: AppConstant.kHeading6.copyWith(color: Colors.black),
                  ),
                  Text(
                    "${(season.airDate == "null" ? "unknown" : DateFormat('yyyy').format(DateTime.parse("1994-05-08")))} | ${season.episodeCount} Episodes",
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  RichText(
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    strutStyle: const StrutStyle(fontSize: 12.0),
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      text: season.overview,
                    ),
                  ),
                  // Text(
                  //   "${season.overview}",
                  //   style: TextStyle(color: Colors.black),
                  // )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
