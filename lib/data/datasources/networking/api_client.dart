import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:ditonton/data/datasources/networking/endpoints.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:ditonton/data/models/tv/tv_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:flutter/services.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: Endpoint.BASE_URL)
abstract class ApiClient {
  factory ApiClient({required Dio dio, required ByteData cert}) {
    dio.options =
        BaseOptions(receiveTimeout: 15000, connectTimeout: 15000, headers: {
      "Content-Type": "application/json",
    });
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
      SecurityContext sc = SecurityContext();
      //file is the path of certificate
      sc.setTrustedCertificatesBytes(cert.buffer.asInt8List());
      HttpClient httpClient = HttpClient(context: sc);
      return httpClient;
    };
    return _ApiClient(dio);
  }

  //movie
  @GET(Endpoint.GET_NOW_PLAYING_MOVIES)
  Future<MovieResponse> getNowPlayingMovies();

  @GET(Endpoint.GET_POPULAR_MOVIES)
  Future<MovieResponse> getPopularMovies();

  @GET(Endpoint.GET_TOP_RATED_MOVIES)
  Future<MovieResponse> getTopRatedMovies();

  @GET('/movie/{id}/recommendations?${Endpoint.API_KEY}')
  Future<MovieResponse> getRecommendationMovies(@Path("id") int id);

  @GET('/movie/{id}?${Endpoint.API_KEY}')
  Future<MovieDetailResponse> getDetailMovie(@Path("id") int id);

  @GET('/search/movie?${Endpoint.API_KEY}')
  Future<MovieResponse> searchMovies(@Query("query") String query);

  //Tv
  @GET(Endpoint.GET_NOW_PLAYING_TV)
  Future<TvResponse> getNowPlayingTv();

  @GET(Endpoint.GET_POPULAR_TV)
  Future<TvResponse> getPopularTv();

  @GET(Endpoint.GET_TOP_RATED_TV)
  Future<TvResponse> getTopRatedTv();

  @GET('/tv/{id}/recommendations?${Endpoint.API_KEY}')
  Future<TvResponse> getRecommendationTv(@Path("id") int id);

  @GET('/tv/{id}?${Endpoint.API_KEY}')
  Future<TvDetailModel> getTvDetail(@Path("id") int id);

  @GET('/search/tv?${Endpoint.API_KEY}')
  Future<TvResponse> searchTv(@Query("query") String query);
}
