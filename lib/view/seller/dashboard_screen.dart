import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';
import 'dart:core';
import 'package:recase/recase.dart';

import 'package:mayrasales/model/userpreferences.dart';

class VendorDashboard extends StatefulWidget {
  // final Color _primaryColor;
  // final Color _secondaryColor;

  // VendorDashboard(this._primaryColor, this._secondaryColor);

  @override
  _VendorDashboardState createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoggedIn = false;
  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    var loginStatus = await UserPreferences.getLoginStatus();

    // print('loginStatus = $loginStatus');
    if (loginStatus) {
      var un = await UserPreferences.getUsername();
      var em = await UserPreferences.getEmail();
      setState(() {
        isLoggedIn = loginStatus;
        userName = un;
        userEmail = em;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate(
            'str_mayra',
          ),
          style: appTextStyle(
            FontWeight.w500,
            20.0,
            Colors.white,
          ),
        ),
        flexibleSpace: Container(
          height: 100,
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
            color: kGradientPrimary,
          ),
        ),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.notifications),
          //   onPressed: () {},
          // ),
          // IconButton(
          //   icon: Icon(Icons.shopping_cart),
          //   onPressed: () async {
          //     bool userLoggedIn = await UserPreferences.getLoginStatus();
          //     if (userLoggedIn) {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => Cart(),
          //         ),
          //       );
          //     } else {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => Login(
          //               titlePage: AppLocalizations.of(context)
          //                   .translate('str_user_login')),
          //         ),
          //       );
          //     }
          //   },
          // ),
          // IconButton(
          //   icon: Icon(Icons.home),
          //   onPressed: () async {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => MainScreen(),
          //       ),
          //     );
          //   },
          // )
        ],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              padding: EdgeInsets.all(
                16.0,
              ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GFAvatar(
                    radius: 33.0,
                    backgroundColor: kLogoPurple,
                    child: GFAvatar(
                      radius: 32.0,
                      backgroundColor: Colors.black.withOpacity(0.5),
                      // borderRadius: BorderRadius.all(Radius.circular(16)),

                      backgroundImage: AssetImage(
                        "assets/icons/logo.png",
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Container(
                        width: double.infinity,
                        child: Text(
                          userName.titleCase,
                          style: appTextStyle(
                            FontWeight.bold,
                            16.0,
                            Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          userEmail,
                          style: appTextStyle(
                            FontWeight.w500,
                            14.0,
                            Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context).translate('str_home'),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kTextColor,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Divider(
                    color: kDefaultColor2,
                  ),
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context).translate('str_my_profile'),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kTextColor,
                      ),
                    ),
                    onTap: () async {
                      Navigator.pop(context);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => Profile(),
                      //   ),
                      // );
                    },
                  ),
                  ListTile(
                    //leading: Icon(Icons.home),
                    title: Text(
                      AppLocalizations.of(context).translate('str_orders'),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kTextColor,
                      ),
                    ),
                    onTap: () async {
                      Navigator.pop(context);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => Orders(),
                      //   ),
                      // );
                    },
                  ),
                  Divider(
                    color: kDefaultColor2,
                  ),
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context).translate('str_about_us'),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kTextColor,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => AppAboutUs(),
                      //   ),
                      // );
                    },
                  ),
                  ListTile(
                    //leading: Icon(Icons.home),
                    title: Text(
                      AppLocalizations.of(context).translate('str_settings'),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kTextColor,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => SettingsPage(),
                      //   ),
                      // );
                    },
                  ),
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context).translate('str_logout'),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kTextColor,
                      ),
                    ),
                    onTap: () async {
                      UserPreferences.logout();

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => Wishlist(),
                      //   ),
                      // );
                    },
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 4.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        padding: EdgeInsets.all(8),
                        icon: new Image.asset('assets/icons/ic_facebook.png'),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        padding: EdgeInsets.all(8),
                        icon: new Image.asset('assets/icons/ic_instagram.png'),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        padding: EdgeInsets.all(8),
                        icon: new Image.asset('assets/icons/ic_twitter.png'),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        padding: EdgeInsets.all(8),
                        icon: new Image.asset('assets/icons/ic_youtube.png'),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: FadedSlideAnimation(
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Hello, ',
                                    style: appTextStyle(
                                      FontWeight.w500,
                                      16.0,
                                      kTextColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${userName.titleCase}',
                                    style: appTextStyle(
                                      FontWeight.bold,
                                      16.0,
                                      kTextColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' !',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GFAvatar(
                            radius: 24.0,
                            backgroundColor: kLogoPurple,
                            child: GFAvatar(
                              radius: 23.0,
                              backgroundColor: Colors.white.withOpacity(1),
                              // borderRadius: BorderRadius.all(Radius.circular(16)),

                              backgroundImage: AssetImage(
                                "assets/icons/logo.png",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  height: 88,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 2,
                          child: InkWell(
                            splashColor: kGradientPrimary,
                            focusColor: kGradientPrimary,
                            hoverColor: kGradientPrimary,
                            // overlayColor: kGradientPrimary,
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/icons/my_products.png",
                                    height: 40,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('str_products'),
                                      style: appTextStyle(
                                        FontWeight.bold,
                                        14.0,
                                        kTextColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/icons/my_orders.png",
                                  height: 40,
                                ),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('str_orders'),
                                    style: appTextStyle(
                                      FontWeight.bold,
                                      14.0,
                                      kTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/icons/gear.png",
                                  height: 40,
                                ),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('str_settings'),
                                    style: appTextStyle(
                                      FontWeight.bold,
                                      14.0,
                                      kTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // child: Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage(
        //         "assets/images/bg.png",
        //       ),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
