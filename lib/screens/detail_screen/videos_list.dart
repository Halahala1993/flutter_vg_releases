import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_game_releases/bloc/bloc.dart';
import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/models/videos.dart';
import 'package:video_game_releases/screens/detail_screen/category_image.dart';
import 'package:video_game_releases/utils/constants.dart';
//import 'package:video_game_releases/utils/widget_utils/web_launcher.dart';
import 'package:video_game_releases/utils/widget_utils/web_launcher.dart';

//import 'package:webview_flutter/webview_flutter.dart';

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
                  child: CategoryImage(
                          this.gameVideos[i].image.smallUrl,
                          180.0,
                          320.0
                        )
                ),
                padding: const EdgeInsets.all(0.0),
                onPressed: () async {
                  String youtubeId = this.gameVideos[i].youtubeId;
                  String url = Constants.YOUTUBE_URL + youtubeId;

                  await WebLauncher.launchUrl(url);
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