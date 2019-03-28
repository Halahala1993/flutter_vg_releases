import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_game_releases/models/game.dart';

class GameWidget extends StatelessWidget {
  final Game game;

  const GameWidget({Key key, @required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${game.id}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(game.name),
      isThreeLine: true,
      subtitle: game.description == null ? Text("") : Text(game.description),
      dense: true,
    );
  }
}