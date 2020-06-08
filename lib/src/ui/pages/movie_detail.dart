import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/src/blocs/movies_cast_bloc.dart';
import 'package:flutter_movies/src/models/movies_cast_list.dart';
import 'package:flutter_movies/src/models/movies_model.dart';
import 'package:flutter_movies/src/models/server_error.dart';
import 'package:flutter_movies/src/ui/components/card_view.dart';
import 'package:flutter_movies/src/ui/components/error_view.dart';
import 'package:flutter_movies/src/ui/components/horizontal_cast_swiper.dart';
import 'package:flutter_movies/src/ui/models/cast_card.dart';
import 'package:flutter_movies/src/ui/models/movie_card.dart';
import 'package:flutter_movies/src/utils/extensions.dart';

class MovieDetailPage extends StatelessWidget {
  final MoviesCastBloc moviesCastBloc = MoviesCastBloc.instance;

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    final movie = arguments["movie"] as Movie;
    final id = arguments["id"] as String;

    return Container(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _createAppBar(context, movie),
            SliverList(
                delegate: SliverChildListDelegate([
              _createDetail(context, movie, id),
              _createDescriptionText(context, movie),
              _createDescriptionText(context, movie),
              _createCastRow(context, movie)
            ]))
          ],
        ),
      ),
    );
  }

  Widget _createAppBar(BuildContext context, Movie movie) {
    Size size = MediaQuery.of(context).size;
    double height = size.height * 0.25 >= 200.0 ? 200.0 : size.height * 0.25;
    return SliverAppBar(
      elevation: 2.0,
      floating: false,
      pinned: true,
      expandedHeight: height,
      flexibleSpace: FlexibleSpaceBar(
        background: CachedNetworkImage(
          imageBuilder: (context, imageProvider) {
            return Image(image: imageProvider, fit: BoxFit.fill);
          },
          imageUrl: movie.getCoverImage(),
          placeholder: (context, url) => Image.asset(
            'assets/img/loading.gif',
            fit: BoxFit.fill,
          ),
          errorWidget: (context, url, error) =>
              Image.asset('assets/img/image_error.jpg', fit: BoxFit.fill),
        ),
        title: Text("${movie.title}"),
        centerTitle: false,
      ),
      backgroundColor: Colors.indigo,
    );
  }

  Widget _createDetail(BuildContext context, Movie movie, String id) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Hero(
              tag: id,
              child: CardView(card: MovieCard.fromMovie(movie)),
            ),
            SizedBox(width: 20),
            Flexible(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      movie.releaseDate,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Row(children: <Widget>[
                      Icon(Icons.stars),
                      Text(
                        movie.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ]),
                  ]),
            )
          ],
        ));
  }

  Widget _createDescriptionText(BuildContext context, Movie movie) {
    return Container(
        margin: EdgeInsets.all(20),
        child: Text(
          movie.overview,
          style: Theme.of(context).textTheme.bodyText1,
        ));
  }

  Widget _createCastRow(BuildContext context, Movie movie) {
    final Size _size = MediaQuery.of(context).size;
    moviesCastBloc.getCast(movie.id);

    return StreamBuilder(
      stream: moviesCastBloc.castStream,
      builder: (BuildContext context, AsyncSnapshot<MovieCastList> snapshot) {
        Widget child;
        MovieCastList result;

        if (!snapshot.hasData && !snapshot.hasError) {
          child = Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          result = snapshot.data;
          child = HorizontalCastView(
              castList: result.cast.map((e) => CastCard.fromCast(e)).toList(),
              onEndListener: () => {},
              onElementClickListener: (CastCard castCard, String id) => {});
        }

        if (snapshot.hasError) {
          child = Center(
              child: ErrorView.withError(error: snapshot.error as ServerError));
        }

        return Container(
            margin: EdgeInsets.only(top: 10, bottom: 5),
            child: child,
            width: _size.width,
            height: _size.height * 0.25);
      },
    );
  }
}
