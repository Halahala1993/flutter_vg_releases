import 'package:equatable/equatable.dart';
import 'package:video_game_releases/models/game.dart';


abstract class GameState extends Equatable {
  GameState([List props = const []]) : super(props);
}

class GameUninitialized extends GameState {
  @override
  String toString() => 'GameUninitialized';
}

class GameError extends GameState {
  @override
  String toString() => 'GameError';
}

class GameLoaded extends GameState {
  final List<Game> games;
  final bool hasReachedMax;

  GameLoaded({
    this.games,
    this.hasReachedMax,
  }) : super([games, hasReachedMax]);

  GameLoaded copyWith({
    List<Game> games,
    bool hasReachedMax,
  }) {
    return GameLoaded(
      games: games ?? this.games,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() =>
      'GameLoaded { games: ${games.length}, hasReachedMax: $hasReachedMax }';
}