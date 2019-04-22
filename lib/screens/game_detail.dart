import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:video_game_releases/bloc/bloc.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:video_game_releases/models/game.dart';
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
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final GameBloc _gameBloc = GameBloc();

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
            }
          }

          if (state is GameError) {
            if (this.game == null) {
              return new Container();
            } else {
              Fluttertoast.showToast(
                  msg: "Error retrieving additional details",
                  backgroundColor: Colors.redAccent
              );
            }
          }

          if (state is SimilarGames) {
            this.similarGames = state.games;
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
                      mainAxisSize: MainAxisSize.max,
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
                    this.similarGames != null ? buildSectionHeader(Constants.SIMILAR_GAMES) : Container(),
                    buildSimilarGamesList()
                  ],
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                ),
              ));
        },
      )
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
    return new Container(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: new Text(
        this.game.deck,
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
            fontWeight: FontWeight.bold),
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

  Row buildSimilarGamesList() {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Expanded(
          child: new Container(
            height: 250,
            child: new ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: similarGames == null ? 0 : similarGames.length,
                itemBuilder: (context, i) {
                  return new Column(
                    children: <Widget>[
                      new FlatButton(
                        child: new Padding(
                          padding: const EdgeInsets.only(
                              right: 8, left: 8, bottom: 14),
                          child: buildSimilarGamePoster(i),
                        ),
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameDetailScreen(
                                  similarGames[i], i.toString()),
                            ),
                          );
                        },
                        color: Colors.white,
                      ),
                      new Container(
                        width: 100,
                        child: new AutoSizeText(
                          this.similarGames[i].name,
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
                }),
          ),
        ),
      ],
    );
  }

  Container buildSimilarGamePoster(int i) {
    return new Container(
      margin: const EdgeInsets.all(2.0),
      child: new Container(
        width: 100.0,
        height: 155.0,
      ),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(1.0),
        color: Colors.grey,
        image: retrieveGamePoster(i),
        boxShadow: [
          new BoxShadow(
              color: mainColor, blurRadius: 1.0, offset: new Offset(2.0, 5.0))
        ],
      ),
    );
  }

  DecorationImage retrieveGamePoster(int i) {
    String gamePoster = similarGames[i].image.originalUrl;

    if (gamePoster != null && gamePoster.isNotEmpty) {
      return new DecorationImage(
          image: new NetworkImage(gamePoster),
          fit: BoxFit.cover);
    } else {
      return null;
    }
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
    /*int index = gameIds.lastIndexOf("|");
    return gameIds.substring(0, index);*/
  }

  @override
  void dispose() {
    _gameBloc.dispose();
    super.dispose();
  }

}
