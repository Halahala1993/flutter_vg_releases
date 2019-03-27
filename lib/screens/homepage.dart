import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_game_releases/bloc/bloc.dart';
import 'package:video_game_releases/screens/bottomloader.dart';
import 'package:video_game_releases/screens/game_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final GameBloc _gameBloc = GameBloc();
  final _scrollThreshold = 200.0;

  _HomePageState() {
    _scrollController.addListener(_onScroll);
    _gameBloc.dispatch(Fetch());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
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
    );
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
      _gameBloc.dispatch(Fetch());
    }
  }
}