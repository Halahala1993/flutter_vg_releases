import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_game_releases/bloc/bloc.dart';
import 'package:video_game_releases/models/character.dart';
import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/screens/detail_screen/category_image.dart';
import 'package:video_game_releases/utils/constants.dart';
import 'package:video_game_releases/utils/widget_utils/web_launcher.dart';

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
                  child: CategoryImage(
                      this.gameCharacters[i].image.smallUrl,
                      180.0,
                      320.0
                  ),
                ),
                padding: const EdgeInsets.all(0.0),
                onPressed: () async {
                  
                  String characterUrl = this.gameCharacters[i].siteDetailUrl;

                  await WebLauncher.launchUrl(characterUrl);
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