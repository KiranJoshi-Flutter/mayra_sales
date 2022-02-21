import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mayrasales/constants.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';
import 'package:mayrasales/model/userpreferences.dart';
import 'package:mayrasales/view/home_screen.dart';
import 'package:mayrasales/widgets/widgets.dart';
import 'package:requests/requests.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool oldPasswordVisible;
  bool newPasswordVisible;
  bool confirmPasswordVisible;
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
    oldPasswordVisible = true;
    newPasswordVisible = true;
    confirmPasswordVisible = true;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        AppLocalizations.of(context).translate('str_change_password_title'),
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
                                style: TextStyle(color: Colors.white),
                                obscureText: oldPasswordVisible,
                                cursorColor: Colors.white,
                                autofocus: false,
                                decoration: new InputDecoration(
                                  labelText: AppLocalizations.of(context)
                                      .translate('str_old_password'),
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white),
                                  icon: new Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      oldPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(
                                        () {
                                          oldPasswordVisible =
                                              !oldPasswordVisible;
                                        },
                                      );
                                    },
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                controller: oldPassController,
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                obscureText: newPasswordVisible,
                                cursorColor: Colors.white,
                                autofocus: false,
                                decoration: new InputDecoration(
                                  labelText: AppLocalizations.of(context)
                                      .translate('str_new_password'),
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white),
                                  icon: new Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      newPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(
                                        () {
                                          newPasswordVisible =
                                              !newPasswordVisible;
                                        },
                                      );
                                    },
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                controller: newPassController,
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                obscureText: confirmPasswordVisible,
                                cursorColor: Colors.white,
                                autofocus: false,
                                decoration: new InputDecoration(
                                  labelText: AppLocalizations.of(context)
                                      .translate('str_confirm_new_password'),
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white),
                                  icon: new Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      confirmPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(
                                        () {
                                          confirmPasswordVisible =
                                              !confirmPasswordVisible;
                                        },
                                      );
                                    },
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                controller: confirmPassController,
                              ),
                              SizedBox(
                                height: 24,
                              ),
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
                            String previousPass =
                                await UserPreferences.getPassword();
                            String apiToken =
                                await UserPreferences.getApiToken();

                            // print(nameController.text);
                            // print(emailController.text);
                            // print(passController.text);

                            final String oldPassword = oldPassController.text;
                            final String newPassword = newPassController.text;
                            final String confirmPassword =
                                confirmPassController.text;

                            if (previousPass == oldPassword) {
                              if (newPassword == confirmPassword) {
                                String updateURL =
                                    "https://mayrasales.com/api/user/modify?api_token=$apiToken&password=$newPassword";
                                var r = await Requests.get(updateURL);
                                r.raiseForStatus();
                                String responseBody = r.content();
                                print(r.headers);
                                print(r.statusCode);
                                print(responseBody);

                                if (r.statusCode == 200) {
                                  snackBarMessageWithAction(
                                    context,
                                    AppLocalizations.of(context)
                                        .translate('str_update_password_msg'),
                                    Duration(seconds: 3),
                                    '',
                                    () {},
                                  );
                                }
                              } else {
                                snackBarMessageWithAction(
                                  context,
                                  AppLocalizations.of(context)
                                      .translate('str_mismatch_password_msg'),
                                  Duration(seconds: 3),
                                  '',
                                  () {},
                                );
                              }
                            } else {
                              snackBarMessageWithAction(
                                context,
                                AppLocalizations.of(context)
                                    .translate('str_invalid_old_password'),
                                Duration(seconds: 3),
                                '',
                                () {},
                              );
                            }
                          },
                          text: AppLocalizations.of(context)
                              .translate('str_change'),
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
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),

      //backgroundColor: Colors.grey.shade500,
    );
  }
}
