import 'package:video_game_releases/models/enums.dart';

class Platform {
    String apiDetailUrl;
    int id;
    Name name;
    String siteDetailUrl;
    Abbreviation abbreviation;

    Platform({
        this.apiDetailUrl,
        this.id,
        this.name,
        this.siteDetailUrl,
        this.abbreviation,
    });

    factory Platform.fromJson(Map<String, dynamic> json) => new Platform(
        apiDetailUrl: json["api_detail_url"] == null ? null : json["api_detail_url"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : nameValues.map[json["name"]],
        siteDetailUrl: json["site_detail_url"] == null ? null : json["site_detail_url"],
        abbreviation: json["abbreviation"] == null ? null : abbreviationValues.map[json["abbreviation"]],
    );

    Map<String, dynamic> toJson() => {
        "api_detail_url": apiDetailUrl,
        "id": id,
        "name": nameValues.reverse[name],
        "site_detail_url": siteDetailUrl,
        "abbreviation": abbreviationValues.reverse[abbreviation],
    };
}