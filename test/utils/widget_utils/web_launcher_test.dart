import 'package:flutter_test/flutter_test.dart';
import 'package:video_game_releases/utils/widget_utils/web_launcher.dart';


void main() {

  test('Test launching URL ', () {

    WebLauncher.launchUrl("https://google.com");

  });

}