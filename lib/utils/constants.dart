class Constants {
  
  static const String GB_API_KEY = "{GB_API_KEY}";

  //URLs
  static const String YOUTUBE_URL = "https://www.youtube.com/watch?v=";

  static const String HOMEPAGE_HEADER = "GiantBomb Game API";
  static const String HOMEPAGE_HEADER_FILTERED = "Filtered Results";
  static const String HOMEPAGE_HEADER_SEARCHED = "Search Results";

  static const String YOUTUBE_BOTTOM_SHEET = "Youtube Mirror";
  static const String DIRECT_VIDEO_BOTTOM_SHEET = "Direct Video";

  //Detail Screen Section Headers
  static const String SUMMARY = "Summary";
  static const String SIMILAR_GAMES = "Similar Games";

  //Stubs
  static const String NO_SIMILAR_GAMES_FOUND = "No Similar Games Found";
  static const String NO_SUMMARY_FOUND = "No Game Summary Available";
  static const String NO_VIDEOS_FOUND = "No Videos Available";
  static const String NO_CHARACTERS_FOUND = "No Characters Available";
  static const String NO_IMAGES_FOUND = "No Images Available";

  //Errors:
  static const String ERROR_RETRIEVE_DETAILS = "Error retrieving additional details";
  static const String COULD_NOT_LOAD_LINK = "Error: could not load url";
  static const String COULD_NOT_LOAD_GB_URL = "Could not load Gaint Bomb video, long press to try Youtube mirror.";
  static const String COULD_NOT_LOAD_YOUTUBE_URL = "Error: Could not load or find Youtube ID of selected video.";

  //Status Codes
  static const int STATUS_100 = 100;
  static const int STATUS_101 = 101;
  static const int STATUS_102 = 102;
  static const int STATUS_103 = 103;
  static const int STATUS_104 = 104;
  static const int STATUS_105 = 105;

  static const String STATUS_100_MESSAGE = "Invalid API Key";
  static const String STATUS_101_MESSAGE = "Object Not Found";
  static const String STATUS_102_MESSAGE = "Error in URL Format";
  static const String STATUS_103_MESSAGE = "'jsonp' format requires a 'json_callback' argument";
  static const String STATUS_104_MESSAGE = "Filter Error";
  static const String STATUS_105_MESSAGE = "Subscriber only video is for subscribers only";
}