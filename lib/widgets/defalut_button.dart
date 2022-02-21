import 'package:flutter/material.dart';
// import 'package:mayrasales/constants.dart';
import 'package:mayrasales/funstions.dart';

// import '../constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
    this.btnColor,
  }) : super(key: key);
  final String text;
  final Function press;
  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: btnColor,
        onPressed: press,
        child: Text(
          text,
          style: appTextStyle(
            FontWeight.bold,
            18.0,
            Colors.white,
          ),
          // style: TextStyle(
          //   fontSize: 18,
          //   color: Colors.white,
          //   fontFamily: "FCustomB",
          // ),
        ),
      ),
    );
  }
}
