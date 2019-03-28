import 'package:dio/dio.dart';
import 'package:video_game_releases/utils/app_preferences.dart';
import 'package:video_game_releases/utils/constants.dart';

class GameDio extends Dio{
  static final GameDio _singleton = new GameDio._internal();

  factory GameDio() {
    return _singleton;
  }

  GameDio._internal() {
    options.baseUrl = "https://www.giantbomb.com/api/";
  }
}