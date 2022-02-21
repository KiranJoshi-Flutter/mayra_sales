import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';
import 'package:mayrasales/model/login_model.dart';
import 'package:mayrasales/model/user_login_model.dart';
import 'package:mayrasales/model/userdetails_model.dart';
import 'package:mayrasales/model/userpreferences.dart';
import 'package:mayrasales/model/vendor_login_model.dart';
import 'package:mayrasales/view/home_screen.dart';
import 'package:mayrasales/view/seller/dashboard_screen.dart';
import 'package:mayrasales/view/signup.dart';
import 'package:mayrasales/widgets/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:owesome_validator/owesome_validator.dart';

class Login extends StatefulWidget {
  final String titlePage;

  const Login({Key key, this.titlePage}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisible;

  UserPreferences userPreferences = UserPreferences();

  Drawer drawer;

  ProgressDialog pr;

  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  Widget build(BuildContext context) {
    pr = ProgressDialog(context);

    pr.style(
//      message: 'Downloading file...',
      message: AppLocalizations.of(context).translate('str_signning_in'),
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      progressWidgetAlignment: Alignment.center,
      maxProgress: 100.0,
      // progressWidget: Container(
      //     padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    return Scaffold(
      appBar: buildAppBar(
        context,
        "Login",
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kGradientPrimary,
              kGradientSecondary,
              kGradientTertiary,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 75.0,
                      child: Image.asset(
                        "assets/icons/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context).translate('str_mayra'),
                      //textAlign: Alignment.center,
                      style: appTextStyle(
                        FontWeight.w600,
                        36.0,
                        Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 32,
                      left: 32,
                      bottom: 16,
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 32,
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: appTextStyle(
                                  FontWeight.w500,
                                  16.0,
                                  Colors.white,
                                ),
                                cursorColor: Colors.white,
                                autofocus: false,
                                decoration: new InputDecoration(
                                  labelText: AppLocalizations.of(context)
                                      .translate('str_enter_email'),
                                  labelStyle: appTextStyle(
                                    FontWeight.w500,
                                    16.0,
                                    Colors.white,
                                  ),
                                  hintStyle: appTextStyle(
                                    FontWeight.w500,
                                    16.0,
                                    Colors.white,
                                  ),
                                  icon: Icon(
                                    Ionicons.ios_mail,
                                    color: Colors.white,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                controller: emailController,
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                style: appTextStyle(
                                  FontWeight.w500,
                                  16.0,
                                  Colors.white,
                                ),
                                obscureText: passwordVisible,
                                cursorColor: Colors.white,
                                autofocus: false,
                                decoration: new InputDecoration(
                                  labelText: AppLocalizations.of(context)
                                      .translate('str_enter_password'),
                                  labelStyle: appTextStyle(
                                    FontWeight.w500,
                                    16.0,
                                    Colors.white,
                                  ),
                                  hintStyle: appTextStyle(
                                    FontWeight.w500,
                                    16.0,
                                    Colors.white,
                                  ),
                                  icon: new Icon(
                                    Ionicons.md_key,
                                    color: Colors.white,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      passwordVisible
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(
                                        () {
                                          passwordVisible = !passwordVisible;
                                        },
                                      );
                                    },
                                  ),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                controller: passController,
                              ),
                              SizedBox(height: 16.0),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        // Text(
                        //   "",
                        //   style: TextStyle(color: Colors.grey),
                        // ),
                        TextButton(
                          onPressed: () {
                            /*...*/
                            // Toast.show("Forgot Password ..........", context,
                            //     duration: Toast.LENGTH_SHORT,
                            //     gravity: Toast.BOTTOM);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ForgotPassword(),
                            //   ),
                            // );
                          },
                          child: Text(
                            '${AppLocalizations.of(context).translate('str_forgot_password')} ?',
                            style: appTextStyle(
                              FontWeight.w500,
                              14.0,
                              Colors.white,
                            ),
                          ),
                        ),

                        GFButton(
                          focusColor: kGradientSecondary,
                          color: kGradientPrimary,
                          onPressed: () {
                            userLogin();
                          },
                          text: AppLocalizations.of(context)
                              .translate('str_login'),
                          textStyle: appTextStyle(
                            FontWeight.bold,
                            18.0,
                            Colors.white,
                          ),
                          shape: GFButtonShape.standard,
                          fullWidthButton: true,
                          hoverColor: kGradientSecondary,
                          size: GFSize.LARGE,
                        ),

                        Container(
                          margin: new EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .translate('str_not_registered_yet'),
                                //textAlign: Alignment.center,
                                // style: TextStyle(
                                //     color: Colors.white,
                                //     fontSize: 16,
                                //     fontFamily: 'Poppins',
                                //     fontWeight: FontWeight.w500),
                                style: appTextStyle(
                                  FontWeight.w500,
                                  16.0,
                                  Colors.white,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUp(),
                                    ),
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('str_sign_up_now'),
                                  style: appTextStyle(
                                    FontWeight.bold,
                                    16.0,
                                    kPriceColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 28,
                        // ),
                        // Text(
                        //   AppLocalizations.of(context)
                        //       .translate('str_continue_with_social_media'),
                        //   style: TextStyle(color: Colors.white70),
                        // ),
                        // SizedBox(
                        //   height: 8,
                        // ),
                        // Column(
                        //   children: <Widget>[
                        //     Padding(
                        //       padding: EdgeInsets.symmetric(horizontal: 0),
                        //       child: SignInButton(
                        //         Buttons.Facebook,
                        //         text: AppLocalizations.of(context)
                        //             .translate('str_continue_with_facebook'),
                        //         onPressed: () {},
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       height: 0,
                        //     ),
                        //     Padding(
                        //       padding: EdgeInsets.symmetric(horizontal: 0),
                        //       child: SignInButton(
                        //         Buttons.GoogleDark,
                        //         text: AppLocalizations.of(context)
                        //             .translate('str_continue_with_google'),
                        //         onPressed: () {},
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  userLogin() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    // var email = (emailController.text);

    final String email = emailController.text.trim();
    final String password = passController.text;

    var isValidEmail =
        OwesomeValidator.email(email, OwesomeValidator.patternEmail);

    if (isValidEmail) {
      if (password.isNotEmpty) {
        final snackBar = ScaffoldMessenger.of(context).showSnackBar(
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
                Text(
                  'Logging In.....',
                  style: appTextStyle(
                    FontWeight.bold,
                    16.0,
                    Colors.white,
                  ),
                ),
              ],
            ),
            duration: Duration(hours: 1),
          ),
        );

        var request = http.Request(
          'POST',
          Uri.parse(
            '$baseURL/user/login?email=$email&password=$password',
          ),
        );

        http.StreamedResponse response = await request.send();

        print(response.statusCode.toString());

        if (response.statusCode == 200) {
          snackBar.close();
          var res = await response.stream.bytesToString();

          print(res);
          Map<String, dynamic> resJSON = jsonDecode(res);

          var resData = json.encode(resJSON['data']);
          // print(resJSON['data']);

          // print(json
          //     .decode(resData)
          //     .containsKey("user_type"));

          if (json.decode(resData).containsKey("user_type")) {
            VendorLoginModel vendorLoginModel = vendorLoginModelFromJson(res);

            UserPreferences.setLoginStatus(true);
            UserPreferences.setLoginStatus(true);
            UserPreferences.setEmail(email);
            UserPreferences.setPassword(password);

            UserPreferences.setUserType(vendorLoginModel.data.userType);

            UserPreferences.setUsername(vendorLoginModel.data.name);

            UserPreferences.setToken(
              vendorLoginModel.data.token,
            );
            toastMessage(
              'Logged in successfully.',
              kLogoGreen,
              context,
            );
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => VendorDashboard(),
                ),
                ModalRoute.withName('/'),
              );
            });
          } else {
            LoginModel loginModel = loginModelFromJson(res);

            UserPreferences.setLoginStatus(true);
            UserPreferences.setEmail(email);
            UserPreferences.setPassword(password);
            UserPreferences.setUserType('user');
            UserPreferences.setUsername(loginModel.data.name);

            UserPreferences.setToken(
              loginModel.data.token,
            );

            toastMessage(
              'Logged in successfully.',
              kLogoGreen,
              context,
            );
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => NHomeScreen(),
                ),
                ModalRoute.withName('/'),
              );
            });
          }
        } else {
          snackBar.close();
          toastMessage(
            AppLocalizations.of(context)
                .translate('str_invalid_email_password'),
            kLogoRed,
            context,
          );

          print(response.reasonPhrase);
        }
      } else {
        toastMessage(
          AppLocalizations.of(context).translate('str_invalid_password'),
          kLogoRed,
          context,
        );
      }
    } else {
      toastMessage(
        AppLocalizations.of(context).translate('str_invalid_email'),
        kLogoRed,
        context,
      );
    }

    // print('isValidEmail = ${isValidEmail}');
  }

  Future<UserDetailsModel> userDetails(
      String apitoken, BuildContext context) async {
    final String url =
        "https://mayrasales.com/api/user/details?api_token=" + apitoken;

    //print(url);

    final response = await http.get(url);

    if (response.statusCode > 199 && response.statusCode < 300) {
      UserPreferences.setCookies(response.headers['set-cookie']);
      await pr.hide();
      final String responseString = response.body;

      //print("Response body " + responseString);

      return userDetailsModelFromJson(responseString);
    } else {
      await pr.hide();
      //print("Response Code = " + response.statusCode.toString());
    }
  }
}

AwesomeDialog awesomeAlertDialog(BuildContext context, String title, String msg,
    DialogType dialogType, VoidCallback onOkPress) {
  return AwesomeDialog(
    context: context,
    dialogType: dialogType,
    headerAnimationLoop: false,
    animType: AnimType.TOPSLIDE,
    title: title,
    desc: msg,
    // btnCancelOnPress: () {},
    //btnOkOnPress: onOkPress,
    autoHide: Duration(seconds: 3),
  )..show();
}
