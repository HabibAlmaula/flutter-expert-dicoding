import 'package:core/common/exception.dart';
import 'package:core/data/datasources/networking/api_client.dart';
import 'package:core/data/models/tv/tv_detail_model.dart';
import 'package:core/data/models/tv/tv_model.dart';
import 'package:dio/dio.dart';

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getNowPlayingTv();

  Future<List<TvModel>> getPopularTv();

  Future<List<TvModel>> getTopRatedTv();

  Future<TvDetailModel> getTvDetail(int id);

  Future<List<TvModel>> getTvRecommendations(int id);

  Future<List<TvModel>> searchTv(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  final ApiClient _apiClient;

  TvRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  @override
  Future<List<TvModel>> getNowPlayingTv() async {
    try {
      final result = await _apiClient.getNowPlayingTv();
      return result.tvList;
    } on DioError catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTv() async {
    try {
      final result = await _apiClient.getPopularTv();
      return result.tvList;
    } on DioError catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTv() async {
    try {
      final result = await _apiClient.getTopRatedTv();
      return result.tvList;
    } on DioError catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailModel> getTvDetail(int id) async {
    try {
      return await _apiClient.getTvDetail(id);
    } on DioError catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    try {
      final result = await _apiClient.getRecommendationTv(id);
      return result.tvList;
    } on DioError catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTv(String query) async {
    try {
      final result = await _apiClient.searchTv(query);
      return result.tvList;
    } on DioError catch (_) {
      throw ServerException();
    }
  }
}
