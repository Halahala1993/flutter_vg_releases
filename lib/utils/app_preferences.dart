import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_game_releases/utils/constants.dart';

class AppPreferences {
  
  static saveGBApiKey(String apiKey) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString(Constants.GB_API_KEY, apiKey);
  }

  static Future<String> getGBApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String apiKey = prefs.get(Constants.GB_API_KEY);

    return apiKey;
  }

  static clearAllPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.clear();
  }
}