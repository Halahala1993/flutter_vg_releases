import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_game_releases/utils/widget_utils/image_zoom_util.dart';

void main() {
  testWidgets("Test Image Zoom widget", (WidgetTester tester) async {

    provideMockedNetworkImages(() async {

      String url = "https://www.giantbomb.com/api/image/original/2534285-5551834789-slave.jpg";

      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: ImageZoom(url: url),)
      );

      await tester.pumpWidget(testWidget);

      var photoView = find.byKey(Key("image_zoom")).evaluate().first.widget as PhotoView;

      expect(photoView.heroTag, url);

    });




  });
}