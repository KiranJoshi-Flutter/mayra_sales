import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/model/userpreferences.dart';
import 'package:mayrasales/view/home_screen.dart';
import 'package:mayrasales/view/homepage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mayrasales/view/login.dart';
import 'package:mayrasales/view/seller/dashboard_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:splashscreen/splashscreen.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String appLanguage = '';
  Locale _locale;
  String userType = '';

  // FirebaseMessaging messaging;

  @override
  void initState() {
    _loadLangPref();
    init();
    super.initState();
    //_dark = false;
  }

  init() async {
    var ut = await UserPreferences.getUserType();
    setState(() {
      userType = ut;
    });
    print(userType);
  }

  _loadLangPref() async {
    try {
      // FirebaseMessaging messaging = FirebaseMessaging.instance;
      // var token = await messaging.getToken();
      // print("token $token");

//       await messaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );

//       FirebaseMessaging.onMessage.listen(
//         (RemoteMessage message) {
//           // // print('Got a message whilst in the foreground!');
//           // // print('Message data: ${message.data.entries}');
// //
//           if (message.notification != null) {
//             // print('Notification Title: ${message.notification!.title}');
//           }
//         },
//       );
    } on Exception catch (exception) {
      // print(exception);
    } catch (error) {
      // print(error);
    }

    appLanguage = await UserPreferences.getLanguagePreference();
    if (appLanguage == "ne") {
      setLocale(Locale.fromSubtags(languageCode: 'ne'));
    }
    _locale = Locale.fromSubtags(languageCode: appLanguage);
    print("appLanguageM" + appLanguage);

    return appLanguage;
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale.fromSubtags(languageCode: 'ne'),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback:
            (Locale locale, Iterable<Locale> supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }

          return supportedLocales.first;
        },
        locale: _locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.muktaTextTheme(),
          // primaryColor: kGradientPrimary,
        ),
        home: userType == 'user' ? NHomeScreen() : VendorDashboard(),
      ),
    );
  }
}
