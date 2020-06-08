// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesList _$MoviesListFromJson(Map<String, dynamic> json) {
  return MoviesList(
    results: (json['results'] as List)
        ?.map(
            (e) => e == null ? null : Movie.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    page: json['page'] as int,
    totalResults: json['total_results'] as int,
    dates: json['dates'] == null
        ? null
        : Dates.fromJson(json['dates'] as Map<String, dynamic>),
    totalPages: json['total_pages'] as int,
  );
}

Map<String, dynamic> _$MoviesListToJson(MoviesList instance) =>
    <String, dynamic>{
      'results': instance.results,
      'page': instance.page,
      'total_results': instance.totalResults,
      'dates': instance.dates,
      'total_pages': instance.totalPages,
    };

Dates _$DatesFromJson(Map<String, dynamic> json) {
  return Dates(
    maximum: json['maximum'] as String,
    minimum: json['minimum'] as String,
  );
}

Map<String, dynamic> _$DatesToJson(Dates instance) => <String, dynamic>{
      'maximum': instance.maximum,
      'minimum': instance.minimum,
    };

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    popularity: (json['popularity'] as num)?.toDouble(),
    voteCount: json['vote_count'] as int,
    video: json['video'] as bool,
    posterPath: json['poster_path'] as String,
    id: json['id'] as int,
    adult: json['adult'] as bool,
    backdropPath: json['backdrop_path'] as String,
    originalLanguage: json['original_language'] as String,
    originalTitle: json['original_title'] as String,
    genreIds: (json['genre_ids'] as List)?.map((e) => e as int)?.toList(),
    title: json['title'] as String,
    voteAverage: (json['vote_average'] as num)?.toDouble(),
    overview: json['overview'] as String,
    releaseDate: json['release_date'] as String,
  );
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'popularity': instance.popularity,
      'vote_count': instance.voteCount,
      'video': instance.video,
      'poster_path': instance.posterPath,
      'id': instance.id,
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'genre_ids': instance.genreIds,
      'title': instance.title,
      'vote_average': instance.voteAverage,
      'overview': instance.overview,
      'release_date': instance.releaseDate,
    };
