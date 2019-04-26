import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_game_releases/bloc/bloc.dart';
import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/screens/detail_screen/game_detail.dart';
import 'package:video_game_releases/utils/constants.dart';

class SimilarGamesList  extends StatelessWidget {
  
  final Color mainColor = Colors.black38;
  final DetailGameBloc _gameBloc = DetailGameBloc();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Game> similarGames;
  final Game game;
  bool similarGamesAvailable = false;

  SimilarGamesList({this.game}) {
    if (game.similarGames != null && game.similarGames.isNotEmpty) {
      this.similarGamesAvailable = true;
      setupSimilarGames(game);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder(
        bloc: _gameBloc,
        builder: (BuildContext context, DetailGameState state){

          if (!this.similarGamesAvailable) {
            return Container(
              child: Text(Constants.NO_SIMILAR_GAMES_FOUND),
            );
          }

          if (state is SimilarGames) {
            this.similarGames = state.games;
            return buildSimilarGamesList();
          }

          return new Container(
            child: CircularProgressIndicator(),
          );
        },
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
            child: buildSimilarGamesListView(),
          ),
        ),
      ],
    );
  }

  ListView buildSimilarGamesListView() {

    return ListView.builder(
        key: PageStorageKey(this.similarGames[0].name),//Required to get passed type bool is not subtype of double error.(scroll position error)
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: similarGames == null ? 0 : similarGames.length,
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
                  similarGames[i].name,
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
          margin: const EdgeInsets.only(left: 2.0, right: 2.0),
          width: 100.0,
          height: 155.0,
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

    String gamePoster = similarGames[index].image.originalUrl;

    if (gamePoster != null && gamePoster.isNotEmpty) {
      return FadeInImage.assetNetwork(
          fit: BoxFit.fitHeight,
          placeholderScale: .3,
          imageScale: 1.0,
          placeholder: 'assets/image_loading.gif',
          image: gamePoster
      );
    } else {
      return null;
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
  
}