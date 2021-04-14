import 'package:simple_animations/simple_animations.dart';

import '../../all_utilities.dart';

class HelpingHand {
  OverlayEntry _handOverlay;
  bool shouldDisplay = true;

  /// If user has completed 4 levels then helping hand won't be displayed
  /// It will wait for 5 seconds and then it will check whether user have already slided the finger then it should
  /// not display
  showHelpingHandDelayed(BuildContext context, GlobalKey startingPointKey,
      GlobalKey targetKey) async {
    if (Prefs.instance.getCompletedLevelCount() > 4) return;

    await Future.delayed(5.seconds);

    if (!shouldDisplay) return;

    RenderBox startRenderObject =
        startingPointKey.currentContext.findRenderObject();
    final startOffset = startRenderObject.localToGlobal(Offset.zero);

    RenderBox endRenderObject = targetKey.currentContext.findRenderObject();
    final endOffset = endRenderObject.localToGlobal(Offset.zero);

    _handOverlay = OverlayEntry(
      builder: (BuildContext context) {
        return LoopAnimation(
          duration: 3.seconds,
          tween: startOffset.tweenTo(endOffset),
          curve: Curves.easeOutQuint,
          builder: (_, animChild, Offset value) {
            return Positioned(
              top: value.dy,
              left: value.dx,
              child: animChild,
            );
          },
          child: SizedBox(
            width: 100,
            height: 100,
            child: Image.asset('assets/icons/hand.png'),
          ),
        );
      },
    );

    final overlayState = Overlay.of(context);
    overlayState.insert(_handOverlay);
  }

  Future<bool> onWilPopScope() {
    remove();
    return Future.value(true);
  }

  remove() {
    shouldDisplay = false;

    if (_handOverlay == null) return;

    _handOverlay?.remove();
    _handOverlay = null;
  }
}
