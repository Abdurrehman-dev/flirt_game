import 'dart:async';

import 'package:flirt/screens/level_complete/level_complete_dialog.dart';

import '../../../all_utilities.dart';

enum IntroPopupState { shouldDisplay, shouldHide, displayed }

class ChatProvider extends ChangeNotifier {
  List<String> messages = [];

  final ChatLevel level;
  bool isTyping = false;
  IntroPopupState introPopupState = IntroPopupState.shouldDisplay;

  ChatProvider(this.level) {
    if (level.willSenderInitiateChat) {
      MyAudioPlayer.instance.playMessageReceived();
      messages.add(level.getSenderMessage);
    }
  }

  String get _getLastMessage =>
      messages.length > 0 ? messages[messages.length - 1] : null;

  addMessage(String message) {
    messages.add(message);

    notifyListeners();
  }

  onOptionSelected(BuildContext context, String selectedOption) {
    MyAudioPlayer.instance.playMessageSent();

    // add selected option into message panel
    messages.add(selectedOption);

    if (introPopupState == IntroPopupState.shouldDisplay)
      introPopupState = IntroPopupState.shouldHide;
    else if (introPopupState == IntroPopupState.shouldHide)
      introPopupState = IntroPopupState.displayed;

    bool isGameEnded = _checkForEndCase(context, selectedOption);
    if (!isGameEnded) isTyping = true;

    notifyListeners();

    HapticFeedback.heavyImpact();

    if (isTyping) {
      Timer(2.seconds, () {
        isTyping = false;

        // get next teacher message
        final senderOption = getNextOptions().first;
        messages.add(senderOption);

        _checkForEndCase(context, senderOption);

        notifyListeners();

        HapticFeedback.heavyImpact();
        MyAudioPlayer.instance.playMessageReceived();
      });
    }
  }

  bool _checkForEndCase(BuildContext context, String message) {
    if (level.isSuccessMessage(message)) {
      Prefs.instance.incrementCompletedLevelCount();
      _showEndDialog(context, true);
      return true;
    } else if (level.isErrorMessage(message)) {
      _showEndDialog(context, false);
      return true;
    }

    return false;
  }

  List<String> getNextOptions() {
    if (isTyping) return null;

    return level.chatList[_getLastMessage ?? ChatLevel.USER_KEY];
  }

  _showEndDialog(BuildContext context, bool isSuccess) async {
    await Future.delayed(2.seconds);

    await LevelEndDialog.show(context, isSuccess);
    Navigator.of(context).pop(isSuccess);
  }
}
