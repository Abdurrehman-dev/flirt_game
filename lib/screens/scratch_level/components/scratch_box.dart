import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scratcher/scratcher.dart';

import '../../../all_utilities.dart';
import 'scratch_game_provider.dart';

class ScratchBox extends StatefulWidget {
  ScratchBox(this.iconData);

  final IconData iconData;

  @override
  _ScratchBoxState createState() => _ScratchBoxState();
}

class _ScratchBoxState extends State<ScratchBox> {
  double opacity = 0.06;

  @override
  Widget build(BuildContext context) => _buildScratcher();

  Widget _buildScratcher() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final size = constraints.maxWidth / 3 - kPadding - 10;

        return Container(
          width: size,
          height: size,
          child: Scratcher(
            accuracy: ScratchAccuracy.medium,
            color: AppTheme.kEggShell,
            brushSize: 20,
            threshold: 40,
            onScratchStart: () => MyAudioPlayer.instance.playScratching(),
            onScratchEnd: () => MyAudioPlayer.instance.stopScratching(),
            onThreshold: () {
              MyAudioPlayer.instance.stopScratching();

              final provider = context.read<ScratchGameProvider>();
              final isSuccess = provider.boxScratched(context, widget.iconData);

              if (!isSuccess) MyAudioPlayer.instance.playTapFailed();

              setState(() => opacity = 1);
            },
            child: AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(seconds: 1),
              child: SizedBox(
                width: size,
                height: size,
                child: FittedBox(child: FaIcon(widget.iconData)),
              ),
            ),
          ),
        );
      },
    );
  }
}
