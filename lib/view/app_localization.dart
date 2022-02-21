import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';

class AppLocalization extends StatefulWidget {
  @override
  _AppLocalizationState createState() => _AppLocalizationState();
}

class _AppLocalizationState extends State<AppLocalization> {
  String ut;
  String appName;
  String appID;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Localization"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffff85b2), Color(0xffa797ff), Color(0xff00e5ff)],
            ),
          ),
        ),
        actions: [
          //IconButton(icon: Icon(Icons.edit), onPressed: () {}),
        ],
      ),

      body: SingleChildScrollView(
        //physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context).translate('first_string'),
                  // 'Hello there !',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context).translate('second_string'),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Expanded(
            //   child: Center(
            //     child: RaisedButton.icon(
            //       color: Colors.blueAccent,
            //       textColor: Colors.white,
            //       icon: Icon(Icons.share),
            //       label: Text("Share App"),
            //       onPressed: () {
            //         shareApp();
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      //backgroundColor: Colors.grey.shade500,
    );
  }
}
