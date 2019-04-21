import 'package:intl/intl.dart';
import 'package:video_game_releases/models/game.dart';

class DateUtil {
    
  static String retrieveDateFilter() {
    var now = new DateTime.now();
    var future = new DateTime(now.year + 10);
    
    String nowFormatted = formatDate(now);
    String futureFormatted = formatDate(future);

    String dateFilter = "original_release_date:$nowFormatted|$futureFormatted";

    return dateFilter;
  }

  static String resolveGameReleaseDate(Game game) {
    if (game.originalReleaseDate == null || game.originalReleaseDate.isEmpty) {

      var year = game.expectedReleaseYear;
      var quarter = game.expectedReleaseQuarter;

      if (year == null && game.expectedReleaseMonth == null && game.expectedReleaseDay == null) {
        return "Unknown";
      } else if (game.expectedReleaseDay == null && game.expectedReleaseMonth == null && quarter != null) {

        return "Q$quarter $year";
      } else if (game.expectedReleaseDay == null && game.expectedReleaseMonth == null && quarter == null && year != null) {

        return "Y $year";
      }else {
        String day = game.expectedReleaseDay.toString();
        String month = game.expectedReleaseMonth.toString();
        String year = game.expectedReleaseYear.toString();

        if (day.length == 1) 
          day = "0$day"; 

        if (month.length == 1)
          month = "0$month";

        return "$day-$month-$year";
      }

    } else {

      var formattedDate = game.originalReleaseDate.replaceAll(" 00:00:00", "");

      return formattedDate;
    }
  }

  static String formatDate (DateTime date) {

    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

}