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
import 'package:video_game_releases/utils/constants.dart';
import 'package:video_game_releases/utils/filters.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final GameBloc _gameBloc = GameBloc();
  final _scrollThreshold = 200.0;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController searchController = new TextEditingController();
  Color mainColor = const Color(0xff3C3261);

  bool _isSearching = false;
  String apiKey = "";
  bool filteredRequest = false;
  Completer<void> _refreshCompleter;
  String _searchQuery;
  List<Game> games;

  Icon searchIcon = new Icon(
    Icons.search,
    color: new Color(0xff3C3261),
  );

  Widget appBarTitle = new Text(
    Constants.HOMEPAGE_HEADER,
    style: new TextStyle(color: Color(0xff3C3261)),
  );


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
            Navigator.of(context).pop("OK");

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
          //Force the dialog to keep showing unless an API key is provided.
          var result;
          do {
             result = await showDialog<String>(
                context: context,
                builder: (BuildContext context) => buildApiKeyInputDialog(),
              );
             print(result);
          }while(result == null);
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      endDrawer: FilterWidget(gameBloc: _gameBloc,),
      appBar: AppBar(
        title: appBarTitle,
        actions: <Widget>[
          buildFilterButton(),
          buildSearchBar()
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

      this.games = state.games != null || state.games.isNotEmpty ? state.games : null;

      return buildGameList(state.hasReachedMax);
    } else if (state is GameFiltered) {

      filteredRequest = true;
      this.games = state.games != null || state.games.isNotEmpty ? state.games : null;

      return  buildGameList(state.hasReachedMax);
    } else if (state is GameSearched) {
      filteredRequest = false;
      this.games = state.games != null || state.games.isNotEmpty ? state.games : null;

      return buildGameList(state.hasReachedMax);
    } else {
      return Container();
    }
  }

  @widget
  Widget buildGameList(bool hasReachedMax) {

    if (games == null) {
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

  @widget
  IconButton buildFilterButton() {
    return new IconButton(
      icon: new Icon(
        Icons.filter_list,
        color: new Color(0xff3C3261),
      ),
      onPressed: () {
        scaffoldKey.currentState.openEndDrawer();
    });
  }

  @widget
  IconButton buildSearchBar() {
    return new IconButton(icon: searchIcon,
        onPressed: () {
          setState(() {
            if (searchIcon.icon == Icons.search) {
              this.searchIcon = new Icon(
                Icons.close,
                color: mainColor,
              );
              this.appBarTitle = new TextField(
                controller: searchController,
                style: new TextStyle(
                  color: mainColor,
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(
                        Icons.search,
                        color: mainColor
                    ),
                    hintText: "Search...",
                    hintStyle: new TextStyle(
                        color: mainColor
                    )
                ),
                onSubmitted: searchOperation,
              );

            } else {
              handleSearchEnd();
            }
          });
        }
    );
  }

  void searchOperation(String query) {
    setState(() {
      _isSearching = true;
      this._searchQuery = query;
      this.games.clear();
      retrieveGameList();
    });
  }

  void handleSearchEnd() {
    setState(() {
      this.searchIcon = new Icon(
        Icons.search,
        color: mainColor,
      );
      this.appBarTitle = new Text(
        Constants.HOMEPAGE_HEADER,
        style: new TextStyle(color: mainColor),
      );
      _isSearching = false;
      searchController.clear();
      _searchQuery = null;
      this.games.clear();
      Filters.clear();
      //moviePresenter.getPopularMovies();
      retrieveGameList();
    });
  }

  retrieveGameList() {
    if (_isSearching) {
      _gameBloc.dispatch(FetchSearchResults(searchQuery: this._searchQuery));
    } else if (filteredRequest) {
      _gameBloc.dispatch(FetchFilteredList());
    } else {
      _gameBloc.dispatch(Fetch());
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