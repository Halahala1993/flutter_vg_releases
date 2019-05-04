import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_game_releases/models/enums.dart';
import 'package:auto_size_text/auto_size_text.dart';

class PlatformBadgeBuilder {

  static Widget buildPlatformBadge (Abbreviation platform) {

//    abbreviationValues.reverse;
    String platformName = abbreviationValues.reverse[platform];

    if (platformName == null || platformName.isEmpty || platformName == "null") {
      return Container(
        alignment: Alignment.bottomRight
      );
    } else {
      return Container(
          height: 30,
          width: 40,
          alignment: Alignment.bottomRight,
          child: new RaisedButton(
            child: new AutoSizeText(
              platformName, 
              maxLines: 1,),
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
      case Abbreviation.PS3:
          return Colors.blue;
      case Abbreviation.PS2:
          return Colors.blue;
      case Abbreviation.PS1:
          return Colors.blue;
      case Abbreviation.PSNV:
        return Colors.blue;
      case Abbreviation.PS3N:
        return Colors.blue;
      case Abbreviation.VITA:
        return Colors.blue;
      case Abbreviation.PSP:
        return Colors.blue;
      case Abbreviation.PSPN:
        return Colors.blue;
      case Abbreviation.NSW:
        return Colors.red;
      case Abbreviation.N64:
        return Colors.red;
      case Abbreviation.SNES:
        return Colors.red;
      case Abbreviation.Wii:
        return Colors.red;
      case Abbreviation.WiiU:
        return Colors.red;
      case Abbreviation.NES:
        return Colors.red;
      case Abbreviation.GCN:
        return Colors.red;
      case Abbreviation.GBA:
        return Colors.red;
      case Abbreviation.GBC:
        return Colors.red;
      case Abbreviation.DS:
        return Colors.red;
      case Abbreviation.DSI:
        return Colors.red;
      case Abbreviation.N3DS:
        return Colors.red;
      case Abbreviation.GB:
        return Colors.red;
      case Abbreviation.GBA:
        return Colors.red;
      case Abbreviation.XONE:
        return Colors.green;
      case Abbreviation.IPHN: 
        return Colors.blueGrey;
      case Abbreviation.ANDR: 
        return Colors.lightGreen;
      case Abbreviation.MAC: 
        return Colors.blueGrey;
      case Abbreviation.LIN: 
        return Colors.deepOrange;
      case Abbreviation.IPAD: 
        return Colors.blueGrey;
      case Abbreviation.ARC: 
        return Colors.grey;
      case Abbreviation.THE_3DS:
        return Colors.red;
      case Abbreviation.THE_3DSE: 
        return Colors.red;
      case Abbreviation.APTV:
        return Colors.blueGrey;
      case Abbreviation.XBOX: 
        return Colors.green;
      case Abbreviation.X360:
        return Colors.green;
      case Abbreviation.XBGS:
        return Colors.green;
      default:
          return Colors.grey;
    }
  }
  
}