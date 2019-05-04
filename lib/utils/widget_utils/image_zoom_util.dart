import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';

class ImageZoom extends StatelessWidget {
  final String url;

  ImageZoom({this.url});

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        Container(
            constraints: BoxConstraints.expand(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
            ),
            child: PhotoView(
                key: Key("image_zoom"),
                heroTag: url,
                imageProvider: NetworkImage(
                  url,
                )
            )
        ),
        new Positioned( //Place it at the top, and not use the entire screen
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: new IconButton(
              icon: new Icon(
                Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}
