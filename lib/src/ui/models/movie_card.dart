import 'package:flutter_movies/src/models/movies_model.dart';
import 'package:flutter_movies/src/ui/models/Icard.dart';
import 'package:flutter_movies/src/utils/extensions.dart';

class MovieCard extends ICard {
  Movie _movie;

  MovieCard.fromMovie(Movie movie) {
    this._movie = movie;
  }

  Movie get movie => _movie;

  @override
  int getId(){
    return _movie.id;
  }

  @override
  String getImageURL() {
    return _movie.getUrlImage();
  }

  @override
  String getTitle() {
    return _movie.title;
  }
}
