import '../../../all_utilities.dart';
import 'chat_avatar.dart';

class ChatHeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final String imgSrc;

  ChatHeaderWidget(
    this.title,
    this.imgSrc, {
    Key key,
  })  : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackButton(
          color: AppTheme.kDirtyPurple,
          onPressed: () => _onBackPressed(context)),
      centerTitle: false,
      titleSpacing: 0,
      elevation: 5,
      title: Row(
        children: [
          ChatAvatar(imgSrc),
          HorizontalSpacing(of: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.headline6),
              VerticalSpacing(of: 3),
              Text('Active Now', style: Theme.of(context).textTheme.caption),
            ],
          ),
        ],
      ),
    );
  }

  _onBackPressed(BuildContext context) {
    MyAudioPlayer.instance.playButtonTap();

    Navigator.maybePop(context);
  }
}
