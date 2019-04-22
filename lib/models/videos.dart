import 'package:video_game_releases/models/association.dart';
import 'package:video_game_releases/models/image.dart';
import 'package:video_game_releases/models/video_show.dart';

class Videos {
  String apiDetailUrl;
  List<Association> associations;
  String deck;
  String highUrl;
  String lowUrl;
  String embedPlayer;
  String guid;
  int id;
  int lengthSeconds;
  String name;
  bool premium;
  DateTime publishDate;
  String siteDetailUrl;
  String url;
  Image image;
  String user;
  VideoType videoType;
  VideoShow videoShow;
  List<Association> videoCategories;
  dynamic savedTime;
  String youtubeId;

  Videos({
    this.apiDetailUrl,
    this.associations,
    this.deck,
    this.highUrl,
    this.lowUrl,
    this.embedPlayer,
    this.guid,
    this.id,
    this.lengthSeconds,
    this.name,
    this.premium,
    this.publishDate,
    this.siteDetailUrl,
    this.url,
    this.image,
    this.user,
    this.videoType,
    this.videoShow,
    this.videoCategories,
    this.savedTime,
    this.youtubeId,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => new Videos(
    apiDetailUrl: json["api_detail_url"] == null ? null : json["api_detail_url"],
    associations: json["associations"] == null ? null : new List<Association>.from(json["associations"].map((x) => Association.fromJson(x))),
    deck: json["deck"] == null ? null : json["deck"],
    highUrl: json["high_url"] == null ? null : json["high_url"],
    lowUrl: json["low_url"] == null ? null : json["low_url"],
    embedPlayer: json["embed_player"] == null ? null : json["embed_player"],
    guid: json["guid"] == null ? null : json["guid"],
    id: json["id"] == null ? null : json["id"],
    lengthSeconds: json["length_seconds"] == null ? null : json["length_seconds"],
    name: json["name"] == null ? null : json["name"],
    premium: json["premium"] == null ? null : json["premium"],
    publishDate: json["publish_date"] == null ? null : DateTime.parse(json["publish_date"]),
    siteDetailUrl: json["site_detail_url"] == null ? null : json["site_detail_url"],
    url: json["url"] == null ? null : json["url"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    user: json["user"] == null ? null : json["user"],
    videoType: json["video_type"] == null ? null : videoTypeValues.map[json["video_type"]],
    videoShow: json["video_show"] == null ? null : VideoShow.fromJson(json["video_show"]),
    videoCategories: json["video_categories"] == null ? null : new List<Association>.from(json["video_categories"].map((x) => Association.fromJson(x))),
    savedTime: json["saved_time"] == null ? null : json["saved_time"],
    youtubeId: json["youtube_id"] == null ? null : json["youtube_id"],
  );

  Map<String, dynamic> toJson() => {
    "api_detail_url": apiDetailUrl,
    "associations": new List<dynamic>.from(associations.map((x) => x.toJson())),
    "deck": deck,
    "high_url": highUrl,
    "low_url": lowUrl,
    "embed_player": embedPlayer,
    "guid": guid,
    "id": id,
    "length_seconds": lengthSeconds,
    "name": name,
    "premium": premium,
    "publish_date": publishDate.toIso8601String(),
    "site_detail_url": siteDetailUrl,
    "url": url,
    "image": image.toJson(),
    "user": user,
    "video_type": videoType == null ? null : videoTypeValues.reverse[videoType],
    "video_show": videoShow == null ? null : videoShow.toJson(),
    "video_categories": new List<dynamic>.from(videoCategories.map((x) => x.toJson())),
    "saved_time": savedTime,
    "youtube_id": youtubeId == null ? null : youtubeId,
  };
}