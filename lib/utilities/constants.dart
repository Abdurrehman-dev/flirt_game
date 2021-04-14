import '../all_utilities.dart';
import 'size_config.dart';

const kBackgroundImage =
    Image(image: AssetImage('assets/images/welcome/hacker_bg.png'));
const kBigTopImage = Image(image: AssetImage('assets/images/welcome/top.png'));
const kCornerAssetImage = AssetImage('assets/images/home/top_right_corner.png');

// const kGradient = LinearGradient(colors: [Colors.kD, kPinkColor]);
final kBorderRadius = BorderRadius.circular(20);
const kHeaderSize = 250.0;
const kBoxShadow = const BoxShadow(
    color: Colors.black26,
    offset: const Offset(5, 5),
    blurRadius: 15,
    spreadRadius: -5);
final kPadding = getProportionateScreenWidth(20.0);
final kPaddingInsets = EdgeInsets.all(kPadding);

extension FontScaling on TextStyle {
  TextStyle get scaled => this.copyWith(fontSize: this.fontSize.sp);
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get capitalize => this.split(" ").map((str) => str.inCaps).join(" ");

  List<String> get splitFirstWord {
    final firstIndex = indexOf(' ');
    return [substring(0, firstIndex), substring(firstIndex)];
  }

  Color toColor() {
    final int startIndex = this.startsWith('0x') ? 2 : 0;
    final int value = int.parse(this.substring(startIndex), radix: 16);
    return Color(value);
  }
}

extension DurationExtension on Duration {
  String toTimeLater() {
    if (inSeconds == 0)
      return 'Immediately';
    else if (inSeconds < 60)
      return '$inSeconds seconds later';
    else if (inMinutes == 1)
      return '$inMinutes minute later';
    else if (inMinutes < 60)
      return '$inMinutes minutes later';
    else if (inHours == 1)
      return '$inHours hour later';
    else
      return '$inHours hours later';
  }
}
