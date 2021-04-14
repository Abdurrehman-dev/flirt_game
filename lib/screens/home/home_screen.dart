import 'dart:math';

import 'package:flirt/more/more_screen.dart';
import 'package:flirt/utilities/notification_manager.dart';

import '../../all_screens.dart';
import '../../all_utilities.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/HomeScreen";

  final levels = ChatLevel.allLevels();

  @override
  Widget build(BuildContext context) {
    NotificationManager.instance.scheduleAllNotifications();
    ChatLevel.printUnreachableKeys();

    return Scaffold(
      backgroundColor: AppTheme.accent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/home/home_top.png',
            alignment: Alignment.topCenter,
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 250.h,
            child: Image.asset('assets/images/home/home_clouds.png'),
          ),
          Positioned(
            bottom: -30.h,
            left: -20.w,
            right: 0.w,
            child: Image.asset(
              'assets/images/home/home_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            height: 400.h,
            left: 50.w,
            right: 50.w,
            child: LoopAnimation<double>(
              duration: 4.seconds,
              tween: 0.0.tweenTo(1),
              builder: (_, animChild, value) {
                return Transform.rotate(
                  angle: value * 2 * pi,
                  child: animChild,
                );
              },
              child: Image.asset(
                'assets/images/home/level_burst.png',
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
          ),
          Positioned(
            top: 80.h,
            height: 250.h,
            left: 80.w,
            right: 80.w,
            child: Center(
              child: Image.asset('assets/images/welcome/sp_logo.png'),
            ),
          ),
          Positioned(
            bottom: 0,
            height: 250.h,
            child: Center(
              child: Image.asset('assets/images/home/home_girl.png'),
            ),
          ),
          Positioned(
              child: MoreScreenButton(onPressed: () {
                Navigator.pushNamed(context, MoreScreen.routeName);
              }),
              right: 0,
              bottom: 250.h),
          Positioned(
            bottom: 90.h,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 50.h,
                width: 200.w,
                decoration: BoxDecoration(
                    color: AppTheme.kSalmon,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.kDirtyPurple,
                        offset: Offset(0, 3),
                        spreadRadius: 1,
                      )
                    ]),
                child: FlatButton(
                  onPressed: () {
                    _onTapLevel(context);
                  },
                  child: Text(
                    'PLAY',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 31.sp),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onTapLevel(BuildContext context) async {
    final completedLevelCount = Prefs.instance.getCompletedLevelCount();

    if (completedLevelCount >= levels.length) return;

    MyAudioPlayer.instance.playButtonTap();

    final isShowingIntermediateLevel =
        await _isShowingIntermediateLevel(context, completedLevelCount);
    if (isShowingIntermediateLevel == null) return;

    final level = levels[completedLevelCount];
    final isLevelCompleted = await Navigator.pushNamed(
        context, ChatScreen.routeName,
        arguments: level);
    final bool isLevelCompleted2 = isLevelCompleted;
    if (isLevelCompleted2 == null) return;

    Future.delayed(200.milliseconds, () => _onTapLevel(context));
  }

  Future<bool> _isShowingIntermediateLevel(
      BuildContext context, int completedLevelCount) async {
    if (completedLevelCount == 0) return false;

    final interCompCount = Prefs.instance.getIntermediateCompletedLevelCount();
    if (interCompCount >= 2) return false;

    final mod = (completedLevelCount - 1) % 3;

    String levelName;
    switch (mod) {
      case 0:
        levelName = interCompCount == 0
            ? EmojiNameGame.routeName
            : ScratchLevelScreen.routeName;
        break;
      case 1:
        levelName = interCompCount == 0
            ? EmojiColorGame.routeName
            : ScratchLevelScreen.routeName;
        break;
      case 2:
        levelName = interCompCount == 0
            ? EmojiRelatedEmojiGame.routeName
            : ScratchLevelScreen.routeName;
        break;
    }

    final isLevelCompleted = await Navigator.pushNamed(context, levelName);
    final bool isLevelCompleted2 = isLevelCompleted;
    if (isLevelCompleted2 == null) return null;

    await Future.delayed(400.milliseconds);

    return await _isShowingIntermediateLevel(context, completedLevelCount);
  }
}
