
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_game_releases/bloc/bloc.dart';
import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/repositories/giant_bomb_api_client.dart';
import 'package:video_game_releases/repositories/giant_bomb_repository.dart';
import 'package:video_game_releases/utils/dio.dart';

class DetailGameBloc extends Bloc<DetailGameEvent, DetailGameState> {
  //final http.Client httpClient;
  final dio = GameDio();
  final GiantBombRepository giantBombRepository = GiantBombRepository(
      giantBombApiClient: GiantBombApiClient()
  );

  DetailGameBloc();

  @override
  DetailGameState get initialState => GameDetail.initial();

  @override
  Stream<DetailGameState> mapEventToState(DetailGameEvent event) async* {
    if  (event is FetchGameDetail) {
      yield* _mapGameDetail(event);
    } else if (event is FetchSimilarGames) {
      yield* _mapSimilarGameList(event);
    } else if (event is FetchVideos) {
      yield* _mapGameVideosList(event);
    }
  }

  Stream<DetailGameState> _mapSimilarGameList(FetchSimilarGames similarEvent) async* {
    try {

      final games = await giantBombRepository.retrieveSimilarGamesWithIds(similarEvent.gameIds);
      yield SimilarGames(games: games);
      return;

    } catch (_) {
      print("Error retrieiving similar games: " + _.toString());

      yield DetailGameError();
    }
  }

  Stream<DetailGameState> _mapGameVideosList(FetchVideos videoEvent) async* {
    try {

      final videos = await giantBombRepository.retrieveGameVideosWithIds(videoEvent.videoIds);
      yield GameVideos(videos: videos);
      return;

    } catch (_) {
      print("Error retrieiving game videos: " + _.toString());
      yield DetailGameError();
    }
  }

  Stream<DetailGameState> _mapGameDetail(FetchGameDetail detailEvent) async* {

    try {
      final Game game = await giantBombRepository.retrieveGameDetailsByGameId(detailEvent.gameId);
      yield GameDetail(game: game);
      return;
    } catch (_) {
      print("Error while retrieving detail: " + _.toString());
      yield DetailGameError();
    }
  }

  @override
  Stream<DetailGameEvent> transform(Stream<DetailGameEvent> events) {
    return (events as Observable<DetailGameEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
  }

}