import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static final Prefs _instance = Prefs._internal();
  static Prefs get instance => _instance;

  factory Prefs() {
    return _instance;
  }
  Prefs._internal();

  static SharedPreferences _prefs;

  static const KEY_SCORE = "SCORE";
  static const KEY_LEVEL_COMPLETED_COUNT = "LEVEL_COMPLETED_COUNT";
  static const KEY_INTERMEDIATE_LEVEL_COMPLETED_COUNT =
      "INTERMEDIATE_LEVEL_COMPLETED_COUNT";
  static const KEY_SHOW_GAME_SCREEN_TOUR_GUIDE = "SHOW_GAME_SCREEN_TOUR_GUIDE";
  static const KEY_APP_LAUNCHES = "APP_LAUNCHES";
  static const KEY_SHOW_IN_APP = "SHOW_IN_APP";

  Future<void> init() async => _prefs = await SharedPreferences.getInstance();

  static bool shouldIShowInAppReview() {
    final counter = _prefs.getInt(KEY_SHOW_IN_APP) ?? 1;
    _prefs.setInt(KEY_SHOW_IN_APP, counter + 1);

    return counter % 30 == 0;
  }

  setScore(int score) => _prefs.setInt(KEY_SCORE, score);

  int getScore() => _prefs.getInt(KEY_SCORE) ?? 0;

  Future<bool> incrementCompletedLevelCount() =>
      _prefs.setInt(KEY_LEVEL_COMPLETED_COUNT, getCompletedLevelCount() + 1);
  int getCompletedLevelCount() => _prefs.getInt(KEY_LEVEL_COMPLETED_COUNT) ?? 0;
  int getIntermediateCompletedLevelCount() {
    final completedLevelCount = getCompletedLevelCount();
    return _prefs.getInt(KEY_INTERMEDIATE_LEVEL_COMPLETED_COUNT +
            completedLevelCount.toString()) ??
        0;
  }

  Future<bool> incrementIntermediateCompletedLevelCount() {
    final completedLevelCount = getCompletedLevelCount();
    return _prefs.setInt(
        KEY_INTERMEDIATE_LEVEL_COMPLETED_COUNT + completedLevelCount.toString(),
        getIntermediateCompletedLevelCount() + 1);
  }

  bool canShowGameScreenTourGuide() =>
      _prefs.getBool(KEY_SHOW_GAME_SCREEN_TOUR_GUIDE) ?? true;

  canShowTourGuide(bool value) =>
      _prefs.setBool(KEY_SHOW_GAME_SCREEN_TOUR_GUIDE, value);

  incrementAppLaunches() => _prefs.setInt(KEY_APP_LAUNCHES, getAppLaunches());

  int getAppLaunches() => _prefs.getInt(KEY_APP_LAUNCHES) ?? 0;
}
