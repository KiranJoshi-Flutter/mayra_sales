import 'package:flutter/material.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/getwidget.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';

Widget _customDivider(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(left: 0.0, right: 0.0),
    height: 0.5,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          kGradientPrimary,
          kGradientSecondary,
          kGradientTertiary,
        ],
      ),
    ),
  );
}

AppBar buildAppBar(BuildContext context, String name) {
  return AppBar(
    //iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
    titleSpacing: 0.0,
    elevation: 0.5,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            kGradientPrimary,
            kGradientSecondary,
            kGradientTertiary,
          ],
        ),
      ),
    ),
    title: Text(
      name,
      style: appTextStyle(
        FontWeight.w500,
        20.0,
        Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

toastMessage(String msg, Color bgColor, BuildContext context) {
  return GFToast.showToast(
    msg,
    context,
    toastPosition: GFToastPosition.BOTTOM,
    textStyle: appTextStyle(
      FontWeight.w500,
      14.0,
      Colors.white,
    ),
    backgroundColor: bgColor,
    toastDuration: 2,
  );
}

snackBarMessage(BuildContext context, String message, Duration duration) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: kGradientPrimary,
            backgroundColor: kGradientSecondary,
            strokeWidth: 1.5,
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Text(
              message,
              style: appTextStyle(
                FontWeight.bold,
                14.0,
                Colors.white,
              ),
            ),
          ),
        ],
      ),
      duration: duration,
    ),
  );
}

snackBarMessageWithAction(BuildContext context, String message,
    Duration duration, String label, Function onCLick) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              message,
              style: appTextStyle(
                FontWeight.normal,
                14.0,
                Colors.white,
              ),
            ),
          ),
        ],
      ),
      duration: duration,
      action: SnackBarAction(
        label: label,
        textColor: kLogoOrange,
        onPressed: onCLick,
      ),
    ),
  );
}

customDivider(double divHeight) {
  return Container(
    height: divHeight,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          kGradientPrimary,
          kGradientSecondary,
          kGradientTertiary,
        ],
      ),
    ),
  );
}
