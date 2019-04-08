import 'package:equatable/equatable.dart';
import 'package:video_game_releases/models/game.dart';

abstract class GameEvent extends Equatable {
  GameEvent([List props = const []]) : super(props);
}

class Fetch extends GameEvent {
  @override
  String toString() => 'Fetch';
}

class FetchGameDetail extends GameEvent {
  final int gameId;

  FetchGameDetail(this.gameId);


  @override
  String toString() => 'FetchGameDetail';
}