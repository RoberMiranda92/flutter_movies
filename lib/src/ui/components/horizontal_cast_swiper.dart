import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/src/ui/components/card_view.dart';
import 'package:flutter_movies/src/ui/models/Icard.dart';

class HorizontalCastView<T extends ICard> extends StatelessWidget {
  final List<T> castList;
  final ScrollController _controller =
      ScrollController(initialScrollOffset: 0, keepScrollOffset: false);
  final Function onEndListener;
  final Function(T element, String id) onElementClickListener;

  HorizontalCastView(
      {@required this.castList,
      this.onEndListener,
      this.onElementClickListener});

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent) {
        this.onEndListener();
      }
    });
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _controller,
        itemCount: this.castList.length,
        itemBuilder: (BuildContext context, int index) {
          T card = this.castList[index];
          return GestureDetector(
              child: CardView(card:card),
              onTap: () {
                onElementClickListener(card, "${card.getId()}-horizontal");
              });
        });
  }
}
