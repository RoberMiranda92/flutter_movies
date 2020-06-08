import 'dart:async';

import 'package:flutter_movies/src/models/movies_model.dart';
import 'package:flutter_movies/src/models/result_wrapper.dart';
import 'package:flutter_movies/src/resources/movies_remote_repository.dart';


class PopularMoviesBloc {
  static final PopularMoviesBloc _instance =
      PopularMoviesBloc._newInstance();

  final MoviesRepository _useCase = MoviesRepository();

  final _popularMovies = List<Movie>();

  final StreamController<MoviesList> _popularMoviesStream =
      StreamController<MoviesList>.broadcast();

  StreamSink<MoviesList> get popularSink =>
      _popularMoviesStream.sink;

  Stream<MoviesList> get popularStream =>
      _popularMoviesStream.stream;

  void diposeStreams() {
    _popularMoviesStream?.close();
  }

  void getPopularMovies(int page) {
    _useCase.getPopularMovies(page).then((result) => manageResult(result));
  }

  void manageResult(ResultWrapper<MoviesList> result) {
    switch (result.getType()) {
      case Type.DATA:
        _popularMovies.addAll(result.data.results);
        result.data.results = _popularMovies;
        _popularMoviesStream.add(result.data);
        break;
      case Type.ERROR:
        _popularMoviesStream.addError(result.getException);
        break;
      case Type.UNKNOWN:
        // TODO: Handle this case.
        break;
    }
  }

  PopularMoviesBloc._newInstance();

  static PopularMoviesBloc get instance => _instance;
}
