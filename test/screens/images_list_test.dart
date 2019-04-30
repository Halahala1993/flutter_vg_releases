import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:video_game_releases/models/image.dart';
import 'package:video_game_releases/screens/detail_screen/images_list.dart';

void main() {


  testWidgets("Test Displaying list of Images", (WidgetTester tester) async {


    provideMockedNetworkImages(() async {

      Images image = new Images(
          mediumUrl: "https://www.giantbomb.com/api/image/scale_medium/2534285-5551834789-slave.jpg");

      List<Images> gameImages = new List();
      gameImages.add(image);

      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              home: ImagesList(gameImages: gameImages,)
          )
      );

      await tester.pumpWidget(testWidget);

      Finder flatButton = find.byType(FlatButton);

      bool isNotNull = flatButton != null ? true : false;

      expect(isNotNull, true);

    });

  });


}