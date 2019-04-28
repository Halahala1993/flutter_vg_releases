import 'package:meta/meta.dart';
import 'package:video_game_releases/models/character.dart';
import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/models/videos.dart';
import 'package:video_game_releases/repositories/giant_bomb_api_client.dart';

class GiantBombRepository {

  final GiantBombApiClient giantBombApiClient;
  
  GiantBombRepository({@required this.giantBombApiClient}) : assert(giantBombApiClient != null);

  Future<List<Game>> getListOfRecentGameReleases(int startIndex, int limit) async {
    print("Retrieving game list");
    return await giantBombApiClient.getListOfRecentGameReleases(startIndex, limit, false);
  }

  Future<List<Game>> getListOfRecentGameReleasesFiltered(int startIndex, int limit) async {
    print("Retrieving game list filtered");
    return await giantBombApiClient.getListOfRecentGameReleases(startIndex, limit, true);
  }

  Future<Game> retrieveGameDetailsByGameId(int gameId) async {
    print("Retrieving game detail");
    return await giantBombApiClient.retrieveGameDetailsByGameId(gameId);
  }

  Future<List<Game>> retrieveSimilarGamesWithIds(String gameIds) async {
    print("Retrieving similar games");
    return await giantBombApiClient.retrieveSimilarGamesWithIds(gameIds);
  }

  Future<List<Videos>> retrieveGameVideosWithIds(String videoIds) async {
    print("Retrieving game videos");
    return await giantBombApiClient.retrieveGameVideosWithIds(videoIds);
  }

  Future<List<Character>> retrieveGameCharactersWithIds(String videoIds) async {
    print("Retrieving game videos");
    return await giantBombApiClient.retrieveGameCharactersWithIds(videoIds);
  }

}