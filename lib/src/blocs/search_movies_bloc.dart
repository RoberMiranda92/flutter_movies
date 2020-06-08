
import 'dart:async';

import 'package:flutter_movies/src/models/movies_model.dart';
import 'package:flutter_movies/src/models/result_wrapper.dart';
import 'package:flutter_movies/src/resources/movies_remote_repository.dart';

class SearchBloc{
  static final SearchBloc _instance = SearchBloc._newInstance();
  final MoviesRepository _repository = MoviesRepository();

  final StreamController<MoviesList> _movieSearchStream =
      StreamController<MoviesList>.broadcast();

  StreamSink<MoviesList> get searchSink => _movieSearchStream.sink;

  Stream<MoviesList> get searchStream => _movieSearchStream.stream;

  void diposeStreams() {
    _movieSearchStream?.close();
  }

  void search(String query) {
    _repository
        .searchMovie(query)
        .then((result) => _manageResult(result));
  }

  void _manageResult(ResultWrapper<MoviesList> result) {
    switch (result.getType()) {
      case Type.DATA:
        _movieSearchStream.add(result.data);
        break;
      case Type.ERROR:
        _movieSearchStream.addError(result.getException);
        break;
      case Type.UNKNOWN:
        // TODO: Handle this case.
        break;
    }
  }

  SearchBloc._newInstance();

  static SearchBloc get instance => _instance;
}