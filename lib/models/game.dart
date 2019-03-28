import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:video_game_releases/models/image.dart';
import 'package:video_game_releases/models/image_tag.dart';
import 'package:video_game_releases/models/original_game_rating.dart';
import 'package:video_game_releases/models/platform.dart';

class Game {
    String aliases;
    String apiDetailUrl;
    String dateAdded;
    String dateLastUpdated;
    String deck;
    String description;
    dynamic expectedReleaseDay;
    dynamic expectedReleaseMonth;
    dynamic expectedReleaseQuarter;
    dynamic expectedReleaseYear;
    String guid;
    int id;
    Image image;
    List<ImageTag> imageTags;
    String name;
    int numberOfUserReviews;
    List<OriginalGameRating> originalGameRating;
    String originalReleaseDate;
    List<Platform> platforms;
    String siteDetailUrl;

    Game({
        this.aliases,
        this.apiDetailUrl,
        this.dateAdded,
        this.dateLastUpdated,
        this.deck,
        this.description,
        this.expectedReleaseDay,
        this.expectedReleaseMonth,
        this.expectedReleaseQuarter,
        this.expectedReleaseYear,
        this.guid,
        this.id,
        this.image,
        this.imageTags,
        this.name,
        this.numberOfUserReviews,
        this.originalGameRating,
        this.originalReleaseDate,
        this.platforms,
        this.siteDetailUrl,
    });

    factory Game.fromJson(Map<String, dynamic> json) => new Game(
        aliases: json["aliases"] == null ? null : json["aliases"],
        apiDetailUrl: json["api_detail_url"],
        dateAdded: json["date_added"],
        dateLastUpdated: json["date_last_updated"],
        deck: json["deck"] == null ? null : json["deck"],
        description: json["description"] == null ? "No description Available" : json["description"].toString().substring(
            json['description'].toString().indexOf("<p>") + 3, 
            json['description'].toString().indexOf("</p>")
        ),
        expectedReleaseDay: json["expected_release_day"],
        expectedReleaseMonth: json["expected_release_month"],
        expectedReleaseQuarter: json["expected_release_quarter"],
        expectedReleaseYear: json["expected_release_year"],
        guid: json["guid"],
        id: json["id"],
        image: Image.fromJson(json["image"]),
        imageTags: new List<ImageTag>.from(json["image_tags"].map((x) => ImageTag.fromJson(x))),
        name: json["name"],
        numberOfUserReviews: json["number_of_user_reviews"],
        originalGameRating: json["original_game_rating"] == null ? null : new List<OriginalGameRating>.from(json["original_game_rating"].map((x) => OriginalGameRating.fromJson(x))),
        originalReleaseDate: json["original_release_date"],
        platforms: json["platforms"] == null ? null : new List<Platform>.from(json["platforms"].map((x) => Platform.fromJson(x))),
        siteDetailUrl: json["site_detail_url"],
    );

    Map<String, dynamic> toJson() => {
        "aliases": aliases == null ? null : aliases,
        "api_detail_url": apiDetailUrl,
        "date_added": dateAdded,
        "date_last_updated": dateLastUpdated,
        "deck": deck == null ? null : deck,
        "description": description == null ? null : description,
        "expected_release_day": expectedReleaseDay,
        "expected_release_month": expectedReleaseMonth,
        "expected_release_quarter": expectedReleaseQuarter,
        "expected_release_year": expectedReleaseYear,
        "guid": guid,
        "id": id,
        "image": image.toJson(),
        "image_tags": new List<dynamic>.from(imageTags.map((x) => x.toJson())),
        "name": name,
        "number_of_user_reviews": numberOfUserReviews,
        "original_game_rating": originalGameRating == null ? null : new List<dynamic>.from(originalGameRating.map((x) => x.toJson())),
        "original_release_date": originalReleaseDate,
        "platforms": platforms == null ? null : new List<dynamic>.from(platforms.map((x) => x.toJson())),
        "site_detail_url": siteDetailUrl,
    };
}