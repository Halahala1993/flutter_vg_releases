import 'package:video_game_releases/models/enums.dart';

class Filters {
  static String platformFilter;
  
  static void preparePlatformFilter(int platformId) {
    if (platformFilter == null || platformFilter.isEmpty) {
      platformFilter = ",platforms:$platformId";
    } else {
      platformFilter += "|$platformId";
    }
  }

  static String getFilters() {
    return platformFilter;
  }

  static void clear() {
    platformFilter = null;
  }
}

  

class FilterIds {
  static const Map<Abbreviation, int> platformIds = ({
    Abbreviation.PS4 : 146, 
    Abbreviation.PC : 94, 
    Abbreviation.XONE : 145, 
    Abbreviation.NSW : 157, 
  });
}
