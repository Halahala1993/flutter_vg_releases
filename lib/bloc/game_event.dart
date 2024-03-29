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

class FetchSearchResults extends GameEvent {
  final String searchQuery;

  FetchSearchResults({@required this.searchQuery});

  @override
  String toString() => 'FetchSearchResults';
}

class RefreshGameFetch extends GameEvent {
  final List<Game> games;

  RefreshGameFetch({@required this.games}) : assert (games != null), super ([games]);


  @override
  String toString() => 'RefreshGameFetch';
}