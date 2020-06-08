import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/movies_cast_list.dart';
import 'package:flutter_movies/src/models/movies_model.dart';
import 'package:retrofit/retrofit.dart';

//Part file allows you to split a file into multiple dart files.
part 'movies_api.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3")
abstract class MoviesApi {
  factory MoviesApi(Dio dio, {String baseUrl}) =>
      _MoviesApi(dio, baseUrl: baseUrl);

  @GET("/movie/now_playing")
  Future<MoviesList> getMovies(
      {@required @Query("api_key") String apiKey, int page = 1});

  @GET("/movie/popular")
  Future<MoviesList> getPopular(
      {@required @Query("api_key") String apiKey, @Query("page") int page = 1});

  @GET("/movie/{movie_id}/credits")
  Future<MovieCastList> getCast(
      {@required @Query("api_key") String apiKey,
      @required @Path("movie_id") int movieId});

  @GET("/search/movie")
  Future<MoviesList> searchMovie(
      {@required @Query("api_key") String apiKey,
      @required @Query("query") String query,
      @Query("page") int page = 1});
}
