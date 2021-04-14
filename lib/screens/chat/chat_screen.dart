import '../../all_utilities.dart';
import 'components/chat_app_bar.dart';
import 'components/chat_list_widget.dart';
import 'components/chat_options_panel.dart';
import 'components/chat_provider.dart';
import 'components/level_title_panel.dart';
import 'components/typing_panel.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = "/ChatScreen";
  @override
  Widget build(BuildContext context) {
    final ChatLevel level = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: ChatHeaderWidget(level.botName, level.botImg),
      body: ListenableProvider(
        create: (context) => ChatProvider(level),
        builder: (context, Widget child) => _buildBody(context, level),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ChatLevel level) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            Expanded(child: ChatListWidget(level)),
            TypingPanel(),
            ChatOptionsPanel(),
          ],
        ),
        BannerAdvertisement(
            anchorTypeMargin: -SizeConfig.safeAreaPaddingBottom / 2),
        ControlLevelTitlePanel(),
      ],
    );
  }
}
