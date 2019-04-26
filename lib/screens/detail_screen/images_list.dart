import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_game_releases/models/image.dart';
import 'package:video_game_releases/utils/constants.dart';
import 'package:video_game_releases/utils/widget_utils/image_zoom_util.dart';

class ImagesList extends StatefulWidget {

  final List<Images> gameImages;

  ImagesList({this.gameImages});

  @override
  _ImagesListState createState() => _ImagesListState();
}

class _ImagesListState extends State<ImagesList> {

  final Color mainColor = Colors.black38;
  List<Images> gameImages;

  @override
  void initState() { 
    super.initState();
    this.gameImages = widget.gameImages;
  }

  @override
  Widget build(BuildContext context) {
    return buildGameImagesList();
  }

  Widget buildGameImagesList() {

    if (this.gameImages == null || this.gameImages.isEmpty) {
      return Container(
        child: Text(Constants.NO_IMAGES_FOUND),
      );
    } else if (this.gameImages == null || this.gameImages.isEmpty){
      return new CircularProgressIndicator();
    }

    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Expanded(
          child: new Container(
            height: 250,
            child: buildGameImagesListView(),
          ),
        ),
      ],
    );
  }

  Widget buildGameImagesListView() {
    return ListView.builder(
        key: PageStorageKey("images"),//Required to get passed type bool is not subtype of double error.(scroll position error)
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: this.gameImages == null ? 0 : this.gameImages.length,
        itemBuilder: (context, i) {
          return new Column(
            children: <Widget>[
              new FlatButton(
                child: new Padding(
                  padding: const EdgeInsets.only(
                      right: 8, left: 8, bottom: 8),
                  child: buildSimilarGamePoster(i),
                ),
                padding: const EdgeInsets.all(0.0),
                onPressed: () {

                  String gamePoster = this.gameImages[i].mediumUrl;
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageZoom(url: gamePoster)
                    ),
                  );
                },
                color: Colors.white,
              ),
              /*new Container(
                width: 100,
                child: new AutoSizeText(
                  gameImages[i].name,//TODO Tags?
                  maxLines: 3,
                  maxFontSize: 16,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )*/
            ],
          );
        });
  }

  Stack buildSimilarGamePoster(int index) {

    String gamePoster = this.gameImages[index].mediumUrl;

    var rand = Random();
    int randomNumber = rand.nextInt(200);

    return new Stack(
      children: <Widget>[

        Hero(
          tag: gamePoster != null ? "$gamePoster" : "image_$randomNumber",
          child: Container(
          margin: const EdgeInsets.only(left: 2.0, right: 2.0),
          width: 240.0,
          height: 135.0,
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(1.0),
            color: Colors.grey,
            boxShadow: [
              new BoxShadow(
                  color: mainColor, blurRadius: 1.0, offset: new Offset(2.0, 5.0))
            ],
          ),
          child: retrieveGamePoster(index),
        ),
        )
      ],
    );
  }

  FadeInImage retrieveGamePoster(int index) {

    String gamePoster = this.gameImages[index].mediumUrl;

    if (gamePoster != null && gamePoster.isNotEmpty) {
      return FadeInImage.assetNetwork(
          fit: BoxFit.cover,
          placeholderScale: 0.4,
          placeholder: 'assets/image_loading.gif',
          image: gamePoster
      );
    } else {
      return null;
    }
  }
}