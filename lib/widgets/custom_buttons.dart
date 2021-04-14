import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../all_utilities.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key,
    this.size = 64,
    @required this.iconSrc,
    this.color = Colors.white,
    this.iconColor = Colors.black,
    @required this.press,
  }) : super(key: key);

  final double size;
  final String iconSrc;
  final Color color, iconColor;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenWidth(size),
      width: getProportionateScreenWidth(size),
      child: FlatButton(
        padding: EdgeInsets.all(15 / 64 * size),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        color: color,
        onPressed: press,
        child: SvgPicture.asset(iconSrc, color: iconColor),
      ),
    );
  }
}

class RoundedButton2 extends StatelessWidget {
  const RoundedButton2({
    Key key,
    this.size = 80,
    @required this.iconData,
    this.color = Colors.white,
    this.iconColor = Colors.black,
    @required this.press,
  }) : super(key: key);

  final double size;
  final IconData iconData;
  final Color color, iconColor;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenWidth(size),
      width: getProportionateScreenWidth(size),
      child: FlatButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        color: color,
        onPressed: press,
        child: Icon(
          iconData,
          color: iconColor,
          size: 35,
        ),
      ),
    );
  }
}

class MyRaisedButton2 extends StatelessWidget {
  final String buttonTitle;
  final Function onTap;
  final Color color;

  MyRaisedButton2({@required this.buttonTitle, this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        buttonTitle,
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: AppTheme.primary),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.symmetric(vertical: kPadding / 2),
      color: color ?? Theme.of(context).buttonColor,
      onPressed: onTap ?? () => Navigator.pop(context),
    );
  }
}

class ContinueButton extends StatelessWidget {
  final Function(BuildContext) onPressed;

  const ContinueButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Container(
        height: 50.0,
        child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          const SizedBox(width: 16.0),
          Text(
            'Next',
            style: TextStyle(color: AppTheme.primary, fontSize: 18),
          ),
          const SizedBox(width: 8.0),
          Icon(Icons.navigate_next, size: 30.0, color: AppTheme.primary),
        ]),
      ),
      color: Colors.greenAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () => onPressed(context),
    );
  }
}

class MoreScreenButton extends StatelessWidget {
  final Function onPressed;
  MoreScreenButton({this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(kPadding / 2),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                spreadRadius: 1.0,
                offset: Offset(0, 3),
                color: AppTheme.kDirtyPurple)
          ],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
          color: AppTheme.kOrchid,
        ),
        child: Icon(Icons.menu, color: AppTheme.primary),
      ),
    );
  }
}
