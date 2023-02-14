import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/networking/api_client.dart';
import 'package:core/data/models/movie_detail_model.dart';
import 'package:core/data/models/movie_response.dart';
import 'package:dio/dio.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../json_reader.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late MovieRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = MovieRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  group('get Now Playing Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/now_playing.json')))
        .movieList;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(() => mockApiClient.getNowPlayingMovies())
          .thenAnswer((_) async => MovieResponse(movieList: tMovieList));
      // act
      final result = await dataSource.getNowPlayingMovies();
      // assert
      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(() => mockApiClient.getNowPlayingMovies()).thenThrow(
        DioError(
          response: Response(
            data: 'Something went wrong',
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ),
      );
      // act
      final call = dataSource.getNowPlayingMovies();
      // assert
      expect(call, throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('get Popular Movies', () {
    final tMovieList =
        MovieResponse.fromJson(json.decode(readJson('dummy_data/popular.json')))
            .movieList;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(() => mockApiClient.getPopularMovies())
          .thenAnswer((_) async => MovieResponse(movieList: tMovieList));
      // act
      final result = await dataSource.getPopularMovies();
      // assert
      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(() => mockApiClient.getPopularMovies()).thenThrow(
        DioError(
          response: Response(
            data: 'Something went wrong',
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ),
      );
      // act
      final call = dataSource.getPopularMovies();
      // assert
      expect(call, throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('get Top Rated Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated.json')))
        .movieList;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(() => mockApiClient.getTopRatedMovies())
          .thenAnswer((_) async => MovieResponse(movieList: tMovieList));
      // act
      final result = await dataSource.getTopRatedMovies();
      // assert
      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(() => mockApiClient.getTopRatedMovies()).thenThrow(
        DioError(
          response: Response(
            data: 'Something went wrong',
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ),
      );
      // act
      final call = dataSource.getTopRatedMovies();
      // assert
      expect(call, throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('get movie detail', () {
    final tId = 1;
    final tMovieDetail = MovieDetailResponse.fromJson(
        json.decode(readJson('dummy_data/movie_detail.json')));

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(() => mockApiClient.getDetailMovie(tId))
          .thenAnswer((_) async => tMovieDetail);
      // act
      final result = await dataSource.getMovieDetail(tId);
      // assert
      expect(result, equals(tMovieDetail));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(() => mockApiClient.getDetailMovie(tId)).thenThrow(
        DioError(
          response: Response(
            data: 'Something went wrong',
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ),
      );
      // act
      final call = dataSource.getMovieDetail(tId);
      // assert
      expect(call, throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('get movie recommendations', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/movie_recommendations.json')))
        .movieList;
    final tId = 1;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(() => mockApiClient.getRecommendationMovies(tId))
          .thenAnswer((_) async => MovieResponse(movieList: tMovieList));
      // act
      final result = await dataSource.getMovieRecommendations(tId);
      // assert
      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(() => mockApiClient.getRecommendationMovies(tId)).thenThrow(
        DioError(
          response: Response(
            data: 'Something went wrong',
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ),
      );
      // act
      final call = dataSource.getMovieRecommendations(tId);
      // assert
      expect(call, throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('search movies', () {
    final tSearchResult = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/search_spiderman_movie.json')))
        .movieList;
    final tQuery = 'Spiderman';

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(() => mockApiClient.searchMovies(tQuery))
          .thenAnswer((_) async => MovieResponse(movieList: tSearchResult));
      // act
      final result = await dataSource.searchMovies(tQuery);
      // assert
      expect(result, equals(tSearchResult));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(() => mockApiClient.searchMovies(tQuery)).thenThrow(
        DioError(
          response: Response(
            data: 'Something went wrong',
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ),
      );
      // act
      final call = dataSource.searchMovies(tQuery);
      // assert
      expect(call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
