import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({
    Key key,
    this.whenTimeExpires,
  }) : super(key: key);

  final Function whenTimeExpires;

  State createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Duration _duration;

  String get timerDisplayString {
    Duration duration = _controller.duration * _controller.value;
    return formatHHMMSS(duration.inSeconds);
  }

  String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  @override
  void initState() {
    super.initState();
    _duration = Duration(hours: 200);
    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    );
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        print('done');
        widget.whenTimeExpires();
      }
    });
  }

  // @override
  // void didUpdateWidget(CountDownTimer oldWidget) {
  // if (widget.secondsRemaining != oldWidget.sta) {
  //   setState(() {
  //     _duration = new Duration(seconds: widget.secondsRemaining);
  //     _controller.dispose();
  //     _controller = new AnimationController(
  //       vsync: this,
  //       duration: _duration,
  //     );
  //     _controller.forward(from: widget.secondsRemaining.toDouble());
  //     _controller.addStatusListener((status) {
  //       if (status == AnimationStatus.completed) {
  //         widget.whenTimeExpires();
  //       } else if (status == AnimationStatus.dismissed) {
  //         print("Animation Complete");
  //       }
  //     });
  //   });
  // }
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: AnimatedBuilder(
            animation: _controller,
            builder: (_, Widget child) {
              return Text(
                timerDisplayString,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.white),
              );
            }));
  }
}
