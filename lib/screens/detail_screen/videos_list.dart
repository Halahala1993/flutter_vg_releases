import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:video_game_releases/models/videos.dart';
import 'package:video_game_releases/utils/constants.dart';

class VideosList extends StatelessWidget {
  
  final Color mainColor = Colors.black38;
  final List<Videos> gameVideos;

  const VideosList({this.gameVideos});

  @override
  Widget build(BuildContext context) {
    return buildGameVideosList();
  }

  Widget buildGameVideosList() {

    if (gameVideos == null || gameVideos.isEmpty) {
      return Container(
        child: Text(Constants.NO_VIDEOS_FOUND),
      );
    } else if (gameVideos == null || gameVideos.isEmpty){
      return new CircularProgressIndicator();
    }

    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Expanded(
          child: new Container(
            height: 250,
            child: buildGameVideosListView(),
          ),
        ),
      ],
    );
  }

  Widget buildGameVideosListView() {
    return ListView.builder(
        key: PageStorageKey(this.gameVideos[0].name),//Required to get passed type bool is not subtype of double error.(scroll position error)
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: gameVideos == null ? 0 : gameVideos.length,
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => GameDetailScreen(
                  //         gameVideos[i], i.toString()),
                  //   ),
                  // );
                },
                color: Colors.white,
              ),
              new Container(
                width: 100,
                child: new AutoSizeText(
                  gameVideos[i].name,
                  maxLines: 3,
                  maxFontSize: 16,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          );
        });
  }

  Container buildSimilarGamePoster(int index) {
    return new Container(
      margin: const EdgeInsets.only(left: 2.0, right: 2.0),
      child: new Container(
        width: 320.0,
        height: 180.0,
      ),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(1.0),
        color: Colors.grey,
        image: retrieveGamePoster(index),
        boxShadow: [
          new BoxShadow(
              color: mainColor, blurRadius: 1.0, offset: new Offset(2.0, 5.0))
        ],
      ),
    );
  }

  DecorationImage retrieveGamePoster(int index) {

    String gamePoster = gameVideos[index].image.smallUrl;
    
    if (gamePoster != null && gamePoster.isNotEmpty) {
      return new DecorationImage(
          image: new NetworkImage(gamePoster),
          fit: BoxFit.cover);
    } else {
      return null;
    }
  }
}