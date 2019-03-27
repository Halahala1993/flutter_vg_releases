import 'package:dio/dio.dart';

class GameDio extends Dio{
  static Dio dio;
  static final GameDio _singleton = new GameDio._internal();

  factory GameDio() {
    return _singleton;
  }

  GameDio._internal() {
    dio = new Dio();
    //dio.options.headers = {"content-type": "application/json"};
  }
}