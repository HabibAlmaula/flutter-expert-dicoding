class Endpoint {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  static const GET_NOW_PLAYING_MOVIES = '/movie/now_playing?$API_KEY';
  static const GET_POPULAR_MOVIES = '/movie/popular?$API_KEY';
  static const GET_TOP_RATED_MOVIES = '/movie/top_rated?$API_KEY';

  static const GET_NOW_PLAYING_TV = '/tv/on_the_air?$API_KEY';
  static const GET_POPULAR_TV = '/tv/popular?$API_KEY';
  static const GET_TOP_RATED_TV = '/tv/top_rated?$API_KEY';
}
