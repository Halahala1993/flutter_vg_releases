import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_game_releases/bloc/bloc.dart';
import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/utils/date_util.dart';
import 'package:video_game_releases/utils/platform_badge_builder.dart';

class GameWidget extends StatelessWidget {
  final Game game;
  final GameBloc gameBloc;
  Color mainColor = const Color(0xff3C3261);
  BuildContext _context;

  GameWidget({Key key, @required this.game, this.gameBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    this._context =context;

    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(0.0),
              child: buildGameIcon(),
            ),
            new Expanded(
                child: new Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: new Column(children: [
                    new Text(
                      game.name,
                      style: new TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Arvo',
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[

                        Icon(Icons.calendar_today),
                        new Text (
                          DateUtil.resolveGameReleaseDate(this.game)
                        )

                    ],),
                    new Padding(padding: const EdgeInsets.all(2.0)),
                    
                    game.deck == null || game.deck.isEmpty ? Text("No description available") : new AutoSizeText(
                      game.deck,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: new TextStyle(
                          color: const Color(0xff8785A4),
                          fontFamily: 'Arvo'
                      ),
                    ),
                    buildPlatformBadge()
                  ],
                    crossAxisAlignment: CrossAxisAlignment.start,),
                )
            ),
          ],
        ),
        new Container(
          width: 300.0,
          height: 0.5,
          color: const Color(0xD2D2E1ff),
          margin: const EdgeInsets.all(16.0),
        )
      ],
    );
  }

  Widget buildPlatformBadge() {
    List<Widget> children = new List();

    if (game.platforms == null) {
      return Container();
    }

    for (var platform in game.platforms) {

      if (platform.abbreviation != null) {
        children.add(
            Expanded(
                child: PlatformBadgeBuilder.buildPlatformBadge(
                    platform.abbreviation)
            )
        );
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: children
    );
  }

  Widget buildGameIcon() {
    String gameThumbUrl = game.image.originalUrl;
    var rand = Random();
    int randomNumber = rand.nextInt(200);


    return Hero(
      transitionOnUserGestures: true,
      tag: gameThumbUrl != null ? "$gameThumbUrl" : "image_$randomNumber",
      child: new Container(
        margin: const EdgeInsets.fromLTRB(0, 2, 1, 2),
        child: new Container(
          width: 96.0,
          height: 120.0,
          child: FadeInImage.assetNetwork(
              placeholder: 'assets/image_loading.gif',
              image: gameThumbUrl
          ),
        ),
      ),
    );
  }
 
}