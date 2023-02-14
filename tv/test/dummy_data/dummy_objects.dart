import 'package:core/data/models/movie_table.dart';
import 'package:core/data/models/tv/tv_table.dart';
import 'package:core/domain/entities/movie/genre.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/entities/movie/movie_detail.dart';
import 'package:core/domain/entities/tv/last_episode_to_air.dart';
import 'package:core/domain/entities/tv/season.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'name' : "name",
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

//Tv
final testTv = Tv(
    backdropPath: 'backdropPath',
    firstAirDate: "2022-02-02",
    genreIds: [1, 1, 1],
    id: 1,
    name: "name",
    originCountry: ["c"],
    originalLanguage: "c",
    originalName: "name",
    overview:
        "overview",
    popularity: 1,
    posterPath: "posterPath",
    voteAverage: 1.1,
    voteCount: 1,);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  adult: false,
  backdropPath: "backdropPath",
  genres: [Genre(id: 1, name: 'name')],
  homepage: "homepage",
  id: 1,
  inProduction: true,
  lastEpisodeToAir: LastEpisodeToAir(
      airDate: "2022-02-02",
      episodeNumber: 1,
      id: 1,
      name: "name",
      overview:
          "overview",
      productionCode: "",
      seasonNumber: 1,
      stillPath: "stillPath",
      voteAverage: 0,
      voteCount: 0),
  name: "name",
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originalLanguage: "en",
  originalName: "name",
  overview:
      "overview",
  popularity: 1,
  posterPath: "posterPath",
  seasons: [
    Season(
        airDate: "2020-02-02",
        episodeCount: 1,
        id: 1,
        name: "name",
        overview: "overview",
        posterPath: "posterPath",
        seasonNumber: 1),
  ],
  status: "status",
  tagline: "tagline",
  type: "type",
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: "name",
  overview: "overview",
  posterPath: "posterPath",
);

final testTvTable = TvTable(
  id: 1,
  name: "name",
  posterPath: "posterPath",
  overview: "overview",
);

final testTvMap = {
  "id": 1,
  "name": "name",
  "posterPath": "posterPath",
  "overview": "overview",
};
