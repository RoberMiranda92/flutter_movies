import 'package:dio/dio.dart';
import 'package:flutter_movies/src/models/movies_cast_list.dart';
import 'package:flutter_movies/src/models/movies_model.dart';
import 'package:flutter_movies/src/models/result_wrapper.dart';
import 'package:flutter_movies/src/models/server_error.dart';

import 'api/movies_api.dart';


class MoviesRepository {
  Dio _dio;
  MoviesApi _apiClient;

  MoviesRepository() {
    _dio = new Dio();
    _apiClient = new MoviesApi(_dio);
  }

  Future<ResultWrapper<MoviesList>> getMovies() async {
    MoviesList response;
    try {
      response = await _apiClient.getMovies(
          apiKey: "b6d78631b48afe443e718ba25f7e4aac");
      return ResultWrapper<MoviesList>()..data = response;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ResultWrapper<MoviesList>()
        ..setException(ServerError.withError(error: error));
    }
  }

  Future<ResultWrapper<MoviesList>> getPopularMovies(int page) async {
    MoviesList response;
    try {
      response = await _apiClient.getPopular(
          apiKey: "b6d78631b48afe443e718ba25f7e4aac", page: page);
      return ResultWrapper<MoviesList>()..data = response;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ResultWrapper<MoviesList>()
        ..setException(ServerError.withError(error: error));
    }
  }

  Future<ResultWrapper<MovieCastList>> getCastFromMovie(int movieId) async {
    MovieCastList response;
    try {
      response = await _apiClient.getCast(
          apiKey: "b6d78631b48afe443e718ba25f7e4aac", movieId: movieId);
      return ResultWrapper<MovieCastList>()..data = response;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ResultWrapper<MovieCastList>()
        ..setException(ServerError.withError(error: error));
    }
  }

  Future<ResultWrapper<MoviesList>> searchMovie(String query) async {
    MoviesList response;
    try {
      response = await _apiClient.searchMovie(
          apiKey: "b6d78631b48afe443e718ba25f7e4aac", query: query);
      return ResultWrapper<MoviesList>()..data = response;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ResultWrapper<MoviesList>()
        ..setException(ServerError.withError(error: error));
    }
  }

  
}
