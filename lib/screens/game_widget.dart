import 'package:auto_size_text/auto_size_text.dart';
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
    String gameThumbUrl = game.image.screenLargeUrl;
    return Hero(
      transitionOnUserGestures: true,
      tag: "game_poster" + (game.id.toString()),
      child: new Container(
        margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
        child: new Container(
          width: 106.0,
          height: 96.0,
        ),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(1.0),
          color: Colors.grey,
          image: new DecorationImage(
              image: new NetworkImage(
                  gameThumbUrl
              ),
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
 
}