import '../../all_utilities.dart';

class Emoji extends StatelessWidget {
  const Emoji({Key key, this.emoji}) : super(key: key);

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Text(
        emoji ?? ' ',
        style: TextStyle(color: Colors.black, fontSize: 60),
      ),
    );
  }
}
