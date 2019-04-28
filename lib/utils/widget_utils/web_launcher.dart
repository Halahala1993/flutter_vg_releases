import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_game_releases/utils/constants.dart';

class WebLauncher {

  static launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: Constants.COULD_NOT_LOAD_LINK);
    }
  }

}