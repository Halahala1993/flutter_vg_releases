
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_game_releases/bloc/bloc.dart';
import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/repositories/giant_bomb_api_client.dart';
import 'package:video_game_releases/repositories/giant_bomb_repository.dart';
import 'package:video_game_releases/utils/dio.dart';

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
    } else if  (event is FetchGameDetail) {
      yield* _mapGameDetail(event);
    } else if (event is RefreshGameFetch) {
      yield* _mapRefreshGameList();
    } else if (event is FetchFilteredList) {
      yield* _mapFilteredGames();
    } else if (event is FetchSimilarGames) {
      yield* _mapSimilarGameList(event);
    } else if (event is FetchVideos) {
      yield* _mapGameVideosList(event);
    }
  }

  Stream<GameState> _mapSimilarGameList(FetchSimilarGames similarEvent) async* {
    try {

      final games = await giantBombRepository.retrieveSimilarGamesWithIds(similarEvent.gameIds);
      yield SimilarGames(games: games);
      return;

    } catch (_) {
      print("Error retrieiving similar games: " + _.toString());

      yield GameError();
    }
  }

  Stream<GameState> _mapGameVideosList(FetchVideos videoEvent) async* {
    try {

      final videos = await giantBombRepository.retrieveGameVideosWithIds(videoEvent.videoIds);
      yield GameVideos(videos: videos);
      return;

    } catch (_) {
      print("Error retrieiving game videos: " + _.toString());
      yield GameError();
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

  Stream<GameState> _mapGameDetail(FetchGameDetail detailEvent) async* {

    try {
      final Game game = await giantBombRepository.retrieveGameDetailsByGameId(detailEvent.gameId);
      yield GameDetail(game: game);
      return;
    } catch (_) {
      print("Error while retrieving detail: " + _.toString());
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