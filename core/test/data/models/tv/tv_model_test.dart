import 'package:core/data/models/tv/tv_model.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvModel = TvModel(
      backdropPath: '/ciToI1GfkWmzavJIPXh9Xe0Neon.jpg',
      firstAirDate: "2019-02-15",
      genreIds: [10759, 10765, 18],
      id: 75006,
      name: "The Umbrella Academy",
      originCountry: ["US"],
      originalLanguage: "en",
      originalName: "The Umbrella Academy",
      overview:
      "A dysfunctional family of superheroes comes together to solve the mystery of their father's death, the threat of the apocalypse and more.",
      popularity: 1577.649,
      posterPath: "/scZlQQYnDVlnpxFTxaIv2g0BWnL.jpg",
      voteAverage: 8.7,
      voteCount: 7926
  );

  final tTv = Tv(
      backdropPath: '/ciToI1GfkWmzavJIPXh9Xe0Neon.jpg',
      firstAirDate: "2019-02-15",
      genreIds: const [10759, 10765, 18],
      id: 75006,
      name: "The Umbrella Academy",
      originCountry: const ["US"],
      originalLanguage: "en",
      originalName: "The Umbrella Academy",
      overview:
      "A dysfunctional family of superheroes comes together to solve the mystery of their father's death, the threat of the apocalypse and more.",
      popularity: 1577.649,
      posterPath: "/scZlQQYnDVlnpxFTxaIv2g0BWnL.jpg",
      voteAverage: 8.7,
      voteCount: 7926
  );

  test('should be a subclass of Tv entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
