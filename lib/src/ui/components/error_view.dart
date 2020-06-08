import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/server_error.dart';

class ErrorView extends StatelessWidget {
  ServerError _error;

  ErrorView.withError({@required ServerError error}) {
    this._error = error;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(child: Text("${_error.getErrorMessage()}")),
    );
  }
}
