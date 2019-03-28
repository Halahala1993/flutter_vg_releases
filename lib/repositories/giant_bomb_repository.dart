import 'package:meta/meta.dart';
import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/repositories/giant_bomb_api_client.dart';

class GiantBombRepository {

  final GiantBombApiClient giantBombApiClient;
  
  GiantBombRepository({@required this.giantBombApiClient}) : assert(giantBombApiClient != null);

  Future<List<Game>> getListOfRecentGameReleases(int startIndex, int limit) async {
    return await giantBombApiClient.getListOfRecentGameReleases(startIndex, limit);
  }
  
}