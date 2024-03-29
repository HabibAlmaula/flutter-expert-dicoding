import 'package:core/domain/entities/tv/last_episode_to_air.dart';
import 'package:equatable/equatable.dart';

class LastEpisodeToAirModel extends Equatable {
  const LastEpisodeToAirModel({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final String airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String stillPath;
  final double voteAverage;
  final int voteCount;

  factory LastEpisodeToAirModel.fromJson(Map<String, dynamic> json) =>
      LastEpisodeToAirModel(
        airDate: json["air_date"],
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"].toString(),
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  LastEpisodeToAir toEntity() {
    return LastEpisodeToAir(
        airDate: airDate,
        episodeNumber: episodeNumber,
        id: id,
        name: name,
        overview: overview,
        productionCode: productionCode,
        seasonNumber: seasonNumber,
        stillPath: stillPath,
        voteAverage: voteAverage,
        voteCount: voteCount);
  }

  @override
  List<Object> get props => [
        airDate,
        episodeNumber,
        id,
        name,
        overview,
        productionCode,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount,
      ];
}
