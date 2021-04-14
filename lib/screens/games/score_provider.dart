import '../../all_utilities.dart';

class ScoreProvider extends ChangeNotifier {
  final Map<String, bool> score = {};

  updateScore(String key) {
    score[key] = true;

    notifyListeners();
  }
}
