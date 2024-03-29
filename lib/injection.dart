import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/networking/api_client.dart';
import 'package:core/data/datasources/tv_local_datasource.dart';
import 'package:core/data/datasources/tv_remote_datasource.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/domain/usecases/movie/get_movie_detail.dart';
import 'package:core/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movie/get_popular_movies.dart';
import 'package:core/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:core/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movie/get_watchlist_status.dart';
import 'package:core/domain/usecases/movie/remove_watchlist.dart';
import 'package:core/domain/usecases/movie/save_watchlist.dart';
import 'package:core/domain/usecases/movie/search_movies.dart';
import 'package:core/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:core/domain/usecases/tv/get_popular_tv.dart';
import 'package:core/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:core/domain/usecases/tv/get_tv_detail.dart';
import 'package:core/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:core/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:core/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:core/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:core/domain/usecases/tv/search_tv.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie/presentation/pages/detail/bloc/detail_movie_bloc.dart';
import 'package:movie/presentation/pages/home/bloc/home_movie_bloc.dart';
import 'package:movie/presentation/pages/search/bloc/search_movie_bloc.dart';
import 'package:movie/presentation/pages/watch_list/bloc/watch_list_movie_bloc.dart';
import 'package:tv/presentation/pages/detail/bloc/detail_tv_bloc.dart';
import 'package:tv/presentation/pages/home/bloc/home_tv_bloc.dart';
import 'package:tv/presentation/pages/search/bloc/search_tv_bloc.dart';
import 'package:tv/presentation/pages/watch_list/bloc/watch_list_tv_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  /*MOVIES*/
  locator.registerFactory(
    () => SearchMovieBloc(locator()),
  );

  locator.registerFactory(
    () => HomeMovieBloc(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );

  locator.registerFactory(() => DetailMovieBloc(
        getMovieDetail: locator(),
        getMovieRecommendations: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
      ));

  locator.registerFactory(
    () => WatchListMovieBloc(
      getWatchlistMovies: locator(),
    ),
  );

  /*TV*/
  locator.registerFactory(
    () => HomeTvBloc(
      getNowPlayingTv: locator(),
      getPopularTv: locator(),
      getTopRatedTv: locator(),
    ),
  );

  locator.registerFactory(() => DetailTvBloc(
        getTvDetail: locator(),
        getTvRecommendations: locator(),
        getWatchListStatusTv: locator(),
        saveWatchlistTv: locator(),
        removeWatchlistTv: locator(),
      ));

  locator.registerFactory(
    () => WatchListTvBloc(
      getWatchlistTv: locator(),
    ),
  );

  locator.registerFactory(
    () => SearchTvBloc(searchTv: locator()),
  );

  // use case
  /*Movies*/
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  /*Tv*/
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));

  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));

  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(apiClient: locator()));

  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(apiClient: locator()));

  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());

  //***** EXTERNAL ****
  //dio
  locator.registerLazySingleton(() => Dio());
  locator.registerLazySingleton<ApiClient>(
      () => ApiClient(dio: locator()));
}
