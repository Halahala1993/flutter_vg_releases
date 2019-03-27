import 'package:flutter/material.dart';
import 'package:video_game_releases/screens/homepage.dart';
import 'package:video_game_releases/utils/dio.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    new GameDio();
    // GameDio.init();

    return MaterialApp(
      title: 'Flutter Infinite Scroll',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
        ),
        body: HomePage(),
      ),
    );
  }
}