import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../all_utilities.dart';
import 'app_info.dart';

class NotificationManager {
  static final NotificationManager _instance = NotificationManager._internal();
  static NotificationManager get instance => _instance;

  factory NotificationManager() {
    return _instance;
  }
  NotificationManager._internal();

  static final androidDetails = AndroidNotificationDetails(
      AppInfo.instance.packageName,
      AppInfo.instance.appName,
      'Our notifications will be displayed here',
      importance: Importance.max,
      // priority: Priority.high,
      showWhen: false);

  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  init() {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const androidSettings = AndroidInitializationSettings('app_icon');
    final iOSSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    final settings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);
    _flutterLocalNotificationsPlugin.initialize(settings,
        onSelectNotification: _onSelectNotification);

    tz.initializeTimeZones();
  }

  Future _onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    print('NAB $payload');
  }

  Future _onSelectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    }
    print('NAB $payload');
  }

  scheduleAllNotifications() async {
    await _cancelAllNotifications();

    List<String> notificationBody = [
      'Anna wants to talk to you! tab to see what she want to see',
      'Anna is looking for you, text her.',
      'Hey it\'s anna lets go for a date.',
      'Where do you wanna go for the trip?',
    ];

    for (int i = 0; i < 32; i++) {
      _scheduleNotificationDaily(
          NotificationModel(
              id: i,
              title: AppInfo.instance.appName,
              body: notificationBody[i % 4]),
          Duration(days: i + 1));
    }
  }

  Future<void> _scheduleNotificationDaily(
      NotificationModel model, Duration duration) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        model.id,
        model.title,
        model.body,
        tz.TZDateTime.now(tz.local).add(duration),
        NotificationDetails(android: androidDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> _scheduleNotificationPeriodically(
      NotificationModel model) async {
    await _flutterLocalNotificationsPlugin.periodicallyShow(
        model.id,
        model.title,
        model.body,
        RepeatInterval.daily,
        NotificationDetails(android: androidDetails),
        androidAllowWhileIdle: true);
  }

  Future<void> _cancelAllNotifications() =>
      _flutterLocalNotificationsPlugin.cancelAll();
}

class NotificationModel {
  NotificationModel({
    @required this.id,
    @required this.title,
    @required this.body,
    this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}
