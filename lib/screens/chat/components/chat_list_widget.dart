import 'package:flutter/scheduler.dart';

import '../../../all_utilities.dart';
import 'chat_provider.dart';
import 'message_widget.dart';

class ChatListWidget extends StatelessWidget {
  final ChatLevel level;
  final bool willSenderInitiateChat;

  ChatListWidget(this.level)
      : willSenderInitiateChat = level.willSenderInitiateChat;

  bool _isSender(int index) {
    if (willSenderInitiateChat) {
      return index % 2 == 0;
    } else {
      return index % 2 == 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (BuildContext context, model, Widget child) {
        final _scrollController = new ScrollController();
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.ease,
          );
        });

        return ListView.builder(
          controller: _scrollController,
          itemCount: model.messages.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return MessageWidget(
                _isSender(index), level, model.messages[index]);
          },
        );
      },
    );
  }
}
