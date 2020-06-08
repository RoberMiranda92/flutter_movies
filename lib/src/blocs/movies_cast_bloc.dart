import 'dart:async';
import 'package:flutter_movies/src/models/movies_cast_list.dart';
import 'package:flutter_movies/src/models/result_wrapper.dart';
import 'package:flutter_movies/src/resources/movies_remote_repository.dart';

class MoviesCastBloc {
  static final MoviesCastBloc _instance = MoviesCastBloc._newInstance();

  final MoviesRepository _repository = MoviesRepository();

  final StreamController<MovieCastList> _moviesCastStream =
      StreamController<MovieCastList>.broadcast();

  StreamSink<MovieCastList> get castSink => _moviesCastStream.sink;

  Stream<MovieCastList> get castStream => _moviesCastStream.stream;

  void diposeStreams() {
    _moviesCastStream?.close();
  }

  void getCast(int movieId) {
    _repository
        .getCastFromMovie(movieId)
        .then((result) => _manageResult(result));
  }

  void _manageResult(ResultWrapper<MovieCastList> result) {
    switch (result.getType()) {
      case Type.DATA:
        _moviesCastStream.add(result.data);
        break;
      case Type.ERROR:
        _moviesCastStream.addError(result.getException);
        break;
      case Type.UNKNOWN:
        // TODO: Handle this case.
        break;
    }
  }

  MoviesCastBloc._newInstance();

  static MoviesCastBloc get instance => _instance;
}
