import 'package:flutter_movies/src/models/movies_cast_list.dart';
import 'package:flutter_movies/src/models/movies_model.dart';

extension ImageURL on Movie {
  String getUrlImage() => "http://image.tmdb.org/t/p/w500/${posterPath}";
  String getCoverImage() => "http://image.tmdb.org/t/p/w500/${backdropPath}";
}

extension ImageCast on Cast {
  String getUrlImage() => "http://image.tmdb.org/t/p/w500/${profilePath}";
}
