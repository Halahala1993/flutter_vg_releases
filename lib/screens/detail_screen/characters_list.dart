import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_game_releases/bloc/bloc.dart';
import 'package:video_game_releases/models/character.dart';
import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/utils/constants.dart';

class CharactersList extends StatefulWidget {

  final Game game;

  CharactersList({this.game});

  @override
  _CharactersListState createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {

  final Color mainColor = Colors.black38;
  final DetailGameBloc _gameBloc = DetailGameBloc();
  List<Character> gameCharacters;
  Game game;
  bool characterListAvailable = false;

  @override
  void initState() {
    super.initState();
    this.game = widget.game;
    if (game.characters != null && game.characters.isNotEmpty) {
      print("Setting up Videos");
      this.characterListAvailable = true;
      setupCharacterList(game);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder(
        bloc: _gameBloc,
        builder: (BuildContext context, DetailGameState state){
          if (!this.characterListAvailable) {
            return Container(
              child: Text(Constants.NO_CHARACTERS_FOUND),
            );
          }

          if(state is GameCharacters) {
            this.gameCharacters = state.characters;
            return buildGameCharactersList();
          }

          return new Container(
            child: CircularProgressIndicator(),
          );

        },
      ),
    );
  }

  Widget buildGameCharactersList() {

    if (gameCharacters == null || gameCharacters.isEmpty) {
      return Container(
        child: Text(Constants.NO_CHARACTERS_FOUND),
      );
    } else if (gameCharacters == null || gameCharacters.isEmpty){
      return new CircularProgressIndicator();
    }

    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Expanded(
          child: new Container(
            height: 250,
            child: buildGameCharactersListView(),
          ),
        ),
      ],
    );
  }

  Widget buildGameCharactersListView() {
    return ListView.builder(
        key: PageStorageKey(this.gameCharacters[0].name),//Required to get passed type bool is not subtype of double error.(scroll position error)
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: gameCharacters == null ? 0 : gameCharacters.length,
        itemBuilder: (context, i) {
          return new Column(
            children: <Widget>[
              new FlatButton(
                child: new Padding(
                  padding: const EdgeInsets.only(
                      right: 8, left: 8, bottom: 8),
                  child: buildSimilarGamePoster(i),
                ),
                padding: const EdgeInsets.all(0.0),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => GameDetailScreen(
                  //         gameVideos[i], i.toString()),
                  //   ),
                  // );
                },
                color: Colors.white,
              ),
              new Container(
                width: 100,
                child: new AutoSizeText(
                  gameCharacters[i].name,
                  maxLines: 3,
                  maxFontSize: 16,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          );
        });
  }

  Stack buildSimilarGamePoster(int index) {
    return new Stack(
      children: <Widget>[

        new Container(
          width: 320.0,
          height: 180.0,
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(1.0),
            color: Colors.grey,
            boxShadow: [
              new BoxShadow(
                  color: mainColor, blurRadius: 1.0, offset: new Offset(2.0, 5.0))
            ],
          ),
          child: retrieveGamePoster(index),
        )
      ],
    );
  }

  CachedNetworkImage retrieveGamePoster(int index) {

    String gamePoster = gameCharacters[index].image.smallUrl;

    if (gamePoster != null && gamePoster.isNotEmpty) {
      return CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: gamePoster,
        placeholder: (context, url){
          new CircularProgressIndicator();
        },
      );
    } else {
      return null;
    }
  }

  setupCharacterList(Game game) {
    if (game.characters != null  && game.characters.length != 0) {
      String charactersIds = formatCharacterIds(game.characters);
      _gameBloc.dispatch(FetchCharacters(charactersIds));
    }
  }

  String formatCharacterIds(List<Character> characters) {
    String charactersIds = "";
    for (Character character in characters) {
      charactersIds += "${character.id}|";
    }

    return charactersIds;
  }
}