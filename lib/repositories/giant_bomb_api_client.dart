import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:video_game_releases/models/character.dart';
import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/models/giant_bomb_response.dart';
import 'package:video_game_releases/models/releases.dart';
import 'package:video_game_releases/models/videos.dart';
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

    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final data = response.data;

      List<Game> games = new List<Game>.from(data["results"].map((x) => Game.fromJson(x)));

      return games;

    } else {
      throw Exception('error fetching games');
    }
  }

  Future<List<Game>> getGamesSearchResults(int pageOffset, int limit, String query) async {

    int tmp = int.parse(pageOffset.toString().substring(0, 1));
    tmp++;

    String page = tmp.toString().substring(0, 1);

    final String url = 'search/?format=json&' +
        'query=$query&' +
        'sort=original_release_date:desc&' +
        'limit=$limit&' +
        'page=$page&' +
        'resources=game&' +
        'api_key=$apiKey';

    print("Generate URL: " + url);

    final response = await dio.get(url);
    if (response.statusCode == 200) {

      final data = response.data;
      List<Game> games = new List<Game>.from(data["results"].map((x) => Game.fromJson(x)));

      return games;

    } else {
      throw Exception('error fetching games');
    }
  }

  Future<Game> retrieveGameDetailsByGameId(int gameId) async {

    final response = await dio.get("game/$gameId/?format=json&api_key=$apiKey");

    if (response.statusCode == 200) {

      GiantBombResponse giantBombResponse = GiantBombResponse.fromJson(response.data);

      Game game = giantBombResponse.results[0];

      return game;
    } else {
      throw Exception("Error while retrieving game with id: $gameId");
    }

  }

  Future<List<Game>> retrieveSimilarGamesWithIds(String gameIds) async {

    final response = await dio.get("games/?format=json&filter=id:$gameIds&api_key=$apiKey");

    if (response.statusCode == 200) {

      final data = response.data;
      List<Game> games = new List<Game>();
      GiantBombResponse giantBombResponse = GiantBombResponse.fromJson(data);

      games = giantBombResponse.results;
      print("Similar games returned: " + games.length.toString());


      return games;

    } else {
      throw Exception("Error while retrieving game with ids: $gameIds");
    }

  }

  Future<List<Videos>> retrieveGameVideosWithIds(String videoIds) async {

    final response = await dio.get("videos/?format=json&filter=id:$videoIds&api_key=$apiKey");

    if (response.statusCode == 200) {

      final data = response.data;
      List<Videos> videos = new List<Videos>.from(data["results"].map((x) => Videos.fromJson(x)));

      print("Similar videos returned: " + videos.length.toString());

      return videos;

    } else {
      throw Exception("Error while retrieving game with ids: $videoIds");
    }

  }

  Future<List<Character>> retrieveGameCharactersWithIds(String characterIds) async {

    final response = await dio.get("characters/?format=json&filter=id:$characterIds&api_key=$apiKey");

    if (response.statusCode == 200) {

      final data = response.data;
      List<Character> characters = new List<Character>.from(data["results"].map((x) => Character.fromJson(x)));

      print("Characters returned: " + characters.length.toString());

      return characters;

    } else {
      throw Exception("Error while retrieving game with ids: $characterIds");
    }

  }
}