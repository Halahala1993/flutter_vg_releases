import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:video_game_releases/bloc/bloc.dart';
import 'package:video_game_releases/models/enums.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/models/videos.dart';
import 'package:video_game_releases/screens/detail_screen/similar_games.dart';
import 'package:video_game_releases/screens/detail_screen/videos_list.dart';
import 'package:video_game_releases/screens/homepage.dart';
import 'package:video_game_releases/utils/constants.dart';
import 'package:video_game_releases/utils/date_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GameDetailScreen extends StatefulWidget {
  String heroId;
  Game game;

  GameDetailScreen(Game game, this.heroId) {
    this.game = game;
  }

  @override
  State<StatefulWidget> createState() {
    return new GameDetailState(this.game);
  }
}

class GameDetailState extends State<GameDetailScreen> {
  final Color mainColor = Colors.black38;
  bool requesting = false;
  Game game;
  List<Game> similarGames;
  List<Videos> gameVideos;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final GameBloc _gameBloc = GameBloc();

  bool gameDetailRetrieved  = false;

  String gamePosterPath;
  String appBarImage;

  GameDetailState(@required Game game) {
    this.game = game;
    this.gamePosterPath = this.game.image.originalUrl;
    this.appBarImage = this.game.image.mediumUrl;

    _gameBloc.dispatch(FetchGameDetail(game.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: BlocBuilder(
        bloc: _gameBloc,
        builder: (BuildContext context, GameState state){

          if (state is GameDetail) {
            if (state.game != null) {
              this.game = state.game;

              setupSimilarGames(this.game);

              setupVideos(this.game);

              gameDetailRetrieved = true;
            }
          }

          if (state is GameError) {
            if (this.game == null) {
              return new Container();
            } else {
              Fluttertoast.showToast(
                  msg: Constants.ERROR_RETRIEVE_DETAILS,
                  backgroundColor: Colors.redAccent
              );
            }
          }

          if (state is SimilarGames) {
            this.similarGames = state.games;
          }

          if (state is GameVideos) {
            this.gameVideos = state.videos;
          }

          return NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  buildSliverAppBar(),
                ];
              },
              //Wrap Body in SingleChildScrollView to workaround overflow issue.
              body: new SingleChildScrollView(
                child: new Column(
                  /*First row with Poster*/
                  /*Second row with button and summary*/
                  /*Last row with Similar games Listview*/
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: new Column(
                              children: [
                                buildGamePoster()
                              ],
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ),
                        ),
                        buildGameReleaseDate(),
                      ],
                    ),
                    new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Expanded(
                            child: new Container(
                              margin: const EdgeInsets.fromLTRB(2.0, 35.0, 16.0, 20.0),
                              child: new Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      //
                                    ],
                                  ),
                                  buildSectionHeader(Constants.SUMMARY),
                                  buildGameOverview(),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                            ))
                      ],
                    ),
                    //buildSectionTiles
                    !gameDetailRetrieved ? buildProgressIndicator(100, 100) : new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buildSectionTiles(),
                      ],
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                ),
              ));
        },
      )
    );
  }

  Row buildProgressIndicator(double height, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          height: height,
          width: width,
          child: CircularProgressIndicator(),
        )
      ],
    );
  }

  Expanded buildGameReleaseDate() {
    return new Expanded(
        child: new Container(
          margin: const EdgeInsets.fromLTRB(0.0, 0, 0, 0.0),
          child: new Column(
            children: [
              new Row(
                children: <Widget>[
                  new Padding(padding: EdgeInsets.only(left: 20, right: 20)),
                  new AutoSizeText(
                    DateUtil.resolveGameReleaseDate(game),
                    maxLines: 1,
                    maxFontSize: 12,
                    minFontSize: 6,
                    style: new TextStyle(
                        color: const Color(0xff8785A4), fontFamily: 'Arvo'),
                  ),
                  new Icon(
                      Icons.calendar_today
                  )
                ],
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ));
  }

  Container buildGameOverview() {

    String overview = this.game.deck;

    print("overview: $overview");

    if (overview == null || overview.trim().isEmpty) {
      overview = Constants.NO_SUMMARY_FOUND;
    }

    return new Container(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: new Text(
        overview,
        style: new TextStyle(
            color: Colors.black54, fontFamily: 'Arvo', fontSize: 18.0),
      ),
    );
  }

  Container buildSectionHeader(String headerText) {
    return new Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.fromLTRB(25, 5, 0, 15),
      child: new Text(
        headerText,
        style: new TextStyle(
            color: Colors.black87,
            fontStyle: FontStyle.italic,
            fontSize: 24.0,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget buildGamePoster() {
    return Hero(
      tag: "game_poster" + (widget.heroId),
      child: new Container(
        margin: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
        child: new Container(
          width: 150.0,
          height: 245.0,
        ),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(1.0),
          color: Colors.grey,
          image: new DecorationImage(
              image: new NetworkImage(gamePosterPath),
              fit: BoxFit.cover),
          boxShadow: [
            new BoxShadow(
                color: mainColor,
                blurRadius: 1.0,
                offset: new Offset(2.0, 5.0))
          ],
        ),
      ),
    );
  }


   SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
        expandedHeight: 200.0,
        floating: false,
        pinned: true,
        backgroundColor: mainColor,
        flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            collapseMode: CollapseMode.parallax,
            title: new FractionallySizedBox(
              widthFactor: .7,
              alignment: Alignment.center,
              child: new AutoSizeText(
                game.name,
                maxLines: 2,
                textAlign: TextAlign.center,
                maxFontSize: 18,
                minFontSize: 8,
                style: TextStyle(color: Colors.white, shadows: [
                  Shadow(
                    // bottomLeft
                      offset: Offset(-1.5, -1.5),
                      color: Colors.black54),
                  Shadow(
                    // bottomRight
                      offset: Offset(1.5, -1.5),
                      color: Colors.black54),
                  Shadow(
                    // topRight
                      offset: Offset(1.5, 1.5),
                      color: Colors.black54),
                  Shadow(
                    // topLeft
                      offset: Offset(-1.5, 1.5),
                      color: Colors.black54)
                ]),
              ),
            ),
            background: Image.network(
              this.appBarImage,
              fit: BoxFit.cover,
            )),
        leading: new Builder(builder: (context) {
          return GestureDetector(
            child: new IconButton(
              icon: new Icon(
                Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
            onLongPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          );
        }));
  }

  Widget buildSectionTiles() {

    return Expanded(
        child: Container(
          child: SingleChildScrollView(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ListView.builder(
                  physics: ClampingScrollPhysics(),//Key to have page flow with nested scroll view (even tho it's not a nested scroll view)
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) =>
                      buildSubSectionTile(Categories.values[index]),
                  itemCount: Categories.values.length,
                )
              ],
            ),
          ),
        )
    );

  }

  Widget buildSubSectionTile(Categories category) {

    return ExpansionTile(
        key: PageStorageKey<Categories>(category),
        title: Text(categoryValues[category].toString()),
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 5),
            child: determineSubsectionWidget(category),
          )
        ]
    );
  }

  Widget determineSubsectionWidget(Categories category) {
    switch(category) {
      case Categories.VIDEOS :
        //print("");
        return gameDetailRetrieved ? VideosList(gameVideos: gameVideos) : Container();
        break;
      case Categories.IMAGES :
        //print("");
        return Container(
          height: 200,
          width: 200,
        );
        break;
      case Categories.SIMILAR_GAMES :
        //TODO: Test tile with different sized phones.
        return gameDetailRetrieved ? SimilarGamesList(similarGames: this.similarGames,) : Container();
        break;
      case Categories.CHARACTERS :
        //print("");
        return Container(
          height: 200,
          width: 200,
        );
        break;
    }
  }

  setupSimilarGames(Game game) {
    if (game.similarGames != null) {
      String gameIds = formatGameIds(game.similarGames);
      _gameBloc.dispatch(FetchSimilarGames(gameIds));
    }
  }

  String formatGameIds(List<Game> similarGames) {
    String gameIds = "";
    for (Game game in similarGames) {
      gameIds += "${game.id}|";
    }

    return gameIds;
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

  @override
  void dispose() {
    _gameBloc.dispose();
    super.dispose();
  }

}