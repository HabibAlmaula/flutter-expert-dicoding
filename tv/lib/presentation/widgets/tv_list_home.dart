import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:ditonton/presentation/route/app_router.dart';
import 'package:flutter/material.dart';

class TvList extends StatelessWidget {
  final List<Tv> tvs;

  const TvList(this.tvs, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                context.pushRoute(TvDetailRoute(id: tv.id));
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: tv.posterPath != "null"
                      ? '$baseImageUrl${tv.posterPath}'
                      : "https://www.unas.ac.id/wp-content/uploads/2021/08/placeholder-17.png",
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}