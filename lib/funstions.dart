// import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/cupertino.dart';
// import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

launchURL(String uri) async {
  var url = uri;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<bool> imageURLCheck(String url) async {
  final response = await http.head(url);

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

TextStyle appTextStyle(
    FontWeight fontWeight, double fontSize, Color textColor) {
  return GoogleFonts.mukta(
    textStyle: TextStyle(
      fontSize: fontSize,
      color: textColor,
      fontWeight: fontWeight,
      letterSpacing: 0.1,
    ),
  );
}

String generateRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}
