import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:video_game_releases/models/game.dart';

abstract class GameEvent extends Equatable {
  GameEvent([List props = const []]) : super(props);
}

class Fetch extends GameEvent {
  @override
  String toString() => 'Fetch';
}

class FetchFilteredList extends GameEvent {
  @override
  String toString() => 'FetchFilteredList';
}

class FetchGameDetail extends GameEvent {
  final int gameId;

  FetchGameDetail(this.gameId);


  @override
  String toString() => 'FetchGameDetail';
}

class RefreshGameFetch extends GameEvent {
  final List<Game> games;

  RefreshGameFetch({@required this.games}) : assert (games != null), super ([games]);


  @override
  String toString() => 'RefreshGameFetch';
}

class FetchSimilarGames extends GameEvent {
  final String gameIds;

  FetchSimilarGames(this.gameIds);


  @override
  String toString() => 'FetchSimilarGames';
}

class FetchVideos extends GameEvent {
  final String videoIds;

  FetchVideos(this.videoIds);


  @override
  String toString() => 'FetchVideos';
}