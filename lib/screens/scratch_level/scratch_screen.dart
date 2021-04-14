import 'dart:math';

import 'package:flirt/models/scratch_game_model.dart';

import '../../all_utilities.dart';
import 'components/scratch_game_provider.dart';
import 'components/scratch_screen_body.dart';

class ScratchLevelScreen extends StatelessWidget {
  static const String routeName = "/ScratchLevelScreen";

  @override
  Widget build(BuildContext context) {
    final random = Random(Prefs.instance.getIntermediateCompletedLevelCount() +
        Prefs.instance.getCompletedLevelCount());

    final level = ScratchGameData.list.pickOne(random);

    return Scaffold(
      appBar: AppBar(
        title: Text(level.instructions),
        centerTitle: true,
        leading: BackButton(
          color: AppTheme.kDirtyPurple,
        ),
      ),
      body: _buildProvider(level),
    );
  }

  Widget _buildProvider(ScratchGameData level) {
    return ListenableProvider(
      create: (context) => ScratchGameProvider(level),
      builder: (context, Widget child) => ScratchScreenBody(),
    );
  }
}
