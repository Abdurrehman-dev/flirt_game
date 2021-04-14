import '../../../all_utilities.dart';
import 'chat_provider.dart';

class ChatOptionsPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final bannerHeight = BannerAdvertisement.BANNER_SIZE_USED.height.toDouble();
    final bottomSafeArea = SizeConfig.safeAreaPaddingBottom / 2;
    print('bottom safe area: $bottomSafeArea');
    // print('bannerHeight: $bannerHeight');

    return Container(
      constraints: BoxConstraints(
          minHeight: 200, maxHeight: 400, minWidth: double.infinity),
      color: AppTheme.kOrchid,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 10,
          // bottom: bannerHeight + 4 + bottomSafeArea,
        ),
        child: _buildOptions(context),
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (BuildContext context, model, Widget child) {
        final options = model.getNextOptions() ?? [];
        if (options.isEmpty) return SizedBox();

        final List<RaisedButton> optionButtonList = [];
        for (int i = 0; i < options.length; i++) {
          final option = _buildOptionButton(context, options[i]);
          optionButtonList.add(option);
        }

        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: optionButtonList);
      },
    );
  }

  RaisedButton _buildOptionButton(BuildContext context, String text) {
    Color color;
    if (ChatLevel.isLie(text)) {
      color = AppTheme.kSalmon;
    } else if (ChatLevel.isTruth(text)) {
      color = AppTheme.kSlimeGreen;
    } else {
      color = AppTheme.primaryDark;
    }

    return RaisedButton(
      padding: const EdgeInsets.all(8),
      color: color,
      onPressed: () => _onClickOption(context, text),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(fontWeight: FontWeight.bold, color: AppTheme.primary),
      ),
    );
  }

  _onClickOption(BuildContext context, String text) =>
      context.read<ChatProvider>().onOptionSelected(context, text);
}
