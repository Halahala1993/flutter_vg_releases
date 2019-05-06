import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryImage extends StatelessWidget {

  final Color mainColor = const Color(0xff3C3261);

  final String gamePoster;
  final double height;
  final double width;

  CategoryImage(this.gamePoster, this.height, this.width);

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[

        new Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(1.0),
            color: Colors.grey,
            boxShadow: [
              new BoxShadow(
                  color: mainColor, blurRadius: 1.0, offset: new Offset(2.0, 5.0))
            ],
          ),
          child: (gamePoster != null && gamePoster.isNotEmpty) ?
              CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: gamePoster,
                placeholder: (context, url) {
                  new CircularProgressIndicator();
                },
              ) : Container(),
        )
      ],
    );
  }
}
