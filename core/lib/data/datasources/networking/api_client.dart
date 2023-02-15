// coverage:ignore-file
import 'dart:io';

import 'package:core/data/models/movie_detail_model.dart';
import 'package:core/data/models/movie_response.dart';
import 'package:core/data/models/tv/tv_detail_model.dart';
import 'package:core/data/models/tv/tv_response.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';

import 'endpoints.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: Endpoint.BASE_URL)
abstract class ApiClient {
  factory ApiClient({required Dio dio}) {
    /* this fingerprint came from this command, based on dio documentation
    * openssl s_client -servername themoviedb.org -connect themoviedb.org:443 < /dev/null 2>/dev/null \
  | openssl x509 -noout -fingerprint -sha256
    * */
    const String fingerPrint = "e0f690bbe9d9518a42a68402d87f4485ec38f8a3d34d905feef72cd7fbb95208";
    //fake from google.com
    // const fakeFingerPrint = "51e9015ffefb7970d8df74bb46946372b1e32b316a46f0c536e7c1d4ddc5b270";
    dio.options = BaseOptions(
        receiveTimeout: const Duration(seconds: 15),
        connectTimeout: const Duration(seconds: 15),
        headers: {
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
    dio.httpClientAdapter = IOHttpClientAdapter()
      ..onHttpClientCreate = (_) {
        // Don't trust any certificate just because their root cert is trusted.
        final HttpClient client =
            HttpClient(context: SecurityContext(withTrustedRoots: false));
        // You can test the intermediate / root cert here. We just ignore it.
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      }
      ..validateCertificate = (cert, host, port) {
        // Check that the cert fingerprint matches the one we expect.
        // We definitely require _some_ certificate.
        if (cert == null) {
          return false;
        }
        // Validate it any way you want. Here we only check that
        // the fingerprint matches the OpenSSL SHA256.
        return fingerPrint == sha256.convert(cert.der).toString();
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
