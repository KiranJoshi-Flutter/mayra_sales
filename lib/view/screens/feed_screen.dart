import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';

//------------------------- FeedScreen ----------------------------------

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool _active = false;
  int _selectedNavItem = 0;

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

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 100,
          color: kGradientPrimary,
          child: Text('Home'),
        ),
      ),
    );
  }
}
