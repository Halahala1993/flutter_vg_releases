import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_game_releases/bloc/bloc.dart';
import 'package:video_game_releases/models/enums.dart';
import 'package:video_game_releases/models/filters.dart';
import 'package:video_game_releases/screens/bottomloader.dart';
import 'package:video_game_releases/screens/game_widget.dart';
import 'package:video_game_releases/utils/app_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final GameBloc _gameBloc = GameBloc();
  final _scrollThreshold = 200.0;
  BuildContext _context;
  String apiKey = "";

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => buildApiKeyInputDialog(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
          if (state is GameLoaded) {
            if (state.games.isEmpty) {
              return Center(
                child: Text('no games'),
              );
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.games.length
                    ? BottomLoader()
                    : GameWidget(game: state.games[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.games.length
                  : state.games.length + 1,
              controller: _scrollController,
            );
          }
        },
      )
    );

  } 

  IconButton buildSearchBar() {
    return new IconButton(
      icon: new Icon(
        Icons.filter_list,
        color: new Color(0xff3C3261),
      ),
      onPressed: () {
        showFilterDialog();
    });
  }

  AlertDialog buildFilterAlertDialog(BuildContext context) {
   return  AlertDialog(
      title: new Text("Request Seasons"),
      content: Container(
        height: 300,
        width: 300,
        child: ListView.builder(
          itemCount: abbreviationValues.map.keys.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return CheckboxListTile(
              // key: PageStorageKey<Abbreviation>(),
              title: new Text(Abbreviation.values[index].toString().replaceAll("Abbreviation.", "")),
              onChanged: (bool value) {
                print("Checked");
                handleCheckState(value, Abbreviation.values[index]);
                Navigator.of(context).pop();
                showFilterDialog();
              },
              value: this.checkedConsoles.contains(Abbreviation.values[index])
            );
          },
        ),
      ),
      actions: <Widget>[
        FlatButton(
        child: new Text("Ok"),
        onPressed: () {
          for (var item in this.checkedConsoles) {
            int platformId = FilterIds.platformIds[item];
            Filters.preparePlatformFilter(platformId);
          }
          //Filters.preparePlatformFilter(platformId);
          retrieveGameList();
          Navigator.of(context).pop();
        },
      ),
      new FlatButton(
        child: new Text("Clear"),
        onPressed: () {
          this.checkedConsoles.clear();
          Filters.clear();
          //Exit app since we need API to do anything
          Navigator.of(context).pop();
          retrieveGameList();
        },
      ),
      ],
   );
  }

  Future<Null> showFilterDialog() async {
    return showDialog <Null> (
        context: this.context,
        builder: (BuildContext context) {
          var alert = buildFilterAlertDialog(context);
          return alert;
        });
  }

  retrieveGameList() {
     _gameBloc.dispatch(Fetch());
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