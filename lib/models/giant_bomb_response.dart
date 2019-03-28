import 'package:video_game_releases/models/game.dart';

class GiantBombResponse {
    String error;
    int limit;
    int offset;
    int numberOfPageResults;
    int numberOfTotalResults;
    int statusCode;
    List<Game> games;
    String version;

    GiantBombResponse({
        this.error,
        this.limit,
        this.offset,
        this.numberOfPageResults,
        this.numberOfTotalResults,
        this.statusCode,
        this.games,
        this.version,
    });

    factory GiantBombResponse.fromJson(Map<String, dynamic> json) => new GiantBombResponse(
        error: json["error"],
        limit: json["limit"],
        offset: json["offset"],
        numberOfPageResults: json["number_of_page_results"],
        numberOfTotalResults: json["number_of_total_results"],
        statusCode: json["status_code"],
        games: new List<Game>.from(json["results"].map((x) => Game.fromJson(x))),
        version: json["version"],
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "limit": limit,
        "offset": offset,
        "number_of_page_results": numberOfPageResults,
        "number_of_total_results": numberOfTotalResults,
        "status_code": statusCode,
        "games": new List<dynamic>.from(games.map((x) => x.toJson())),
        "version": version,
    };
}