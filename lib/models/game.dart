import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:video_game_releases/models/character.dart';
import 'package:video_game_releases/models/concepts.dart';
import 'package:video_game_releases/models/first_appeared_in.dart';
import 'package:video_game_releases/models/image.dart';
import 'package:video_game_releases/models/image_tag.dart';
import 'package:video_game_releases/models/original_game_rating.dart';
import 'package:video_game_releases/models/platform.dart';
import 'package:video_game_releases/models/videos.dart';

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
    Images image;
    List<ImageTag> imageTags;
    String name;
    int numberOfUserReviews;
    List<OriginalGameRating> originalGameRating;
    String originalReleaseDate;
    List<Platform> platforms;
    String siteDetailUrl;
    List<Images> images;
    List<Videos> videos;
    List<Character> characters;
    List<Concepts> concepts;
    List<Character> developers;
    List<FirstAppearedIn> firstAppearanceCharacters;
    List<FirstAppearedIn> firstAppearanceConcepts;
    List<FirstAppearedIn> firstAppearanceLocations;
    dynamic firstAppearanceObjects;
    List<FirstAppearedIn> firstAppearancePeople;
    List<Character> franchises;
    List<Character> genres;
    dynamic killedCharacters;
    List<Character> locations;
    List<Character> objects;
    List<Character> people;
    List<Character> publishers;
    List<Character> releases;
    List<Game> similarGames;
    List<Character> themes;

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
        this.images,
        this.videos,
        this.characters,
        this.concepts,
        this.developers,
        this.firstAppearanceCharacters,
        this.firstAppearanceConcepts,
        this.firstAppearanceLocations,
        this.firstAppearanceObjects,
        this.firstAppearancePeople,
        this.franchises,
        this.genres,
        this.killedCharacters,
        this.locations,
        this.objects,
        this.people,
        this.publishers,
        this.releases,
        this.similarGames,
        this.themes,
    });

    factory Game.fromJson(Map<String, dynamic> json) => new Game(
        aliases: json["aliases"] == null ? null : json["aliases"],
        apiDetailUrl: json["api_detail_url"] == null ? null : json["api_detail_url"],
        dateAdded: json["date_added"] == null ? null : json["date_added"],
        dateLastUpdated: json["date_last_updated"] == null ? null : json["date_last_updated"],
        deck: json["deck"] == null ? null : json["deck"],
        description: json["description"] == null ? "No description Available" : json["description"],
        expectedReleaseDay: json["expected_release_day"] == null ? null : json["expected_release_day"],
        expectedReleaseMonth: json["expected_release_month"] == null ? null : json["expected_release_month"],
        expectedReleaseQuarter: json["expected_release_quarter"] == null ? null : json["expected_release_quarter"],
        expectedReleaseYear: json["expected_release_year"] == null ? null : json["expected_release_year"],
        guid: json["guid"] == null ? null : json["guid"],
        id: json["id"] == null ? null : json["id"],
        image: json["image"] == null ? null : Images.fromJson(json["image"]),
        imageTags:  json["image_tags"] == null ? null : new List<ImageTag>.from(json["image_tags"].map((x) => ImageTag.fromJson(x))),
        name: json["name"]  == null ? null : json["name"],
        numberOfUserReviews: json["number_of_user_reviews"]  == null ? null : json["number_of_user_reviews"],
        originalGameRating: json["original_game_rating"] == null ? null : new List<OriginalGameRating>.from(json["original_game_rating"].map((x) => OriginalGameRating.fromJson(x))),
        originalReleaseDate: json["original_release_date"] == null ? null : json["original_release_date"],
        platforms: json["platforms"] == null ? null : new List<Platform>.from(json["platforms"].map((x) => Platform.fromJson(x))),
        siteDetailUrl: json["site_detail_url"] == null ? null : json["site_detail_url"],
        images: json["images"] == null ? null : new List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
        videos: json["videos"] == null ? null : new List<Videos>.from(json["videos"].map((x) => Videos.fromJson(x))),
        characters: json["characters"] == null ? null : new List<Character>.from(json["characters"].map((x) => Character.fromJson(x))),
        concepts: json["concepts"] == null ? null : new List<Concepts>.from(json["concepts"].map((x) => Concepts.fromJson(x))),
        developers: json["developers"] == null ? null : new List<Character>.from(json["developers"].map((x) => Character.fromJson(x))),
        firstAppearanceCharacters: json["first_appearance_characters"] == null ? null : new List<FirstAppearedIn>.from(json["first_appearance_characters"].map((x) => FirstAppearedIn.fromJson(x))),
        firstAppearanceConcepts: json["first_appearance_concepts"] == null ? null : new List<FirstAppearedIn>.from(json["first_appearance_concepts"].map((x) => FirstAppearedIn.fromJson(x))),
        firstAppearanceLocations: json["first_appearance_locations"] == null ? null : new List<FirstAppearedIn>.from(json["first_appearance_locations"].map((x) => FirstAppearedIn.fromJson(x))),
        firstAppearanceObjects: json["first_appearance_objects"] == null ? null : json["first_appearance_objects"],
        firstAppearancePeople: json["first_appearance_people"] == null ? null : new List<FirstAppearedIn>.from(json["first_appearance_people"].map((x) => FirstAppearedIn.fromJson(x))),
        franchises: json["franchises"] == null ? null : new List<Character>.from(json["franchises"].map((x) => Character.fromJson(x))),
        genres: json["genres"] == null ? null : new List<Character>.from(json["genres"].map((x) => Character.fromJson(x))),
        killedCharacters: json["killed_characters"] == null ? null : json["killed_characters"],
        locations: json["locations"] == null ? null : new List<Character>.from(json["locations"].map((x) => Character.fromJson(x))),
        objects: json["objects"] == null ? null : new List<Character>.from(json["objects"].map((x) => Character.fromJson(x))),
        people: json["people"] == null ? null : new List<Character>.from(json["people"].map((x) => Character.fromJson(x))),
        publishers: json["publishers"] == null ? null : new List<Character>.from(json["publishers"].map((x) => Character.fromJson(x))),
        releases: json["releases"] == null ? null : new List<Character>.from(json["releases"].map((x) => Character.fromJson(x))),
        similarGames: json["similar_games"] == null ? null : new List<Game>.from(json["similar_games"].map((x) => Game.fromJson(x))),
        themes: json["themes"] == null ? null : new List<Character>.from(json["themes"].map((x) => Character.fromJson(x))),
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
        "images": new List<dynamic>.from(images.map((x) => x.toJson())),
        "videos": new List<dynamic>.from(videos.map((x) => x.toJson())),
        "characters": new List<dynamic>.from(characters.map((x) => x.toJson())),
        "concepts": new List<dynamic>.from(concepts.map((x) => x.toJson())),
        "developers": new List<dynamic>.from(developers.map((x) => x.toJson())),
        "first_appearance_characters": new List<dynamic>.from(firstAppearanceCharacters.map((x) => x.toJson())),
        "first_appearance_concepts": new List<dynamic>.from(firstAppearanceConcepts.map((x) => x.toJson())),
        "first_appearance_locations": new List<dynamic>.from(firstAppearanceLocations.map((x) => x.toJson())),
        "first_appearance_objects": firstAppearanceObjects,
        "first_appearance_people": new List<dynamic>.from(firstAppearancePeople.map((x) => x.toJson())),
        "franchises": new List<dynamic>.from(franchises.map((x) => x.toJson())),
        "genres": new List<dynamic>.from(genres.map((x) => x.toJson())),
        "killed_characters": killedCharacters,
        "locations": new List<dynamic>.from(locations.map((x) => x.toJson())),
        "objects": objects,
        "people": new List<dynamic>.from(people.map((x) => x.toJson())),
        "publishers": new List<dynamic>.from(publishers.map((x) => x.toJson())),
        "releases": new List<dynamic>.from(releases.map((x) => x.toJson())),
        "similar_games": new List<dynamic>.from(similarGames.map((x) => x.toJson())),
        "themes": new List<dynamic>.from(themes.map((x) => x.toJson())),
    };
}