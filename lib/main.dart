import 'package:flutter/material.dart';

import 'all_screens.dart';
import 'all_utilities.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeData = ThemeData.light();

    final app = MaterialApp(
      title: 'Fake Call',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      navigatorObservers: [AnalyticsManager.instance.observer],
      theme: themeData.copyWith(
        backgroundColor: AppTheme.primary,
        scaffoldBackgroundColor: AppTheme.primary,
        primaryColor: AppTheme.primary,
        primaryColorDark: AppTheme.kAzure,
        accentColor: AppTheme.primaryDark,
        textTheme: themeData.textTheme.copyWith(
          headline4: themeData.textTheme.headline4.copyWith(fontSize: 32),
          bodyText1: themeData.textTheme.bodyText1
              .copyWith(color: AppTheme.kDirtyPurple),
          bodyText2: themeData.textTheme.bodyText2
              .copyWith(color: AppTheme.kDirtyPurple),
        ),
        appBarTheme: themeData.appBarTheme.copyWith(
            elevation: 0,
            centerTitle: false,
            textTheme: TextTheme(
                headline6: themeData.textTheme.headline6.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.kDirtyPurple))),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: WelcomeScreen.routeName,
      routes: routes,
    );
    return ScreenUtilInit(
      designSize: Size(414.0, 736.0),
      allowFontScaling: false,
      builder: () => app,
    );
  }
}
