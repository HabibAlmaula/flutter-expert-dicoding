import 'package:dio/dio.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/networking/api_client.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();

  Future<List<MovieModel>> getPopularMovies();

  Future<List<MovieModel>> getTopRatedMovies();

  Future<MovieDetailResponse> getMovieDetail(int id);

  Future<List<MovieModel>> getMovieRecommendations(int id);

  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiClient _apiClient;

  MovieRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    try {
      final result = await _apiClient.getNowPlayingMovies();
      return result.movieList;
    } on DioError catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    try {
      return await _apiClient.getDetailMovie(id);
    } on DioError catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    try {
      final result = await _apiClient.getRecommendationMovies(id);
      return result.movieList;
    } on DioError catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final result = await _apiClient.getPopularMovies();
      return result.movieList;
    } on DioError catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    try {
      final result = await _apiClient.getTopRatedMovies();
      return result.movieList;
    } on DioError catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final result = await _apiClient.searchMovies(query);
      return result.movieList;
    } on DioError catch (_) {
      throw ServerException();
    }
  }
}
