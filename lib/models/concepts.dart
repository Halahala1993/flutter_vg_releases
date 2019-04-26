import 'package:video_game_releases/models/first_appeared_in.dart';
import 'package:video_game_releases/models/image.dart';
import 'package:video_game_releases/models/image_tag.dart';

class Concepts {
  String aliases;
  String apiDetailUrl;
  DateTime dateAdded;
  DateTime dateLastUpdated;
  String deck;
  String description;
  FirstAppearedIn firstAppearedInFranchise;
  FirstAppearedIn firstAppearedInGame;
  String guid;
  int id;
  Images image;
  List<ImageTag> imageTags;
  String name;
  String siteDetailUrl;

  Concepts({
    this.aliases,
    this.apiDetailUrl,
    this.dateAdded,
    this.dateLastUpdated,
    this.deck,
    this.description,
    this.firstAppearedInFranchise,
    this.firstAppearedInGame,
    this.guid,
    this.id,
    this.image,
    this.imageTags,
    this.name,
    this.siteDetailUrl,
  });

  factory Concepts.fromJson(Map<String, dynamic> json) => new Concepts(
    aliases: json["aliases"] == null ? null : json["aliases"],
    apiDetailUrl: json["api_detail_url"] == null ? null : json["api_detail_url"],
    dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
    dateLastUpdated: json["date_last_updated"] == null ? null : DateTime.parse(json["date_last_updated"]),
    deck: json["deck"] == null ? null : json["deck"],
    description: json["description"] == null ? null : json["description"],
    firstAppearedInFranchise: json["first_appeared_in_franchise"] == null ? null : FirstAppearedIn.fromJson(json["first_appeared_in_franchise"]),
    firstAppearedInGame: json["first_appeared_in_game"] == null ? null : FirstAppearedIn.fromJson(json["first_appeared_in_game"]),
    guid: json["guid"] == null ? null : json["guid"],
    id: json["id"] == null ? null : json["id"],
    image: json["image"] == null ? null : Images.fromJson(json["image"]),
    imageTags: json["image_tags"] == null ? null : new List<ImageTag>.from(json["image_tags"].map((x) => ImageTag.fromJson(x))),
    name: json["name"] == null ? null : json["name"],
    siteDetailUrl: json["site_detail_url"] == null ? null : json["site_detail_url"],
  );

  Map<String, dynamic> toJson() => {
    "aliases": aliases == null ? null : aliases,
    "api_detail_url": apiDetailUrl,
    "date_added": dateAdded.toIso8601String(),
    "date_last_updated": dateLastUpdated.toIso8601String(),
    "deck": deck,
    "description": description == null ? null : description,
    "first_appeared_in_franchise": firstAppearedInFranchise == null ? null : firstAppearedInFranchise.toJson(),
    "first_appeared_in_game": firstAppearedInGame.toJson(),
    "guid": guid,
    "id": id,
    "image": image.toJson(),
    "image_tags": new List<dynamic>.from(imageTags.map((x) => x.toJson())),
    "name": name,
    "site_detail_url": siteDetailUrl,
  };
}