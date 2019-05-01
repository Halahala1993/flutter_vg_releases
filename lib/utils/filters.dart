import 'package:video_game_releases/models/enums.dart';

class Filters {
  static String platformFilter;
  static String gameName;
  static DateTime fromDate;
  static DateTime toDate;

  static void preparePlatformFilter(int platformId) {
    if (platformFilter == null || platformFilter.isEmpty) {
      platformFilter = ",platforms:$platformId";
    } else {
      platformFilter += "|$platformId";
    }
  }

  static void prepareGameNameFilter(String name) {
    gameName = ",name:$name";
  }

  static String getGameName() {
    if (gameName != null ) {
      return gameName.substring(0, gameName.indexOf(':'));
    } else {
      return "";
    }
  }

  static String getFilters() {
    String filters = "";
    if (platformFilter != null) {
      filters += platformFilter;
    }

    if (gameName != null) {
      filters += gameName;
    }

    return filters;
  }

  static void clear() {
    platformFilter = null;
    fromDate = null;
    toDate = null;
    gameName = null;
  }

  /*static String getCustomDateFilters() {
    return
  }*/

}

  

class FilterIds {
  static const Map<AbbreviationFilter, int> platformIds = ({
    AbbreviationFilter.PS4 : 146, 
    AbbreviationFilter.PC : 94, 
    AbbreviationFilter.XONE : 145, 
    AbbreviationFilter.NSW : 157, 
    AbbreviationFilter.ARC : 84, 
    AbbreviationFilter.IPHN : 96, 
    AbbreviationFilter.MAC : 17, 
    AbbreviationFilter.XBOX : 32, 
    AbbreviationFilter.N64 : 43, 
    AbbreviationFilter.PS1 : 22, 
    AbbreviationFilter.GCN : 23, 
    AbbreviationFilter.PS2 : 19, 
    AbbreviationFilter.WII : 36, 
    AbbreviationFilter.PS3 : 35, 
    AbbreviationFilter.WIIU : 139, 
    AbbreviationFilter.ANDR : 123, 
    AbbreviationFilter.APTV : 159, 
    AbbreviationFilter.LIN : 152, 
    AbbreviationFilter.PSNV : 143, 
    AbbreviationFilter.THE_3_DS : 117, 
    AbbreviationFilter.VITA : 129, 
    AbbreviationFilter.IPAD : 121  
  });
}
