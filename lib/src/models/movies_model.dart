import 'package:json_annotation/json_annotation.dart';

part 'movies_model.g.dart';

@JsonSerializable()
class MoviesList {
  List<Movie> results;
  int page;
  @JsonKey(name: "total_results")
  int totalResults;
  Dates dates;
  @JsonKey(name: "total_pages")
  int totalPages;

  MoviesList({
    this.results,
    this.page,
    this.totalResults,
    this.dates,
    this.totalPages,
  });

  //https://dart.dev/guides/language/language-tour#using-constructors
  factory MoviesList.fromJson(Map<String, dynamic> json) =>
      _$MoviesListFromJson(json);
}

@JsonSerializable()
class Dates {
  String maximum;
  String minimum;

  Dates({
    this.maximum,
    this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);
}

@JsonSerializable()
class Movie {
  double popularity;
  @JsonKey(name: "vote_count")
  int voteCount;
  bool video;
  @JsonKey(name: "poster_path")
  String posterPath;
  int id;
  bool adult;
  @JsonKey(name: "backdrop_path")
  String backdropPath;
  @JsonKey(name: "original_language")
  String originalLanguage;
  @JsonKey(name: "original_title")
  String originalTitle;
  @JsonKey(name: "genre_ids")
  List<int> genreIds;
  String title;
  @JsonKey(name: "vote_average")
  double voteAverage;
  String overview;
  @JsonKey(name: "release_date")
  String releaseDate;

  Movie({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
