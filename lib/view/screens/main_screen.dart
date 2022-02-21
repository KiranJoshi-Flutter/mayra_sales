import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';
import 'package:mayrasales/view/screens/feed_screen.dart';
import 'package:mayrasales/view/screens/home_screen.dart';
import 'package:mayrasales/view/screens/notification_screen.dart';
import 'package:mayrasales/view/screens/profile_screen.dart';

//------------------------- MainScreen ----------------------------------

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _active = false;
  int _selectedNavItem = 0;
  String title = 'Mayra Sales';

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        HomeScreen(),
        FeedScreen(),
        NotificationScreen(),
        ProfileScreen(),
      ],
    );
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        title: Text(
          AppLocalizations.of(context).translate('str_explore'),
          style: GoogleFonts.mukta(
            textStyle: TextStyle(
              fontSize: 12.0,
              color: _selectedNavItem == 0 ? kGradientPrimary : kDefaultColor,
              fontWeight:
                  _selectedNavItem == 0 ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
        icon: SvgPicture.asset(
          'assets/icons/ic_explore.svg',
          color: _selectedNavItem == 0 ? kGradientPrimary : kDefaultColor,
          height: 25,
        ),
      ),
      BottomNavigationBarItem(
        title: Text(
          AppLocalizations.of(context).translate('str_feed'),
          style: GoogleFonts.mukta(
            textStyle: TextStyle(
              fontSize: 12.0,
              color: _selectedNavItem == 1 ? kGradientPrimary : kDefaultColor,
              fontWeight:
                  _selectedNavItem == 1 ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
        icon: SvgPicture.asset(
          'assets/icons/ic_feed.svg',
          color: _selectedNavItem == 1 ? kGradientPrimary : kDefaultColor,
          height: 25,
        ),
      ),
      BottomNavigationBarItem(
        title: Text(
          'Notification',
          style: GoogleFonts.mukta(
            textStyle: TextStyle(
              fontSize: 12.0,
              color: _selectedNavItem == 2 ? kGradientPrimary : kDefaultColor,
              fontWeight:
                  _selectedNavItem == 2 ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
        icon: SvgPicture.asset(
          'assets/icons/ic_notification.svg',
          color: _selectedNavItem == 2 ? kGradientPrimary : kDefaultColor,
          height: 25,
        ),
      ),
      BottomNavigationBarItem(
        title: Text(
          'Profile',
          style: GoogleFonts.mukta(
            textStyle: TextStyle(
              fontSize: 12.0,
              color: _selectedNavItem == 3 ? kGradientPrimary : kDefaultColor,
              fontWeight:
                  _selectedNavItem == 3 ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
        icon: SvgPicture.asset(
          'assets/icons/ic_profile.svg',
          color: _selectedNavItem == 3 ? kGradientPrimary : kDefaultColor,
          height: 25,
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      _selectedNavItem = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      _selectedNavItem = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    // title = AppLocalizations.of(context).translate('str_mayra');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kGradientPrimary,
        elevation: 0.5,
        title: Text(
          title,
          style: GoogleFonts.mukta(
            textStyle: TextStyle(
              fontSize: 20,
              // color: kTextColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight,
        //       colors: [
        //         kGradientPrimary,
        //         kGradientSecondary,
        //         kGradientTertiary,
        //       ],
        //     ),
        //   ),
        // ),
      ),
      body: buildPageView(),
      bottomNavigationBar: Container(
        // height: ,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedNavItem,
          items: buildBottomNavBarItems(),

          // backgroundColor: Colors.white,
          // selectedItemColor: kGradientPrimary,
          // unselectedItemColor: kDefaultColor,
          // selectedFontSize: 14,
          // unselectedFontSize: 14,
          onTap: (value) {
            // Respond to item press.

            print(value);

            setState(() {
              _selectedNavItem = value;

              if (value == 0) {
                setState(() {
                  title = AppLocalizations.of(context).translate('str_mayra');
                });
              } else if (value == 1) {
                // title = AppLocalizations.of(context).translate('str_feed');
                setState(() {
                  title = AppLocalizations.of(context).translate('str_feed');
                });
              } else if (value == 2) {
                title =
                    AppLocalizations.of(context).translate('str_notification');
              } else if (value == 3) {
                title = AppLocalizations.of(context).translate('str_profile');
              }
            });
            print(title);
            bottomTapped(value);
          },
          // items: [
          //   BottomNavigationBarItem(
          //     title: Text(
          //       AppLocalizations.of(context).translate('str_explore'),
          //       style: GoogleFonts.mukta(
          //         textStyle: TextStyle(
          //           fontSize: 12.0,
          // color: _selectedNavItem == 0
          //     ? kGradientPrimary
          //     : kDefaultColor,
          //           fontWeight: _selectedNavItem == 0
          //               ? FontWeight.w600
          //               : FontWeight.normal,
          //         ),
          //       ),
          //     ),
          //     icon: SvgPicture.asset(
          //       'assets/icons/ic_explore.svg',
          //       color: _selectedNavItem == 0 ? kGradientPrimary : kDefaultColor,
          //       height: 25,
          //     ),
          //   ),
          //   BottomNavigationBarItem(
          //     title: Text(
          //       AppLocalizations.of(context).translate('str_feed'),
          //       style: GoogleFonts.mukta(
          //         textStyle: TextStyle(
          //           fontSize: 12.0,
          //           color: _selectedNavItem == 1
          //               ? kGradientPrimary
          //               : kDefaultColor,
          //           fontWeight: _selectedNavItem == 1
          //               ? FontWeight.w600
          //               : FontWeight.normal,
          //         ),
          //       ),
          //     ),
          //     icon: SvgPicture.asset(
          //       'assets/icons/ic_feed.svg',
          //       color: _selectedNavItem == 1 ? kGradientPrimary : kDefaultColor,
          //       height: 25,
          //     ),
          //   ),
          //   BottomNavigationBarItem(
          //     title: Text(
          //       'Notification',
          //       style: GoogleFonts.mukta(
          //         textStyle: TextStyle(
          //           fontSize: 12.0,
          //           color: _selectedNavItem == 2
          //               ? kGradientPrimary
          //               : kDefaultColor,
          //           fontWeight: _selectedNavItem == 2
          //               ? FontWeight.w600
          //               : FontWeight.normal,
          //         ),
          //       ),
          //     ),
          //     icon: SvgPicture.asset(
          //       'assets/icons/ic_notification.svg',
          //       color: _selectedNavItem == 2 ? kGradientPrimary : kDefaultColor,
          //       height: 25,
          //     ),
          //   ),
          //   BottomNavigationBarItem(
          //     title: Text(
          //       'Profile',
          //       style: GoogleFonts.mukta(
          //         textStyle: TextStyle(
          //           fontSize: 12.0,
          //           color: _selectedNavItem == 3
          //               ? kGradientPrimary
          //               : kDefaultColor,
          //           fontWeight: _selectedNavItem == 3
          //               ? FontWeight.w600
          //               : FontWeight.normal,
          //         ),
          //       ),
          //     ),
          //     icon: SvgPicture.asset(
          //       'assets/icons/ic_profile.svg',
          //       color: _selectedNavItem == 3 ? kGradientPrimary : kDefaultColor,
          //       height: 25,
          //     ),
          //   ),
          // ],
        ),
      ),
    );
  }
}
