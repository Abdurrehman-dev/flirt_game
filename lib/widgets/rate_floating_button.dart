import 'package:in_app_review/in_app_review.dart';

import '../all_utilities.dart';

class RateFloatingButton extends StatefulWidget {
  const RateFloatingButton({
    Key key,
  }) : super(key: key);

  @override
  _RateFloatingButtonState createState() => _RateFloatingButtonState();
}

class _RateFloatingButtonState extends State<RateFloatingButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  static const _shake = 12.0;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    super.initState();

    Future.delayed(Duration(seconds: 2), () => controller.forward(from: 0.0));
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: _shake)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            }
          });

    final button = FloatingActionButton(
      onPressed: () => _showDialog(context),
      child: Icon(Icons.star, size: 30),
    );

    return AnimatedBuilder(
        animation: offsetAnimation,
        builder: (buildContext, child) {
          return Container(
            margin: const EdgeInsets.only(bottom: 50),
            padding: EdgeInsets.only(
                left: offsetAnimation.value + _shake,
                right: _shake - offsetAnimation.value),
            child: button,
          );
        });
  }

  static _showDialog(BuildContext context) {
    AnalyticsManager.instance.logEvent('showed_rate_us');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            'App Review',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.white),
          ),
          content: Text(
            'If you like our app, would you like to rate us on play store?',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Later',
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.of(context).pop();

                AnalyticsManager.instance.logEvent('clicked_rate_us_later');
              },
            ),
            FlatButton(
              child: Text('Rate Us'),
              onPressed: () {
                AnalyticsManager.instance.logEvent('clicked_rate_us');

                final InAppReview inAppReview = InAppReview.instance;
                inAppReview.openStoreListing(appStoreId: Strings.appStoreID);
              },
            ),
          ],
        );
      },
    );
  }
}
