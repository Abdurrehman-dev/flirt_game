import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flirt/utilities/notification_manager.dart';

import '../../all_screens.dart';
import '../../all_utilities.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = "/WelcomeScreen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    _initializeEveryThing();
  }

  _initializeEveryThing() async {
    await Future.wait([
      Firebase.initializeApp(),
      MyAudioPlayer.instance.init(),
      Prefs.instance.init(),
      AdManager.initAdManager(),
      AppInfo.instance.init(),
    ]);
    NotificationManager.instance.init();

    Prefs.instance.incrementAppLaunches();

    // Navigating to next Screen
    Timer(Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, HomeScreen.routeName));
  }

  @override
  void didChangeDependencies() {
    const imgSources = [
      "home_bg",
      "home_clouds",
      "home_top",
      "level_burst",
    ];
    final assetPictures = imgSources.map((imgSrc) =>
        precacheImage(AssetImage('assets/images/home/$imgSrc.png'), context));

    Future.wait(assetPictures);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            'assets/images/welcome/sp_logo.png',
            height: 190.h,
          ),
          CircularProgressIndicator(),
          SizedBox(height: 40.h),
          Image.asset(
            'assets/images/welcome/splash.png',
            height: 0.5.sh,
            width: 1.sw,
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
          )
        ],
      ),
    );
  }
}
