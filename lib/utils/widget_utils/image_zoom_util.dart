import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';

class ImageZoom extends StatelessWidget {
  final String url;

  ImageZoom({this.url});

  @override
  Widget build(BuildContext context) {

    return Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoView(
          heroTag: url,
          imageProvider: NetworkImage(
            url,
          )
        )
    );
  }
}