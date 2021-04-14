import 'package:flirt/models/scratch_game_model.dart';

import '../../../all_screens.dart';
import '../../../all_utilities.dart';

class ScratchGameProvider extends ChangeNotifier {
  static final totalAttempts = 3;

  int attempts = 0;

  final ScratchGameData level;

  ScratchGameProvider(this.level) {
    this.level.logos.shuffle();
  }

  bool boxScratched(BuildContext context, IconData iconData) {
    attempts++;

    notifyListeners();

    _checkIfLevelFinished(context, iconData);

    return level.correctLogo == iconData;
  }

  _checkIfLevelFinished(BuildContext context, IconData iconData) async {
    if (level.correctLogo == iconData) {
      Prefs.instance.incrementIntermediateCompletedLevelCount();

      await Future.delayed(2.seconds);
      await LevelEndDialog.show(context, true);
      Navigator.pop(context, true);
    } else if (attempts >= totalAttempts) {
      await Future.delayed(1.seconds);
      await LevelEndDialog.show(context, false);
      Navigator.pop(context, false);
    }
  }
}
