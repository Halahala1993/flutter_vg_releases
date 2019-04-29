
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_game_releases/bloc/bloc.dart';
import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/repositories/giant_bomb_api_client.dart';
import 'package:video_game_releases/repositories/giant_bomb_repository.dart';
import 'package:video_game_releases/utils/dio.dart';
import 'package:video_game_releases/utils/filters.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  //final http.Client httpClient;
  final dio = GameDio();
  final GiantBombRepository giantBombRepository = GiantBombRepository(
    giantBombApiClient: GiantBombApiClient()
  );

  GameBloc();

  @override
  GameState get initialState => GameUninitialized();
  
  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      yield* _mapLoadGames();
    } else if (event is RefreshGameFetch) {
      yield* _mapRefreshGameList();
    } else if (event is FetchFilteredList) {
      yield* _mapFilteredGames();
    } else if (event is FetchSearchResults) {
      yield* _mapSearchedGames(event);
    }
  }

  Stream<GameState> _mapRefreshGameList() async* {

    try {

      if (currentState is GameUninitialized || (currentState is GameLoaded && (currentState as GameLoaded).games.length == 0)) {
        (currentState as GameLoaded).games.clear();
        final games = await giantBombRepository.getListOfRecentGameReleases(0, 20);
        yield GameLoaded(games: games, hasReachedMax: false);
        return;
      }
      if (currentState is GameLoaded) {
        (currentState as GameLoaded).games.clear();
        yield* _mapLoadGames();
      }

      if (currentState is GameFiltered) {
        (currentState as GameFiltered).games.clear();
        yield* _mapFilteredGames();
      }
    } catch (_) {
      print("Error while refreshing game list: " + _.toString());

      yield GameError();
    }
  }

  Stream<GameState> _mapLoadGames() async* {
    try {

      if (currentState is GameUninitialized) {
        final games = await giantBombRepository.getListOfRecentGameReleases(0, 20);
        yield GameLoaded(games: games, hasReachedMax: false);
        return;
      }

      if (currentState is GameFiltered) {

        (currentState as GameFiltered).games.clear();

        final games = await giantBombRepository.getListOfRecentGameReleases(0, 20);
        yield GameLoaded(games: games, hasReachedMax: false);
        return;
      }

      if (currentState is GameSearched) {

        (currentState as GameSearched).games.clear();

        final games = await giantBombRepository.getListOfRecentGameReleases(0, 20);
        yield GameLoaded(games: games, hasReachedMax: false);
        return;
      }

      if (currentState is GameLoaded) {
        final games =
            await giantBombRepository.getListOfRecentGameReleases((currentState as GameLoaded).games.length, 20);
        yield games.isEmpty
            ? (currentState as GameLoaded).copyWith(hasReachedMax: true)
            : GameLoaded(
                games: (currentState as GameLoaded).games + games,
                hasReachedMax: false,
              );
      }
    } catch (_) {
      print("Error while retrieveing games: " + _.toString());
      yield GameError();
    }
  }

  Stream<GameState> _mapFilteredGames() async* {
    try {

        if (currentState is GameLoaded) {
          (currentState as GameLoaded).games.clear();
          final games = await giantBombRepository.getListOfRecentGameReleasesFiltered(0, 20);
          yield GameFiltered(games: games, hasReachedMax: false);
          return;
        }
        if (currentState is GameFiltered) {
          final games =
              await giantBombRepository.getListOfRecentGameReleasesFiltered((currentState as GameFiltered).games.length, 20);
          yield games.isEmpty
              ? (currentState as GameFiltered).copyWith(hasReachedMax: true)
              : GameFiltered(
                  games: (currentState as GameFiltered).games + games,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
      print("Error while filtering games: " + _.toString());
      yield GameError();
      }
  }

  Stream<GameState> _mapSearchedGames(FetchSearchResults searchEvent) async* {

    String query = searchEvent.searchQuery;

    try {

      if (currentState is GameLoaded) {

        (currentState as GameLoaded).games.clear();
        final games = await giantBombRepository.getGamesSearchResults(0, 10, query);
        yield GameSearched(games: games, hasReachedMax: false);
        return;
      }
      if (currentState is GameFiltered) {

        (currentState as GameFiltered).games.clear();
        final games = await giantBombRepository.getGamesSearchResults(0, 10, query);
        yield GameSearched(games: games, hasReachedMax: false);
        return;
      }

      if (currentState is GameSearched) {

        var tempGames;
        if ((currentState as GameSearched).games != null && (currentState as GameSearched).games.isNotEmpty) {
          tempGames = (currentState as GameSearched).games;
        } else if ((currentState as GameFiltered).games != null && (currentState as GameFiltered).games.isNotEmpty) {
          tempGames = (currentState as GameFiltered).games;
        } else {
          tempGames = (currentState as GameLoaded).games;
        }

        final games = await giantBombRepository.getGamesSearchResults(tempGames.length, 10, query);
        yield games.isEmpty ? (currentState as GameSearched).copyWith(hasReachedMax: true)
            : GameSearched(
          games: (currentState as GameSearched).games + games,
          hasReachedMax: false,
        );
      }
    } catch (_) {
      print("Error while filtering games: " + _.toString());
      yield GameError();
    }
  }

  bool _hasReachedMax(GameState state) =>
      state is GameLoaded && state.hasReachedMax;

  @override
  Stream<GameEvent> transform(Stream<GameEvent> events) {
    return (events as Observable<GameEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
  }

}