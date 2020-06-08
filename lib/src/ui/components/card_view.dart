import 'package:flutter/material.dart';
import 'package:flutter_movies/src/ui/models/Icard.dart';

class Card<T extends ICard> extends StatelessWidget {
  
  T _card;
  Card({T card}) {
    this._card = card;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.25,
      width: (size.height * 0.25 * 3) / 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              height: size.height * 0.2,
              width: (size.height * 0.2 * 3) / 4,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Hero(
                tag: "${card.getId()}-horizontal",
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
              )),
          Text(
            card.getTitle(),
            style: Theme.of(context).textTheme.caption,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
