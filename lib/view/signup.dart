import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mayrasales/constants.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';
import 'package:mayrasales/model/sign_up_model.dart';
import 'package:mayrasales/model/user_model.dart';
import 'package:mayrasales/view/homepage.dart';
import 'package:mayrasales/view/login.dart';
import 'package:mayrasales/widgets/widgets.dart';
import 'package:owesome_validator/owesome_validator.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool passwordVisible;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('str_sign_up'),
          style: appTextStyle(
            FontWeight.bold,
            20.0,
            Colors.white,
          ),
        ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 0,
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
                                      .translate('str_enter_full_name'),
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
                                    Icons.account_circle,
                                    color: Colors.white,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.next,
                                controller: nameController,
                              ),
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
                                  icon: new Icon(
                                    Ionicons.ios_mail,
                                    color: Colors.white,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
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
                                cursorColor: Colors.white,
                                autofocus: false,
                                decoration: new InputDecoration(
                                  labelText: AppLocalizations.of(context)
                                      .translate('str_contact_number'),
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
                                    Ionicons.ios_call,
                                    color: Colors.white,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                controller: phoneController,
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
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                controller: passController,
                              ),
                              SizedBox(height: 16.0),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        GFButton(
                          focusColor: kGradientSecondary,
                          color: kGradientPrimary,
                          onPressed: () async {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            // var email = (emailController.text);

                            final String email = emailController.text.trim();
                            final String password = passController.text;
                            final String name = nameController.text.trim();
                            final String contact = phoneController.text;

                            var isValidEmail = OwesomeValidator.email(
                                email, OwesomeValidator.patternEmail);

                            if (name.isNotEmpty) {
                              if (isValidEmail) {
                                if (password.isNotEmpty) {
                                  var isValidPassword =
                                      OwesomeValidator.password(
                                    password,
                                    OwesomeValidator
                                        .passwordMinLen8withCamelAndSpecialChar,
                                  );
                                  if (isValidPassword) {
                                    final snackBar =
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                      SnackBar(
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircularProgressIndicator(
                                              color: kGradientPrimary,
                                              backgroundColor:
                                                  kGradientSecondary,
                                              strokeWidth: 1.5,
                                            ),
                                            SizedBox(
                                              width: 16.0,
                                            ),
                                            Text(
                                              'Creating new account.....',
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
                                        '$baseURL/user/register?name=$name&email=$email&phone=$contact&password=$password&password_confirmation=$password',
                                      ),
                                    );

                                    http.StreamedResponse response =
                                        await request.send();

                                    // print(
                                    //     await response.stream.bytesToString());
                                    if (response.statusCode == 200) {
                                      snackBar.close();
                                      var res =
                                          await response.stream.bytesToString();

                                      var resJSON = json.decode(res);

                                      print(resJSON);

                                      if (resJSON['status'] == "success") {
                                        SignUpModel signUpModel =
                                            signUpModelFromJson(res);

                                        toastMessage(
                                          signUpModel.details,
                                          kLogoGreen,
                                          context,
                                        );

                                        Navigator.pop(context);
                                      } else {
                                        toastMessage(
                                          resJSON['details'],
                                          kLogoRed,
                                          context,
                                        );
                                      }
                                    } else {
                                      snackBar.close();
                                      toastMessage(
                                        AppLocalizations.of(context).translate(
                                            'str_invalid_email_password'),
                                        kLogoRed,
                                        context,
                                      );

                                      print(response.stream);
                                    }
                                  } else {
                                    toastMessage(
                                      AppLocalizations.of(context).translate(
                                          'str_invalid_password_regex'),
                                      kLogoRed,
                                      context,
                                    );
                                  }
                                } else {
                                  toastMessage(
                                    AppLocalizations.of(context)
                                        .translate('str_invalid_password'),
                                    kLogoRed,
                                    context,
                                  );
                                }
                              } else {
                                toastMessage(
                                  AppLocalizations.of(context)
                                      .translate('str_invalid_email'),
                                  kLogoRed,
                                  context,
                                );
                              }
                            } else {
                              toastMessage(
                                AppLocalizations.of(context)
                                    .translate('str_empty_name'),
                                kLogoRed,
                                context,
                              );
                            }

                            // print('isValidEmail = ${isValidEmail}');
                          },
                          text: AppLocalizations.of(context)
                              .translate('str_sign_up'),
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

                        // Container(
                        //   margin: new EdgeInsets.fromLTRB(40, 0, 40, 0),
                        //   child: Material(
                        //     elevation: 2.5,
                        //     borderRadius: BorderRadius.circular(30.0),
                        //     color: Color(0xff39e5ff),
                        //     child: MaterialButton(
                        //       minWidth: MediaQuery.of(context).size.width,
                        //       padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                        //       onPressed: () async {
                        //         print(nameController.text);
                        //         print(emailController.text);
                        //         print(passController.text);

                        //         final String name = nameController.text;
                        //         final String email = emailController.text;
                        //         final String pass = passController.text;

                        //         final User user = await createUser(
                        //             name, email, pass, context);

                        //         setState(() {
                        //           print(user);
                        //         });
                        //       },
                        //       child: Text(
                        //           AppLocalizations.of(context)
                        //               .translate('str_sign_up'),
                        //           textAlign: TextAlign.center,
                        //           style: style.copyWith(
                        //               fontSize: 18,
                        //               color: Color(0xffffffff),
                        //               fontWeight: FontWeight.w600)),
                        //     ),
                        //   ),
                        // ),
                        Container(
                          margin: new EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Text(
                              //   "Not registered yet?",
                              //   //textAlign: Alignment.center,
                              //   style: TextStyle(
                              //       color: Colors.white,
                              //       fontSize: 16,
                              //       fontFamily: 'Poppins',
                              //       fontWeight: FontWeight.w500),
                              // ),
                              FlatButton(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                onPressed: () {
                                  /*...*/
                                  // Toast.show("Forgot Password ..........", context,
                                  //     duration: Toast.LENGTH_SHORT,
                                  //     gravity: Toast.BOTTOM);
                                  Route route = MaterialPageRoute(
                                      builder: (context) => Login());
                                  Navigator.pushReplacement(context, route);
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('str_already_have_account'),
                                  style: TextStyle(
                                      color: Color(0xff3b5988),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        Container(
                          margin: new EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .translate('str_already_have_account'),
                                style: appTextStyle(
                                  FontWeight.w500,
                                  16.0,
                                  Colors.white,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ),
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('str_sign_in_now'),
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

                        // Text(
                        //   AppLocalizations.of(context)
                        //       .translate('str_continue_with_social_media'),
                        //   style: TextStyle(color: Colors.white),
                        // ),
                        // SizedBox(
                        //   height: 8,
                        // ),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: <Widget>[
                        //     // SignInButton(
                        //     //   Buttons.LinkedIn,
                        //     //   mini: true,
                        //     //   onPressed: () {
                        //     //     //_showButtonPressDialog(
                        //     //     //  context, 'LinkedIn (mini)');
                        //     //   },
                        //     // ),
                        //     SignInButton(
                        //       Buttons.Facebook,
                        //       text: AppLocalizations.of(context)
                        //           .translate('str_continue_with_facebook'),
                        //       onPressed: () {
                        //         //_showButtonPressDialog(
                        //         //context, 'Tumblr (mini)');
                        //       },
                        //     ),
                        //     SignInButton(
                        //       Buttons.GoogleDark,
                        //       text: AppLocalizations.of(context)
                        //           .translate('str_continue_with_google'),
                        //       onPressed: () {
                        //         //_showButtonPressDialog(
                        //         //context, 'Google (dark)');
                        //       },
                        //     ),
                        //   ],
                        // ),
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

  _signupClicked(BuildContext context) {
    print("Signup Clicked.....");
  }
}
