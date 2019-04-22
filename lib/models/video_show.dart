import 'package:video_game_releases/models/image.dart';

class VideoShow {
  String apiDetailUrl;
  int id;
  String title;
  int position;
  String siteDetailUrl;
  Image image;

  VideoShow({
    this.apiDetailUrl,
    this.id,
    this.title,
    this.position,
    this.siteDetailUrl,
    this.image,
  });

  factory VideoShow.fromJson(Map<String, dynamic> json) => new VideoShow(
    apiDetailUrl: json["api_detail_url"],
    id: json["id"],
    title: json["title"],
    position: json["position"],
    siteDetailUrl: json["site_detail_url"],
    image: Image.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "api_detail_url": apiDetailUrl,
    "id": id,
    "title": title,
    "position": position,
    "site_detail_url": siteDetailUrl,
    "image": image.toJson(),
  };
}

enum VideoType { BEST_OF_GIANT_BOMB, QUICK_LOOKS, FEATURES, UNFINISHED, GIANT_BOMBCAST, OLD_GAMES, FEATURES_UNFINISHED }

final videoTypeValues = new EnumValues({
  "Best of Giant Bomb": VideoType.BEST_OF_GIANT_BOMB,
  "Features": VideoType.FEATURES,
  "Features, Unfinished": VideoType.FEATURES_UNFINISHED,
  "Giant Bombcast": VideoType.GIANT_BOMBCAST,
  "Old Games": VideoType.OLD_GAMES,
  "Quick Looks": VideoType.QUICK_LOOKS,
  "Unfinished": VideoType.UNFINISHED
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}