import 'package:video_game_releases/models/image.dart';
import 'package:video_game_releases/models/image_tag.dart';


class Character {
  String aliases;
  String apiDetailUrl;
  String birthday;
  DateTime dateAdded;
  DateTime dateLastUpdated;
  String deck;
  String description;
  dynamic firstAppearedInGame;
  int gender;
  String guid;
  int id;
  Images image;
  List<ImageTag> imageTags;
  dynamic lastName;
  String name;
  String realName;
  String siteDetailUrl;

  Character({
    this.aliases,
    this.apiDetailUrl,
    this.birthday,
    this.dateAdded,
    this.dateLastUpdated,
    this.deck,
    this.description,
    this.firstAppearedInGame,
    this.gender,
    this.guid,
    this.id,
    this.image,
    this.imageTags,
    this.lastName,
    this.name,
    this.realName,
    this.siteDetailUrl,
  });

  factory Character.fromJson(Map<String, dynamic> json) => new Character(
    aliases: json["aliases"] == null ? null : json["aliases"],
    apiDetailUrl: json["api_detail_url"],
    birthday: json["birthday"] == null ? null : json["birthday"],
    dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
    dateLastUpdated: json["date_last_updated"] == null ? null : DateTime.parse(json["date_last_updated"]),
    deck: json["deck"] == null ? null : json["deck"],
    description: json["description"] == null ? null : json["description"],
    firstAppearedInGame: json["first_appeared_in_game"],
    gender: json["gender"] == null ? null : json["gender"],
    guid: json["guid"] == null ? null : json["guid"],
    id: json["id"] == null ? null : json["id"],
    image: json["image"] == null ? null : Images.fromJson(json["image"]),
    imageTags: json["image_tags"] == null ? null :  new List<ImageTag>.from(json["image_tags"].map((x) => ImageTag.fromJson(x))),
    lastName: json["last_name"] == null ? null :  json["last_name"],
    name: json["name"] == null ? null :  json["name"],
    realName: json["real_name"] == null ? null : json["real_name"],
    siteDetailUrl: json["site_detail_url"] == null ? null :  json["site_detail_url"],
  );

  Map<String, dynamic> toJson() => {
    "aliases": aliases == null ? null : aliases,
    "api_detail_url": apiDetailUrl,
    "birthday": birthday == null ? null : birthday,
    "date_added": dateAdded.toIso8601String(),
    "date_last_updated": dateLastUpdated.toIso8601String(),
    "deck": deck == null ? null : deck,
    "description": description == null ? null : description,
    "first_appeared_in_game": firstAppearedInGame.toJson(),
    "gender": gender,
    "guid": guid,
    "id": id,
    "image": image.toJson(),
    "image_tags": new List<dynamic>.from(imageTags.map((x) => x.toJson())),
    "last_name": lastName,
    "name": name,
    "real_name": realName == null ? null : realName,
    "site_detail_url": siteDetailUrl,
  };
}