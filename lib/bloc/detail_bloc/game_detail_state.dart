import 'package:equatable/equatable.dart';
import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/models/videos.dart';

abstract class DetailGameState extends Equatable {
  DetailGameState([List props = const []]) : super(props);
}

class DetailGameError extends DetailGameState {
  @override
  String toString() => 'DetailGameError';
}


class GameDetail extends DetailGameState {
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

class SimilarGames extends DetailGameState {
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

class GameVideos extends DetailGameState {
  final List<Videos> videos;

  GameVideos({
    this.videos
  }) : super([videos]);

  factory GameVideos.initial() {
    return GameVideos(videos: null);
  }

  GameVideos copyWith({
    List<Videos> videos,
    bool hasReachedMax,
  }) {
    return GameVideos(
        videos: videos ?? this.videos
    );
  }

  @override
  String toString() =>
      'GameVideos { videos: ${videos.length} }';
}

