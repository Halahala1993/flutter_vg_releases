import 'package:equatable/equatable.dart';

class Game extends Equatable {
  final int id;
  final String title;
  final String body;

  Game({this.id, this.title, this.body}) : super([id, title, body]);

  @override
  String toString() => 'Game { id: $id }';

  factory Game.fromJson(Map<String, dynamic> json) => new Game(
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
    };

}