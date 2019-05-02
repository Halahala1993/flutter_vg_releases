import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_releases/models/game.dart';
import 'package:video_game_releases/utils/date_util.dart';

void main() {
  test("Test retrieiving date filters", () {
    var day = DateTime.now().day;

    String dateFilter = DateUtil.retrieveDateFilter();

    var tmp = dateFilter.substring(
        dateFilter.indexOf("2019"), dateFilter.indexOf("|")
    );

    var formattedDay = tmp.substring(
      tmp.lastIndexOf("-") + 1, tmp.length
    );

    var testDay = day.toString().length == 1 ? "0${day.toString()}" : day.toString();

    expect(testDay.toString(), formattedDay);

  });

  test("Test date formatting", () {
    String formattedDate = DateUtil.formatDate(DateTime.now());

    var day = DateTime.now().day;

    var formattedDay = formattedDate.substring(
        formattedDate.lastIndexOf("-") + 1, formattedDate.length
    );

    var testDay = day.toString().length == 1 ? "0${day.toString()}" : day.toString();


    expect(testDay, formattedDay);

  });

  test("Resolve Original Release Game Date", () {

    Game game = new Game();

    game.originalReleaseDate = "2012-12-31 00:00:00";

    String formattedDate = DateUtil.resolveGameReleaseDate(game);

    var day = 31;

    var formattedDay = formattedDate.substring(
        formattedDate.lastIndexOf("-") + 1, formattedDate.length
    );

    expect(day.toString(), formattedDay);

  });

  test("Resolve Expected Release Game Date", () {

    Game game = new Game();

    game.expectedReleaseYear = 2019;
    game.expectedReleaseMonth = 04;
    game.expectedReleaseDay = 20;

    String formattedDate = DateUtil.resolveGameReleaseDate(game);

    var day = 20;

    var formattedDay = formattedDate.substring(
        0, formattedDate.indexOf("-")
    );

    expect(day.toString(), formattedDay);

  });

  test("Resolve Expected Release Game Date", () {

    Game game = new Game();

    game.expectedReleaseYear = 2019;
    game.expectedReleaseMonth = 04;
    game.expectedReleaseDay = 20;

    String formattedDate = DateUtil.resolveGameReleaseDate(game);

    var day = 20;

    var formattedDay = formattedDate.substring(
        0, formattedDate.indexOf("-")
    );

    expect(day.toString(), formattedDay);

  });


  test("Resolve Unkown Release Game Date", () {

    Game game = new Game();

    String formattedDate = DateUtil.resolveGameReleaseDate(game);


    expect("Unknown", formattedDate);

  });

  test("Resolve Expected Quarter Release Game Date", () {

    Game game = new Game();

    game.expectedReleaseYear = 2019;
    game.expectedReleaseQuarter = 2;

    String formattedDate = DateUtil.resolveGameReleaseDate(game);

    var formattedDay = formattedDate.substring(
        0, formattedDate.indexOf(" ")
    );

    expect("Q${game.expectedReleaseQuarter}", formattedDay);

  });

  test("Resolve Expected Year Release Game Date", () {

    Game game = new Game();

    game.expectedReleaseYear = 2019;

    String formattedDate = DateUtil.resolveGameReleaseDate(game);

    expect("Y ${game.expectedReleaseYear}", formattedDate);

  });
}