import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';

class AppAboutUs extends StatefulWidget {
  @override
  _AppAboutUsState createState() => _AppAboutUsState();
}

class _AppAboutUsState extends State<AppAboutUs> {
  String ut;
  String appName;
  String appID;

  @override
  void initState() {
    super.initState();
    prepareInfo();
  }

  void prepareInfo() async {
    PackageInfo pInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = pInfo.appName;
      appID = pInfo.packageName;
    });
  }

  Future<void> shareApp() async {
    await FlutterShare.share(
      chooserTitle: "Share $appName",
      title: appName,
      text: 'Introducing the Flutter Code Examples app.',
      linkUrl: 'https://play.google.com/store/apps/details?id=$appID',
    );
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('str_about_us'),
          style: appTextStyle(
            FontWeight.w500,
            20.0,
            Colors.white,
          ),
        ),
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
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            _buildInfo1(),
            //_buildInfo2(),
            _buildInfo3(),
          ],
        ),
      ),
      //backgroundColor: Colors.grey.shade500,
    );
  }

  Widget _buildInfo1() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xffff85b2),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/icons/logo.png',
                      ),
                      radius: 28,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Mayra Sales'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("Version"),
                subtitle: Text("1.0"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.cached),
                title: Text("Changelog"),
              ),
              Divider(),
              ListTile(
                  leading: Icon(Icons.offline_pin), title: Text("License")),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfo2() {
    return Container(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Author',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text("Omar & Nabil"),
                    subtitle: Text("Syria"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.file_download),
                    title: Text("Download From Cloud"),
                  ),
                ],
              )),
        ));
  }

  Widget _buildInfo3() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Company',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text(AppLocalizations.of(context)
                      .translate('str_mayra_sales_pvt')),
                  //subtitle: Text("Ecommerce"),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text(
                      AppLocalizations.of(context).translate('str_location')),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.call),
                  title: Text(AppLocalizations.of(context)
                      .translate('str_contact_number_ms')),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.alternate_email),
                  title: Text("mayaratechnology@gmail.com"),
                ),
                // RaisedButton.icon(
                //   color: Colors.blueAccent,
                //   textColor: Colors.white,
                //   icon: Icon(Icons.share),
                //   label: Text("Share App"),
                //   onPressed: () {
                //     shareApp();
                //   },
                // ),

                const Padding(padding: EdgeInsets.only(top: 24.0)),
                Builder(
                  builder: (BuildContext context) {
                    return RaisedButton.icon(
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      icon: Icon(Icons.share),
                      label: const Text('Share'),
                      onPressed: () {
                        // A builder is used to retrieve the context immediately
                        // surrounding the RaisedButton.
                        //
                        // The context's `findRenderObject` returns the first
                        // RenderObject in its descendent tree when it's not
                        // a RenderObjectWidget. The RaisedButton's RenderObject
                        // has its position and size after it's built.
                        final RenderBox box = context.findRenderObject();
                        Share.share(
                            "https://play.google.com/store/apps/details?id=com.tencent.ig",
                            subject: "Share Application",
                            sharePositionOrigin:
                                box.localToGlobal(Offset.zero) & box.size);
                      },
                    );
                  },
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
            )),
      ),
    );
  }
}
