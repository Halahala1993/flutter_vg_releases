import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_game_releases/models/enums.dart';

class PlatformBadgeBuilder {

  static Widget buildPlatformBadge (Abbreviation platform) {
    String platformName = platform.toString().replaceAll("Abbreviation.", "");

    if (platformName == null || platformName.isEmpty || platformName == "null") {
      return Container();
    } else {
      return Container(
          height: 30,
          width: 40,
          alignment: Alignment.bottomRight,
          child: new RaisedButton(
            child: new Text(platformName, textScaleFactor: .9,),
            color: determineBadgeColor(platform),
            elevation: 2.0,
            onPressed: () {
              //Maybe filter based on platform?
            },
          )
      );
    }
  }

  static MaterialColor determineBadgeColor(Abbreviation platform) {
    switch (platform) {
      case Abbreviation.PC:
        return Colors.grey;
      case Abbreviation.PS4:
        return Colors.blue;
      case Abbreviation.NSW: 
        return Colors.red;
      case Abbreviation.XONE: 
        return Colors.green;
      default:
          return Colors.grey;
    }
  }
  
}