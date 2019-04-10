import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/models/image.dart';
import 'package:video_game_releases/models/platform.dart';
import 'package:video_game_releases/models/regions.dart';

class Releases {
    String apiDetailUrl;
    String dateAdded;
    String dateLastUpdated;
    dynamic deck;
    dynamic description;
    dynamic expectedReleaseDay;
    dynamic expectedReleaseMonth;
    dynamic expectedReleaseQuarter;
    dynamic expectedReleaseYear;
    Game game;
    dynamic gameRating;
    String guid;
    int id;
    Image image;
    int maximumPlayers;
    int minimumPlayers;
    String name;
    Platform platform;
    dynamic productCodeType;
    dynamic productCodeValue;
    Region region;
    String releaseDate;
    String siteDetailUrl;
    int widescreenSupport;

    Releases({
        this.apiDetailUrl,
        this.dateAdded,
        this.dateLastUpdated,
        this.deck,
        this.description,
        this.expectedReleaseDay,
        this.expectedReleaseMonth,
        this.expectedReleaseQuarter,
        this.expectedReleaseYear,
        this.game,
        this.gameRating,
        this.guid,
        this.id,
        this.image,
        this.maximumPlayers,
        this.minimumPlayers,
        this.name,
        this.platform,
        this.productCodeType,
        this.productCodeValue,
        this.region,
        this.releaseDate,
        this.siteDetailUrl,
        this.widescreenSupport,
    });

    factory Releases.fromJson(Map<String, dynamic> json) => new Releases(
        apiDetailUrl: json["api_detail_url"],
        dateAdded: json["date_added"],
        dateLastUpdated: json["date_last_updated"],
        deck: json["deck"],
        description: json["description"],
        expectedReleaseDay: json["expected_release_day"],
        expectedReleaseMonth: json["expected_release_month"],
        expectedReleaseQuarter: json["expected_release_quarter"],
        expectedReleaseYear: json["expected_release_year"],
        game: Game.fromJson(json["game"]),
        gameRating: json["game_rating"],
        guid: json["guid"],
        id: json["id"],
        image: Image.fromJson(json["image"]),
        maximumPlayers: json["maximum_players"],
        minimumPlayers: json["minimum_players"],
        name: json["name"],
        platform: Platform.fromJson(json["platform"]),
        productCodeType: json["product_code_type"],
        productCodeValue: json["product_code_value"],
        region: Region.fromJson(json["region"]),
        releaseDate: json["release_date"],
        siteDetailUrl: json["site_detail_url"],
        widescreenSupport: json["widescreen_support"],
    );

    Map<String, dynamic> toJson() => {
        "api_detail_url": apiDetailUrl,
        "date_added": dateAdded,
        "date_last_updated": dateLastUpdated,
        "deck": deck,
        "description": description,
        "expected_release_day": expectedReleaseDay,
        "expected_release_month": expectedReleaseMonth,
        "expected_release_quarter": expectedReleaseQuarter,
        "expected_release_year": expectedReleaseYear,
        "game": game.toJson(),
        "game_rating": gameRating,
        "guid": guid,
        "id": id,
        "image": image.toJson(),
        "maximum_players": maximumPlayers,
        "minimum_players": minimumPlayers,
        "name": name,
        "platform": platform.toJson(),
        "product_code_type": productCodeType,
        "product_code_value": productCodeValue,
        "region": region.toJson(),
        "release_date": releaseDate,
        "site_detail_url": siteDetailUrl,
        "widescreen_support": widescreenSupport,
    };
}