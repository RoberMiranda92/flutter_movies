import 'package:flutter_movies/src/models/movies_cast_list.dart';
import 'package:flutter_movies/src/ui/models/Icard.dart';
import 'package:flutter_movies/src/utils/extensions.dart';

class CastCard extends ICard {
  Cast _cast;

  CastCard.fromCast(Cast cast) {
    this._cast = cast;
  }

  Cast get cast => _cast;

  @override
  int getId(){
    return _cast.id;
  }

  @override
  String getImageURL() {
    return _cast.getUrlImage();
  }

  @override
  String getTitle() {
    return _cast.name;
  }
}
