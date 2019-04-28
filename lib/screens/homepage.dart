import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_game_releases/bloc/bloc.dart';
import 'package:video_game_releases/models/enums.dart';
import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/screens/bottomloader.dart';
import 'package:video_game_releases/screens/detail_screen/game_detail.dart';
import 'package:video_game_releases/screens/filter_widget.dart';
import 'package:video_game_releases/screens/game_widget.dart';
import 'package:video_game_releases/utils/app_preferences.dart';
import 'package:video_game_releases/utils/filters.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final GameBloc _gameBloc = GameBloc();
  final _scrollThreshold = 200.0;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  BuildContext _context;
  String apiKey = "";
  bool filteredRequest = false;
  Completer<void> _refreshCompleter;


  List<Abbreviation> checkedConsoles = new List<Abbreviation>();

  _HomePageState() {
    _scrollController.addListener(_onScroll);
  }


  AlertDialog buildApiKeyInputDialog() {
  return AlertDialog(
    title: Text("Enter GiantBomb API key"),
    content: TextField(
      onChanged: (value) {
        apiKey = value;
      },
    ),
    actions: <Widget>[
      new FlatButton(
        child: new Text("Ok"),
        onPressed: () {
          if (this.apiKey.isEmpty) {
            buildApiKeyInputDialog();
          } else {
            AppPreferences.saveGBApiKey(apiKey);
            retrieveGameList();
            Navigator.of(context).pop();

          }
        },
      ),
      new FlatButton(
        child: new Text("Cancel"),
        onPressed: () {
          //Exit app since we need API to do anything
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
      ),
    ],
  );
  }

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();

    AppPreferences.getGBApiKey().then((apiKey) {
      if (apiKey != null && apiKey.isNotEmpty) {
        this.apiKey = apiKey;
        _gameBloc.dispatch(Fetch());
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await showDialog<String>(
            context: context,
            builder: (BuildContext context) => buildApiKeyInputDialog(),
          );
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    this._context = context;

    return Scaffold(
      key: scaffoldKey,
      endDrawer: FilterWidget(gameBloc: _gameBloc,),
      appBar: AppBar(
        title: Text("Recent Releases"),
        actions: <Widget>[
          buildSearchBar(),
        ],
      ),
      body:  BlocBuilder(
        bloc: _gameBloc,
        builder: (BuildContext context, GameState state) {
          if (state is GameUninitialized) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GameError) {
            return Center(
              child: Text('failed to fetch games'),
            );
          }

          return Container(
            child: buildAndDetermineGameListState(state),
          );

        },
      )
    );

  }

  Widget buildAndDetermineGameListState(GameState state) {

    if (state is GameLoaded) {
      filteredRequest = false;

      return buildGameList(state.games, state.hasReachedMax);
    } else if (state is GameFiltered) {

      filteredRequest = true;

      return  buildGameList(state.games, state.hasReachedMax);
    } else {
      return Container();
    }
  }

  Widget buildGameList(List<Game> games, bool hasReachedMax) {
    if (games.isEmpty) {
      return Center(
        child: Text('no games'),
      );
    }

    _refreshCompleter?.complete();
    _refreshCompleter = Completer();

    return RefreshIndicator(
      onRefresh: () {
        _gameBloc.dispatch(
            RefreshGameFetch(games: games)
        );
        return _refreshCompleter.future;
      },
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return index >= games.length ? BottomLoader() : FlatButton(
              child: GameWidget(game: games[index], gameBloc: _gameBloc,),
              onPressed: () {
                //Navigate to detail screen
                //_gameBloc.dispatch(FetchGameDetail(games[index].id));

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameDetailScreen(games[index], games[index].id.toString()),
                  ),
                );

              });
        },
        itemCount: hasReachedMax
            ? games.length
            : games.length + 1,
        controller: _scrollController,
      ),
    );
  }

  IconButton buildSearchBar() {
    return new IconButton(
      icon: new Icon(
        Icons.filter_list,
        color: new Color(0xff3C3261),
      ),
      onPressed: () {
        scaffoldKey.currentState.openEndDrawer();
    });
  }

  retrieveGameList() {
    if (filteredRequest) {
      _gameBloc.dispatch(FetchFilteredList());
    } else {
      _gameBloc.dispatch(Fetch());
    }
  }

  handleCheckState(bool checked, Abbreviation value) {
    if (checked) {
        this.checkedConsoles.add(value);
    } else {
        this.checkedConsoles.remove(value);
    }
  }
  
  @override
  void dispose() {
    _gameBloc.dispose();
    Filters.clear();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      retrieveGameList();
    }
  }
}