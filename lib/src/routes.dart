import 'package:flutter/material.dart';
import 'package:flutter_movies/src/ui/pages/main_page.dart';
import 'package:flutter_movies/src/ui/pages/movie_detail.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    "/": (BuildContext context) => MainPage(),
    "movieDetail": (BuildContext context) => MovieDetailPage()
  };
}
