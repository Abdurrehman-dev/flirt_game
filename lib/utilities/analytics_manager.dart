import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

/// If we are using named routes then mention this in each screen
/// Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => MyPage(),
//       settings: RouteSettings(name: 'MyPage'),
//     ),
//   );
// }
class AnalyticsManager {
  static const String _CLICK_EVENT = 'click_event';

  // Singleton instance code
  static final AnalyticsManager _instance = AnalyticsManager._();
  static AnalyticsManager get instance => _instance;
  AnalyticsManager._();

  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  logEvent(String name) => _analytics.logEvent(name: name);
}
