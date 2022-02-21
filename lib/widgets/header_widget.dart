import 'package:flutter/material.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';

class HeaderWidget extends StatefulWidget {
  HeaderWidget({
    Key key,
    this.title,
    Key key2,
    this.onClick,
  }) : super(key: key);

  final String title;
  final Function onClick;

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black45,
      padding: EdgeInsets.symmetric(
        vertical: 0.0,
        horizontal: 16.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.title,
              style: appTextStyle(
                FontWeight.w600,
                18.0,
                kTextColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: widget.onClick,
            child: Text(
              AppLocalizations.of(context).translate(
                'str_view_all',
              ),
              style: appTextStyle(
                FontWeight.bold,
                14.0,
                kGradientPrimary.withOpacity(0.75),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
