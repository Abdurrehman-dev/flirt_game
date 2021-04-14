import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/scheduler.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../all_utilities.dart';

class LevelEndDialog extends StatelessWidget {
  final bool isSuccessful;

  const LevelEndDialog(this.isSuccessful);

  @override
  Widget build(BuildContext context) {
    final confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    if (isSuccessful) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        confettiController.play();
      });
    }

    return Container(
      color: AppTheme.primary,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(color: AppTheme.kAzure),
            height: getProportionateScreenHeight(230),
            child: Stack(
              overflow: Overflow.visible,
              clipBehavior: Clip.hardEdge,
              fit: StackFit.expand,
              children: [
                LoopAnimation<double>(
                  duration: 3.seconds,
                  tween: 0.0.tweenTo(1),
                  builder: (_, animChild, value) {
                    return Transform.rotate(
                      angle: value * 2 * pi,
                      child: animChild,
                    );
                  },
                  child: Image.asset(
                    'assets/chat/level_burst.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image.asset(
                    'assets/chat/level_${isSuccessful ? 'completed' : 'failed'}.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
          _buildConfetti(confettiController),
          Padding(
            padding: EdgeInsets.symmetric(vertical: kPadding * 2),
            child: Text(
              'You ${isSuccessful ? 'WIN' : 'LOSE'}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2.copyWith(
                  color: AppTheme.kDirtyPurple, fontWeight: FontWeight.bold),
            ),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Future _showBottomButton() async {
    await Future.delayed(1.seconds);

    if (AdManager.instance.showInterstitial()) {
      await Future.delayed(1.seconds);
    } else {
      AdManager.instance.loadInterstitial();
    }

    return;
  }

  Widget _buildBottomButton() {
    return FutureBuilder(
      future: _showBottomButton(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const SizedBox();

        return MyRaisedButton2(
          buttonTitle: isSuccessful ? 'Next Level' : 'Try Again',
          onTap: () {
            MyAudioPlayer.instance.playButtonTap();
            Navigator.pop(context);
            AnalyticsManager.instance
                .logEvent(isSuccessful ? 'level_complete' : 'level_failed');
          },
          color: isSuccessful ? Colors.green : Colors.redAccent,
        );
      },
    );
  }

  Widget _buildConfetti(ConfettiController confettiController) {
    if (!isSuccessful) return const SizedBox();

    return Align(
      alignment: Alignment.center,
      child: ConfettiWidget(
        confettiController: confettiController,
        blastDirection: pi / 2,
        numberOfParticles: 40,
        maxBlastForce: 70,
        blastDirectionality: BlastDirectionality.explosive,
        minBlastForce: 40,
        gravity: 0.3,
        shouldLoop: false, // start again as soon as the animation is finished
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.pink,
          Colors.orange,
          Colors.purple
        ], // manually specify the colors to be used
      ),
    );
  }

  static Future<void> show(BuildContext context, bool isSuccessful) {
    if (isSuccessful) {
      MyAudioPlayer.instance.playApplause();
    } else {
      HapticFeedback.vibrate();
      MyAudioPlayer.instance.playLevelFailed();
    }

    Dialog dialog = Dialog(
      shape: null,
      child: LevelEndDialog(isSuccessful),
    );
    return showDialog(
      context: context,
      builder: (BuildContext context) => dialog,
      barrierDismissible: false,
    );
  }
}
