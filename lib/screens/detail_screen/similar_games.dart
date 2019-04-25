import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/screens/game_detail.dart';
import 'package:video_game_releases/utils/constants.dart';

class SimilarGamesList  extends StatelessWidget {
  
  final Color mainColor = Colors.black38;
  final List<Game> similarGames;

  SimilarGamesList({this.similarGames});

  @override
  Widget build(BuildContext context) {
    return buildSimilarGamesList();
  }

  Widget buildSimilarGamesList() {

    if (similarGames == null || similarGames.isEmpty) {
      return Container(
        child: Text(Constants.NO_SIMILAR_GAMES_FOUND),
      );
    } else if (similarGames == null || similarGames.isEmpty){
      return new CircularProgressIndicator();
    }

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

  Widget buildSimilarGamesListView() {
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

  Container buildSimilarGamePoster(int index) {
    return new Container(
      margin: const EdgeInsets.only(left: 2.0, right: 2.0),
      child: new Container(
        width: 100.0,
        height: 155.0,
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

    String gamePoster = similarGames[index].image.originalUrl;
    
    if (gamePoster != null && gamePoster.isNotEmpty) {
      return new DecorationImage(
          image: new NetworkImage(gamePoster),
          fit: BoxFit.cover);
    } else {
      return null;
    }
  }
  
}