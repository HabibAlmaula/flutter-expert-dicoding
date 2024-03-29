import 'dart:convert';
import 'package:core/data/models/tv/tv_model.dart';
import 'package:core/data/models/tv/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  const tTvModel = TvModel(
      backdropPath: '/path.jpg',
      firstAirDate: "2022-02-02",
      genreIds: [1, 2, 3],
      id: 1,
      name: "name",
      originCountry: ["c"],
      originalLanguage: "c",
      originalName: "name",
      overview: "overview",
      popularity: 1.1,
      posterPath: "/path.jpg",
      voteAverage: 1.5,
      voteCount: 1);

  const tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_dummy/on_the_air.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "first_air_date": "2022-02-02",
            "genre_ids": [1, 2, 3],
            "id": 1,
            "name": "name",
            "origin_country": ["c"],
            "original_language": "c",
            "original_name": "name",
            "overview": "overview",
            "popularity": 1.1,
            "poster_path": "/path.jpg",
            "vote_average": 1.5,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
