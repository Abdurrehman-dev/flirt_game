import 'package:flirt/screens/scratch_level/components/scratch_box.dart';
import 'package:flirt/screens/scratch_level/components/scratch_game_provider.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../all_utilities.dart';

class ScratchScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildText(),
          VerticalSpacing(of: 40),
          Center(
            child: Wrap(
              spacing: kPadding,
              runSpacing: kPadding * 2,
              children: _scratchBoxes(context),
            ),
          ),
          BannerAdvertisement()
        ],
      ),
    );
  }

  Widget _buildText() {
    final selectorChild = Selector<ScratchGameProvider, int>(
      builder: (BuildContext context, attempts, Widget child) {
        final attemptsLeft = ScratchGameProvider.totalAttempts - attempts;
        final textWidget = Text(
          '$attemptsLeft',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        );

        return PlayAnimation(
          key: GlobalKey(),
          tween: 2.0.tweenTo(1.0),
          curve: Curves.easeInOut,
          duration: 300.milliseconds,
          builder: (BuildContext context, Widget animChild, double value) {
            return Transform.scale(
              scale: value,
              child: animChild,
            );
          },
          child: textWidget,
        );
      },
      selector: (c, model) => model.attempts,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Attempts: ',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: AppTheme.kDirtyPurple),
        ),
        selectorChild,
      ],
    );
  }

  List<Widget> _scratchBoxes(BuildContext context) {
    final logos = context.read<ScratchGameProvider>().level.logos;

    return logos.map((iconData) => ScratchBox(iconData)).toList();
  }
}
