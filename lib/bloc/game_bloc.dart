import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_game_releases/bloc/bloc.dart';
import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/utils/dio.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  //final http.Client httpClient;
  final dio = GameDio();
  GameBloc();

  @override
  GameState get initialState => GameUninitialized();
  
  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is GameUninitialized) {
          final games = await _fetchGames(0, 20);
          yield GameLoaded(games: games, hasReachedMax: false);
          return;
        }
        if (currentState is GameLoaded) {
          final games =
              await _fetchGames((currentState as GameLoaded).games.length, 20);
          yield games.isEmpty
              ? (currentState as GameLoaded).copyWith(hasReachedMax: true)
              : GameLoaded(
                  games: (currentState as GameLoaded).games + games,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield GameError();
      }
    }
  }

  bool _hasReachedMax(GameState state) =>
      state is GameLoaded && state.hasReachedMax;

  Future<List<Game>> _fetchGames(int startIndex, int limit) async {
    final response = await dio.get(
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');
    if (response.statusCode == 200) {
      final data = response.data;
      List<Game> games = new List<Game>();

      if (data != null) {
       data.forEach((it) => games.add(Game.fromJson(it)));
      } else {
        print("Retrieved nothing from Ombi");
      }

      return games;
    } else {
      throw Exception('error fetching games');
    }
  }

  @override
  Stream<GameEvent> transform(Stream<GameEvent> events) {
    return (events as Observable<GameEvent>)
        .debounce(Duration(milliseconds: 500));
  }

}