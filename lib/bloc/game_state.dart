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

   factory GameLoaded.initial() {
    return GameLoaded(games: null, hasReachedMax: false);
  }

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

class GameFiltered extends GameState {
  final List<Game> games;
  final bool hasReachedMax;

  GameFiltered({
    this.games,
    this.hasReachedMax,
  }) : super([games, hasReachedMax]);

   factory GameFiltered.initial() {
    return GameFiltered(games: null, hasReachedMax: false);
  }

  GameFiltered copyWith({
    List<Game> games,
    bool hasReachedMax,
  }) {
    return GameFiltered(
      games: games ?? this.games,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() =>
      'GameFiltered { games: ${games.length}, hasReachedMax: $hasReachedMax }';
}

class GameDetail extends GameState {
  final Game game;

  GameDetail({
    this.game
  }) : super([game]);

  factory GameDetail.initial() {
    return GameDetail(game: null);
  }

  GameDetail copyWith({
    Game game
  }) {
    return GameDetail(
      game: game ?? this.game
    );
  }

  @override
  String toString() =>
      'GameDetail { gameId: ${game.id} }';
}

class SimilarGames extends GameState {
  final List<Game> games;

  SimilarGames({
    this.games
  }) : super([games]);

  factory SimilarGames.initial() {
    return SimilarGames(games: null);
  }

  SimilarGames copyWith({
    List<Game> games,
    bool hasReachedMax,
  }) {
    return SimilarGames(
      games: games ?? this.games
    );
  }

  @override
  String toString() =>
      'SimilarGames { games: ${games.length} }';
}