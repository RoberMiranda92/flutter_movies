
import 'package:flutter_movies/src/models/server_error.dart';

class ResultWrapper<T> {
  ServerError _error;
  T data;

  setException(ServerError error) {
    _error = error;
  }

  setData(T data) {
    this.data = data;
  }

  ServerError get getException {
    return _error;
  }

  Type getType() {
    if (data != null) {
      return Type.DATA;
    }

    if (_error != null) {
      return Type.ERROR;
    }

    return Type.UNKNOWN;
  }
}

enum Type { DATA, ERROR, UNKNOWN }
