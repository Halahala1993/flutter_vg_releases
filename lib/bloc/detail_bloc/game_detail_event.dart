import 'package:equatable/equatable.dart';

abstract class DetailGameEvent extends Equatable {
  DetailGameEvent([List props = const []]) : super(props);
}

class FetchGameDetail extends DetailGameEvent {
  final int gameId;

  FetchGameDetail(this.gameId);


  @override
  String toString() => 'FetchGameDetail';
}

class FetchSimilarGames extends DetailGameEvent {
  final String gameIds;

  FetchSimilarGames(this.gameIds);


  @override
  String toString() => 'FetchSimilarGames';
}

class FetchVideos extends DetailGameEvent {
  final String videoIds;

  FetchVideos(this.videoIds);


  @override
  String toString() => 'FetchVideos';
}