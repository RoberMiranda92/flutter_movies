import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/src/blocs/movies_bloc.dart';
import 'package:flutter_movies/src/blocs/popular_movies_bloc.dart';
import 'package:flutter_movies/src/blocs/search_movies_bloc.dart';
import 'package:flutter_movies/src/models/movies_model.dart';
import 'package:flutter_movies/src/models/server_error.dart';
import 'package:flutter_movies/src/ui/components/card_swiper.dart';
import 'package:flutter_movies/src/ui/components/error_view.dart';
import 'package:flutter_movies/src/ui/components/horizontal_cast_swiper.dart';
import 'package:flutter_movies/src/ui/models/movie_card.dart';

class MainPage extends StatelessWidget {
  final MoviesBloc _moviesProvider = MoviesBloc.instance;
  final PopularMoviesBloc _popularProvider = PopularMoviesBloc.instance;

  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Movies on Cinema"),
          backgroundColor: Colors.indigo,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () => {
                showSearch(context: context, delegate: MovieSearchDelegate())
              },
            )
          ],
        ),
        body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _createCardSwiper(),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Populars",
                        style: Theme.of(context).textTheme.subtitle1)),
                _createFooter(context)
              ]),
        ),
      ),
    );
  }

  Widget _createCardSwiper() {
    _moviesProvider.getMovies();

    return StreamBuilder<MoviesList>(
        stream: _moviesProvider.moviesStream,
        builder: (BuildContext context, AsyncSnapshot<MoviesList> snapshop) {
          Widget child;

          if (!snapshop.hasData && !snapshop.hasError) {
            child = Center(child: CircularProgressIndicator());
          }

          if (snapshop.hasData) {
            child = CardSwiper(
              cardList: snapshop.data.results,
              onElementClickListener: (Movie movie, String id) =>
                  navigateToMovieDetail(context, movie, id),
            );
          }

          if (snapshop.hasError) {
            child = Center(
                child:
                    ErrorView.withError(error: snapshop.error as ServerError));
          }

          return child;
        });
  }

  Widget _createFooter(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    _popularProvider.getPopularMovies(++_page);

    return StreamBuilder(
      stream: _popularProvider.popularStream,
      builder: (BuildContext context, AsyncSnapshot<MoviesList> snapshop) {
        Widget child;
        MoviesList result;

        if (!snapshop.hasData && !snapshop.hasError) {
          child = Center(child: CircularProgressIndicator());
        }

        if (snapshop.hasData) {
          result = snapshop.data;
          child = HorizontalCastView(
            castList:
                result.results.map((e) => MovieCard.fromMovie(e)).toList(),
            onEndListener: () => {_popularProvider.getPopularMovies(++_page)},
            onElementClickListener: (MovieCard movieCard, String id) =>
                navigateToMovieDetail(context, movieCard.movie, id),
          );
        }

        if (snapshop.hasError) {
          child = Center(
              child: ErrorView.withError(error: snapshop.error as ServerError));
        }

        return Container(
            margin: EdgeInsets.only(top: 10, bottom: 5),
            child: child,
            width: _size.width,
            height: _size.height * 0.25);
      },
    );
  }

  void navigateToMovieDetail(BuildContext context, Movie movie, String id) {
    HashMap<String, dynamic> arguments = HashMap();
    arguments["movie"] = movie;
    arguments["id"] = id;
    Navigator.pushNamed(context, "movieDetail", arguments: arguments);
  }
}

class MovieSearchDelegate extends SearchDelegate {
  final SearchBloc _searchBloc = SearchBloc.instance;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => {query = ""},
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => {close(context, null)});
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else {
      _searchBloc.search(query);
      return StreamBuilder<MoviesList>(
          stream: _searchBloc.searchStream,
          builder: (BuildContext context, AsyncSnapshot<MoviesList> snapshop) {
            Widget child;

            if (!snapshop.hasData && !snapshop.hasError) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshop.hasData) {
              var list = snapshop.data.results;
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var movie = list[index];
                  return ListTile(
                    onTap: () {
                      navigateToMovieDetail(context, movie, "movie.id-search");
                    },
                    leading: _createCard(MovieCard.fromMovie(movie)),
                    title: Text(movie.title != null
                        ? movie.title
                        : movie.originalTitle),
                    subtitle: Text(
                        movie.releaseDate != null ? movie.releaseDate : ""),
                  );
                },
                itemCount: list.length,
              );
            }

            if (snapshop.hasError) {
              return Center(
                  child: ErrorView.withError(
                      error: snapshop.error as ServerError));
            }
          });
    }
  }

  Widget _createCard(MovieCard card) {
    return Hero(
      tag: "${card.getId()}-horizontal",
      child: Container(
        height: 50,
        width: (50 * 3) / 4,
        child: CachedNetworkImage(
          imageBuilder: (context, imageProvider) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ));
          },
          imageUrl: card.getImageURL(),
          placeholder: (context, url) => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/img/no-image.jpg')),
          errorWidget: (context, url, error) => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/img/image_error.jpg')),
        ),
      ),
    );
  }

  void navigateToMovieDetail(BuildContext context, Movie movie, String id) {
    HashMap<String, dynamic> arguments = HashMap();
    arguments["movie"] = movie;
    arguments["id"] = id;
    Navigator.pushNamed(context, "movieDetail", arguments: arguments);
  }
}
