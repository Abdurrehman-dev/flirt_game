import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../all_utilities.dart';
import 'chat_provider.dart';

class TypingPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final senderName =
        context.select((ChatProvider provider) => provider.level.botName);
    return Selector<ChatProvider, bool>(
      selector: (context, model) => model.isTyping,
      builder: (BuildContext context, isTyping, Widget child) {
        return Visibility(
          visible: isTyping,
          child: PlayAnimation(
            duration: 200.milliseconds,
            tween: 0.0.tweenTo(1),
            builder: (_, animChild, value) {
              return Opacity(
                opacity: value,
                child: animChild,
              );
            },
            child: child,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Text(
              "$senderName is typing ",
            ),
            SpinKitThreeBounce(
              color: Theme.of(context).accentColor,
              size: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
