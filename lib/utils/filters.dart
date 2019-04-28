import 'package:video_game_releases/models/enums.dart';

class Filters {
  static String platformFilter;
  static DateTime fromDate;
  static DateTime toDate;

  static void preparePlatformFilter(int platformId) {
    if (platformFilter == null || platformFilter.isEmpty) {
      platformFilter = ",platforms:$platformId";
    } else {
      platformFilter += "|$platformId";
    }
  }

  static String getFilters() {
    String filters = "";
    if (platformFilter != null) {
      filters += platformFilter;
    }
    return filters;
  }

  static void clear() {
    platformFilter = null;
    fromDate = null;
    toDate = null;
  }

  /*static String getCustomDateFilters() {
    return
  }*/

}

  

class FilterIds {
  static const Map<Abbreviation, int> platformIds = ({
    Abbreviation.PS4 : 146, 
    Abbreviation.PC : 94, 
    Abbreviation.XONE : 145, 
    Abbreviation.NSW : 157, 
  });
}
