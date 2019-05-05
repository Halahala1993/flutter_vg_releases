import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class BaseCategoryList {

  Color mainColor = const Color(0xff3C3261);

  Stack buildCategoryPoster(String gamePoster, BoxFit boxFit, double height, double width) {
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
          child: retrieveGamePoster(gamePoster, boxFit),
        )
      ],
    );
  }
  
  CachedNetworkImage retrieveGamePoster(String gamePoster, BoxFit boxFit) {

    if (gamePoster != null && gamePoster.isNotEmpty) {

      return new CachedNetworkImage(
        fit: boxFit,
        imageUrl: gamePoster,
        placeholder: (context, url) {
          new CircularProgressIndicator();
        },
      );
    } else {
      return null;
    }
  }
}