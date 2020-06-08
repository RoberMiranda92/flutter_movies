import 'dart:async';

import 'package:flutter_movies/src/models/movies_model.dart';
import 'package:flutter_movies/src/models/result_wrapper.dart';
import 'package:flutter_movies/src/resources/movies_remote_repository.dart';

class MoviesBloc {
  static final MoviesBloc _instance = MoviesBloc._newInstance();
  final MoviesRepository _respository = MoviesRepository();

  final StreamController<MoviesList> _nowMoviesStream =
      StreamController<MoviesList>.broadcast();

  Stream<MoviesList> get moviesStream => _nowMoviesStream.stream;

  void diposeStreams() {
    _nowMoviesStream?.close();
  }

  void getMovies() {
    _respository.getMovies().then((result) => manageResult(result));
  }

  void manageResult(ResultWrapper<MoviesList> result) {
    switch (result.getType()) {
      case Type.DATA:
        _nowMoviesStream.add(result.data);
        break;
      case Type.ERROR:
        _nowMoviesStream.addError(result.getException);
        break;
      case Type.UNKNOWN:
        // TODO: Handle this case.
        break;
    }
  }

  MoviesBloc._newInstance();

  static MoviesBloc get instance => _instance;
}
