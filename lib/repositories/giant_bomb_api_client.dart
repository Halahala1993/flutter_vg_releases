import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/models/giant_bomb_response.dart';
import 'package:video_game_releases/models/releases.dart';
import 'package:video_game_releases/utils/app_preferences.dart';
import 'package:video_game_releases/utils/constants.dart';
import 'package:video_game_releases/utils/date_util.dart';
import 'package:video_game_releases/utils/dio.dart';
import 'package:video_game_releases/utils/filters.dart';

class GiantBombApiClient {
  final dio = GameDio();
  String apiKey = "";
  // String apiKey = "";

  GiantBombApiClient() {
    getGBApiKey();
  }

  getGBApiKey() {
    AppPreferences.getGBApiKey().then((apiKey) {
      this.apiKey = apiKey;  
    });
  }

  Future<List<Game>> getListOfRecentGameReleases(int startIndex, int limit, bool filtered) async {

    String filters;
    if (filtered) {
      filters = DateUtil.retrieveDateFilter() + Filters.getFilters();
    } else {
      Filters.clear();
      filters = DateUtil.retrieveDateFilter();
    }

    final String url = 'games/?format=json&' +
        'filter=$filters&' +
        'sort=original_release_date:asc&' +
        'limit=$limit&' +
        'offset=$startIndex&' +
        'api_key=$apiKey';

    print("Generate URL: " + url);

    //final localTestUrl = "https://api.myjson.com/bins/1gptqa";

    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final data = response.data;
      List<Game> games = new List<Game>();
      GiantBombResponse giantBombResponse = GiantBombResponse.fromJson(data);

      games = giantBombResponse.results;

      return games;

    } else {
      throw Exception('error fetching games');
    }
  }

  Future<Game> retrieveGameDetailsByGameId(int gameId) async {

    final reponse = await dio.get("game/$gameId/?api_key=$apiKey");

    if (reponse.statusCode == 200) {
      final Game game = reponse.data;

      return game;
    } else {
      throw Exception("Error while retrieving game with id: $gameId");
    }

  }
}