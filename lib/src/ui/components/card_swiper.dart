import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/movies_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_movies/src/utils/extensions.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> cardList;
  final Function(Movie movie, String id) onElementClickListener;

  CardSwiper({@required this.cardList, this.onElementClickListener});

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10),
      height: _size.height * 0.55,
      width: _size.width,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: ((_size.height * 0.45) * 3) / 4,
        itemHeight: _size.height * 0.45,
        itemBuilder: (BuildContext context, int index) {
          return Hero(
            tag: "${cardList[index].id}-swiper",
            child: CachedNetworkImage(
              imageBuilder: (context, imageProvider) {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(image: imageProvider, fit: BoxFit.fill));
              },
              imageUrl: cardList[index].getUrlImage(),
              placeholder: (context, url) =>
                  Image.asset('assets/img/no-image.jpg'),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/img/image_error.jpg'),
            ),
          );
        },
        itemCount: cardList.length,
        onTap: (int index) => onElementClickListener(this.cardList[index], "${cardList[index].id}-swiper"),
      ),
    );
  }
}
