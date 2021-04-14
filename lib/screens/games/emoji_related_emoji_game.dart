import 'dart:math';

import 'package:simple_animations/simple_animations.dart';

import '../../all_screens.dart';
import '../../all_utilities.dart';
import 'emoji.dart';
import 'helping_hand.dart';
import 'score_provider.dart';

class EmojiRelatedEmojiGame extends StatelessWidget {
  static const String routeName = "/emojiRelatedEmojiGame";

  final GlobalKey emojiKey = GlobalObjectKey("emojiKey");
  final GlobalKey targetKey = GlobalObjectKey("targetKey");
  final _helpingHand = HelpingHand();

  /// Choices for game
  final Map<String, String> choices = _getRandomChoices();

  @override
  Widget build(BuildContext context) {
    _helpingHand.showHelpingHandDelayed(context, emojiKey, targetKey);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: AppTheme.kDirtyPurple,
        ),
        centerTitle: true,
        title: Text(
          'Match the Relevant Emoji!',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: WillPopScope(
        onWillPop: _helpingHand.onWilPopScope,
        child: Padding(
            padding: const EdgeInsets.all(16.0), child: _buildBannerAd()),
      ),
    );
  }

  Widget _buildBannerAd() {
    return Column(
      children: [
        Expanded(child: _buildProvider()),
        BannerAdvertisement(
            anchorTypeMargin: -SizeConfig.safeAreaPaddingBottom / 2),
      ],
    );
  }

  Widget _buildProvider() {
    return ListenableProvider(
      create: (context) => ScoreProvider(),
      builder: (context, Widget child) => _buildGame(),
    );
  }

  Widget _buildGame() {
    return Builder(
      builder: (BuildContext context) {
        return Row(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                children: choices.keys.map((emoji) {
                  return _buildDraggable(emoji);
                }).toList()
                  ..shuffle(),
              ),
            ),
            Expanded(
              flex: 10,
              child: Column(
                children: choices.keys
                    .map((emoji) => _buildDragTarget(emoji, context))
                    .toList()
                      ..shuffle(),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildDraggable(emoji) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Consumer<ScoreProvider>(
          builder: (context, model, Widget child) {
            return Draggable<String>(
              key: emoji == choices.keys.first ? emojiKey : null,
              data: emoji,
              child: model.score[emoji] == true
                  ? const Emoji()
                  : Emoji(emoji: emoji),
              feedback: Emoji(emoji: emoji),
              childWhenDragging: const Emoji(),
              onDragStarted: () {
                MyAudioPlayer.instance.playButtonTap();
                HapticFeedback.mediumImpact();

                _helpingHand.remove();
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildDragTarget(emoji, BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: DragTarget<String>(
          key: emoji == choices.keys.first ? targetKey : null,
          builder:
              (BuildContext context, List<String> incoming, List rejected) {
            final container = Emoji(emoji: choices[emoji]);

            return Consumer<ScoreProvider>(
              builder: (context, model, Widget consumerChild) {
                if (model.score[emoji] == true) {
                  return PlayAnimation(
                    duration: 200.milliseconds,
                    tween: 1.0.tweenTo(0),
                    curve: Curves.easeInBack,
                    builder: (_, animChild, value) {
                      return Transform.scale(
                        scale: value,
                        child: animChild,
                      );
                    },
                    child: container,
                  );
                } else {
                  return container;
                }
              },
              child: container,
            );
          },
          onWillAccept: (data) => true,
          onAccept: (data) => _onDragAccept(data, emoji, context),
          onLeave: (data) {},
        ),
      ),
    );
  }

  _onDragAccept(String data, String emoji, BuildContext context) async {
    if (data != emoji) {
      await _showEndDialog(context, false);
      return;
    }

    final scoreProvider = context.read<ScoreProvider>();
    scoreProvider.updateScore(emoji);

    MyAudioPlayer.instance.playSuccess();

    if (choices.keys.length == scoreProvider.score.keys.length) {
      await Future.delayed(1.seconds);

      _showEndDialog(context, true);
    }
  }

  _showEndDialog(BuildContext context, bool isSuccess) async {
    if (isSuccess) Prefs.instance.incrementIntermediateCompletedLevelCount();

    await LevelEndDialog.show(context, isSuccess);
    Navigator.of(context).pop(isSuccess);
  }

  static Map<String, String> _getRandomChoices() {
    List<Map<String, String>> list = [];

    list.add({
      '🚗': '🛣',
      '👶': '🍼',
      '🐓': '🥚',
      '🐶': '🦴',
      '👟': '🧦',
    });

    list.add({
      '❄️': '☃️',
      '🔥': '☄️',
      '🌧️': '☔',
      '⚡': '🌩️',
      '💨': '🌪️',
    });

    list.add({
      '🌻': '🌞',
      '🍗': '🐓',
      '🥩': '🐐',
      '👩‍❤️‍👨': '💍',
      '👠': '💃',
    });

    list.add({
      '🤡': '🏻😅♀',
      '👽': '🛸',
      '💰': '🏦',
      '💿': '💻',
      '📸': '🖼️',
    });

    list.add({
      '🎉': '🎂',
      '🪓': '🌳',
      '🩺': '👨🏻‍⚕️',
      '🔮': '🧙',
      '🔍': '🕵',
    });

    list.add({
      '🗝️': '🔓 ',
      '✒️': '📖',
      '🥢': '🍜',
      '🪵': '🔥',
      '💰': '🏦',
    });

    list.add({
      '🧞‍♂️': '🪔',
      '💣': '💥',
      '🐼': '🎋',
      '🍳': '🥚',
      '🍆': '💦',
    });

    final random = Random(Prefs.instance.getIntermediateCompletedLevelCount() +
        Prefs.instance.getCompletedLevelCount());
    return list.pickOne(random);
  }
}
