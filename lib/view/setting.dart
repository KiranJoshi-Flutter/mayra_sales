import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/main.dart';
import 'package:mayrasales/model/userpreferences.dart';
import 'package:mayrasales/view/changepassword.dart';
import 'package:mayrasales/widgets/widgets.dart';
import 'package:smart_select/smart_select.dart';
// import 'package:smart_select/smart_select.dart';

class SettingsPage extends StatefulWidget {
  static final String path = "lib/src/pages/settings/settings1.dart";

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String appLanguage = UserPreferences.getLanguagePreference().toString();

  Future<String> fAppLanguage;

  String username = '';

  // List<SmartSelectOption<String>> options = [
  //   SmartSelectOption<String>(value: 'en', title: 'English'),
  //   SmartSelectOption<String>(value: 'ne', title: 'नेपाली'),
  // ];
  //bool _dark;

  @override
  void initState() {
    fAppLanguage = _loadLangPref();

    super.initState();
    //_dark = false;
  }

  Future<String> _loadLangPref() async {
    appLanguage = await UserPreferences.getLanguagePreference();
    username = await UserPreferences.getUsername();
    print("appLanguage" + appLanguage);

    return appLanguage;
  }

  // Brightness _getBrightness() {
  //   return _dark ? Brightness.dark : Brightness.light;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: _dark ? null : Colors.grey.shade200,
      appBar: buildAppBar(
        context,
        AppLocalizations.of(context).translate('str_settings'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Card(
                //   elevation: 8.0,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10.0)),
                //   color: Hexcolor("#ffa797ff"),
                //   child: ListTile(
                //     onTap: () {
                //       //open edit profile
                //     },
                //     title: Text(
                //       username,
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //     leading: CircleAvatar(
                //       backgroundImage: NetworkImage(
                //           "https://scontent.fktm1-2.fna.fbcdn.net/v/t1.0-1/p100x100/119225648_200665931405962_4949444025816031879_o.jpg?_nc_cat=107&_nc_sid=dbb9e7&_nc_ohc=atn3WVwd-9IAX_c1im2&_nc_ht=scontent.fktm1-2.fna&tp=6&oh=3b59f50fd1f3c641f023883ca5f2792c&oe=5F867D26"),
                //     ),
                //     trailing: Icon(
                //       Icons.edit,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                //const SizedBox(height: 10.0),
                Card(
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.lock_outline,
                          color: Color(0xffff85b2),
                        ),
                        title: Text(AppLocalizations.of(context)
                            .translate('str_change_password')),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          //open change password
                          //print("Change Password");

                          //Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePassword()));
                        },
                      ),
                      // _buildDivider(),
                      // GestureDetector(
                      //   onTap: () {

                      //   },
                      // ListTile(
                      //   leading: Icon(
                      //     FontAwesomeIcons.language,
                      //     color: Hexcolor("#ffff85b2"),
                      //   ),
                      //   title: Text("Change Language"),
                      //   trailing: Icon(Icons.keyboard_arrow_right),
                      //   onTap: () {
                      //     //open change language
                      //     print("Language Changed");

                      //     return SmartSelect<String>.single(
                      //       title: 'Frameworks',
                      //       value: value,
                      //       options: options,
                      //       onChange: (val) => setState(
                      //         () {
                      //           value = val;
                      //           print(value);
                      //         },
                      //       ),
                      //     );
                      //   },
                      // ),
                      // SmartSelect<String>.single(
                      //   title: AppLocalizations.of(context)
                      //       .translate('str_change_language'),
                      //   // leading: Icon(
                      //   //   FontAwesomeIcons.language,
                      //   //   color: Hexcolor("#ffff85b2"),
                      //   // ),
                      //   value: _appLanguage(),
                      //   options: options,
                      //   onChange: (val) => setState(
                      //     () {
                      //       Locale _temp;
                      //       appLanguage = val;
                      //       print("Lang = $appLanguage");
                      //       UserPreferences.setLanguagePreference(appLanguage);
                      //       switch (val) {
                      //         case 'en':
                      //           _temp = Locale(val, 'US');
                      //           break;
                      //         case 'ne':
                      //           _temp = Locale.fromSubtags(languageCode: 'ne');
                      //           break;
                      //         default:
                      //           _temp = Locale(val, 'US');
                      //       }

                      //       MyApp.setLocale(context, _temp);
                      //     },
                      //   ),
                      // )

                      FutureBuilder(
                          future: fAppLanguage,
                          builder: (context, snapshot) {
                            if (snapshot.data != "") {
                              return SmartSelect<String>.single(
                                choiceItems: [
                                  S2Choice<String>(
                                      value: 'en', title: 'English'),
                                  S2Choice<String>(value: 'ne', title: 'नेपाली')
                                ],
                                title: AppLocalizations.of(context)
                                    .translate('str_change_language'),
                                // leading: Icon(
                                //   FontAwesomeIcons.language,
                                //   color: Hexcolor("#ffff85b2"),
                                // ),
                                value: _appLanguage(),
                                // options: options,
                                onChange: (val) => setState(
                                  () {
                                    Locale _temp;
                                    appLanguage = val.value;
                                    print("Lang = $appLanguage");
                                    UserPreferences.setLanguagePreference(
                                        appLanguage);
                                    switch (val.value) {
                                      case 'en':
                                        _temp = Locale(val.value, 'US');
                                        break;
                                      case 'ne':
                                        _temp = Locale.fromSubtags(
                                            languageCode: 'ne');
                                        break;
                                      default:
                                        _temp = Locale(val.value, 'US');
                                    }

                                    MyApp.setLocale(context, _temp);
                                  },
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),

                      //),
                      //_buildDivider(),
                      // ListTile(
                      //   leading: Icon(
                      //     Icons.location_on,
                      //     color: Hexcolor("#ffff85b2"),
                      //   ),
                      //   title: Text("Change Location"),
                      //   trailing: Icon(Icons.keyboard_arrow_right),
                      //   onTap: () {
                      //     //open change location
                      //   },
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _appLanguage() {
    //var lan = UserPreferences.getLanguagePreference().toString();
    return appLanguage;
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
