import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_game_releases/bloc/bloc.dart';
import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/models/videos.dart';
import 'package:video_game_releases/utils/constants.dart';

class VideosList extends StatefulWidget {
  
  final Game game;

  VideosList({this.game});

  @override
  _VideosListState createState() => _VideosListState();
}

class _VideosListState extends State<VideosList> {

  final Color mainColor = Colors.black38;
  final DetailGameBloc _gameBloc = DetailGameBloc();
  List<Videos> gameVideos;
  Game game;
  bool videosAvailable = false;

  @override
  void initState() { 
    super.initState();
    this.game = widget.game;
    if (game.videos != null && game.videos.isNotEmpty) {
      print("Setting up Videos");
      this.videosAvailable = true;
      setupVideos(game);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder(
        bloc: _gameBloc,
        builder: (BuildContext context, DetailGameState state){
          if (!this.videosAvailable) {
            return Container(
              child: Text(Constants.NO_VIDEOS_FOUND),
            );
          }

          if(state is GameVideos) {
            this.gameVideos = state.videos;
            return buildGameVideosList();
          }

          return new Container(
            child: CircularProgressIndicator(),
          );

        },
      ),
    );
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

  Stack buildSimilarGamePoster(int index) {
    return new Stack(
      children: <Widget>[

        new Container(
          width: 320.0,
          height: 180.0,
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(1.0),
            color: Colors.grey,
            boxShadow: [
              new BoxShadow(
                  color: mainColor, blurRadius: 1.0, offset: new Offset(2.0, 5.0))
            ],
          ),
          child: retrieveGamePoster(index),
        )
      ],
    );
  }

  FadeInImage retrieveGamePoster(int index) {

    String gamePoster = gameVideos[index].image.smallUrl;
    
    if (gamePoster != null && gamePoster.isNotEmpty) {
      return FadeInImage.assetNetwork(
        fit: BoxFit.cover,
          placeholder: 'assets/image_loading.gif',
          image: gamePoster
      );
    } else {
      return null;
    }
  }

  setupVideos(Game game) {
    if (game.videos != null  && game.videos.length != 0) {
      String videoIds = formatVideoIds(game.videos);
      _gameBloc.dispatch(FetchVideos(videoIds));
    }
  }

  String formatVideoIds(List<Videos> videos) {
    String videosIds = "";
    for (Videos video in videos) {
      videosIds += "${video.id}|";
    }

    return videosIds;
  }
}