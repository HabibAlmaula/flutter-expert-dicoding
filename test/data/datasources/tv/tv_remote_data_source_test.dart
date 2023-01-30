import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/networking/api_client.dart';
import 'package:ditonton/data/datasources/tv_remote_datasource.dart';
import 'package:ditonton/data/models/tv/tv_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../json_reader.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {

  late TvRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = TvRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  group('get Now Playing Tv', () {
    final tTvList = TvResponse
        .fromJson(
        json.decode(readJson('dummy_data/tv_dummy/on_the_air.json')))
        .tvList;

    test('should return list of Tv Model when the response code is 200',
            () async {
          // arrange
          when(() => mockApiClient.getNowPlayingTv())
              .thenAnswer((_) async => TvResponse(tvList: tTvList));
          // act
          final result = await dataSource.getNowPlayingTv();
          // assert
          expect(result, equals(tTvList));
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(() => mockApiClient.getNowPlayingTv()).thenThrow(
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
          final call = dataSource.getNowPlayingTv();
          // assert
          expect(call, throwsA(const TypeMatcher<ServerException>()));
        });
  });

  group('get Popular Tv', () {
    final tTvList = TvResponse
        .fromJson(
        json.decode(readJson('dummy_data/tv_dummy/popular_tv.json')))
        .tvList;

    test('should return list of Tv when response is success (200)', () async {
      // arrange
      when(() => mockApiClient.getPopularTv())
          .thenAnswer((_) async => TvResponse(tvList: tTvList));
      // act
      final result = await dataSource.getPopularTv();
      // assert
      expect(result, equals(tTvList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(() => mockApiClient.getPopularTv()).thenThrow(
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
          final call = dataSource.getPopularTv();
          // assert
          expect(call, throwsA(const TypeMatcher<ServerException>()));
        });
  });

  group('get Top Rated Tv', () {
    final tTvList = TvResponse
        .fromJson(
        json.decode(readJson('dummy_data/tv_dummy/top_rated_tv.json')))
        .tvList;

    test('should return list of Tv when response code is 200 ', () async {
      // arrange
      when(() => mockApiClient.getTopRatedTv())
          .thenAnswer((_) async => TvResponse(tvList: tTvList));
      // act
      final result = await dataSource.getTopRatedTv();
      // assert
      expect(result, equals(tTvList));
    });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(() => mockApiClient.getTopRatedTv()).thenThrow(
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
          final call = dataSource.getTopRatedTv();
          // assert
          expect(call, throwsA(const TypeMatcher<ServerException>()));
        });
  });

  group('get Tv detail', () {
    final tId = 1;
    final tTvDetail = TvDetailModel.fromJson(
        json.decode(readJson('dummy_data/tv_dummy/tv_detail.json')));

    test('should return tv detail when the response code is 200', () async {
      // arrange
      when(() => mockApiClient.getTvDetail(tId))
          .thenAnswer((_) async => tTvDetail);
      // act
      final result = await dataSource.getTvDetail(tId);
      // assert
      expect(result, equals(tTvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(() => mockApiClient.getTvDetail(tId)).thenThrow(
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
          final call = dataSource.getTvDetail(tId);
          // assert
          expect(call, throwsA(const TypeMatcher<ServerException>()));
        });
  });

  group('get Tv recommendations', () {
    final tTvList = TvResponse
        .fromJson(json
        .decode(readJson('dummy_data/tv_dummy/tv_recommendations.json')))
        .tvList;
    final tId = 1;

    test('should return list of Tv Model when the response code is 200',
            () async {
          // arrange
          when(() => mockApiClient.getRecommendationTv(tId))
              .thenAnswer((_) async => TvResponse(tvList: tTvList));
          // act
          final result = await dataSource.getTvRecommendations(tId);
          // assert
          expect(result, equals(tTvList));
        });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(() => mockApiClient.getRecommendationTv(tId)).thenThrow(
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
          final call = dataSource.getTvRecommendations(tId);
          // assert
          expect(call, throwsA(const TypeMatcher<ServerException>()));
        });
  });

  group('search Tv', () {
    final tSearchResult = TvResponse
        .fromJson(json
        .decode(readJson('dummy_data/tv_dummy/search_umbrella_tv.json')))
        .tvList;
    final tQuery = 'umbrella';

    test('should return list of Tv when response code is 200', () async {
      // arrange
      when(() => mockApiClient.searchTv(tQuery))
          .thenAnswer((_) async => TvResponse(tvList: tSearchResult));
          // act
          final result = await dataSource.searchTv(tQuery);
      // assert
      expect(result, equals(tSearchResult));
    });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(() => mockApiClient.searchTv(tQuery)).thenThrow(
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
          final call = dataSource.searchTv(tQuery);
          // assert
          expect(call, throwsA(const TypeMatcher<ServerException>()));
        });
  });
}
