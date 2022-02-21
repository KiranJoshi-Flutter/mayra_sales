import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:mayrasales/controller/app_localisation.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffff85b2),
        title:
            Text(AppLocalizations.of(context).translate('str_forgot_password')),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xffff85b2),
              Color(0xffa797ff),
              Color(0xff00e5ff)
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 60.0,
                      child: Image.asset(
                        "assets/images/shopping_cart.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context).translate('str_mayra'),
                      //textAlign: Alignment.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('str_registered_email_msg'),
                      //textAlign: Alignment.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          // decoration: BoxDecoration(
                          //     //color: Colors.white,
                          //     borderRadius: BorderRadius.circular(10),
                          //     boxShadow: [
                          //       BoxShadow(
                          //           //color: Color.fromRGBO(225, 95, 27, .3),
                          //           blurRadius: 20,
                          //           offset: Offset(0, 10))
                          //     ]),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                autofocus: false,
                                decoration: new InputDecoration(
                                  labelText: AppLocalizations.of(context)
                                      .translate('str_enter_email'),
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white),
                                  icon: new Icon(
                                    Icons.mail,
                                    color: Colors.white,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(height: 16.0),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          margin: new EdgeInsets.fromLTRB(40, 0, 40, 0),
                          child: Material(
                            elevation: 2.5,
                            borderRadius: BorderRadius.circular(30.0),
                            color: Color(0xff39e5ff),
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                              onPressed: () {
                                // Toast.show("Login..........", context,
                                //     duration: Toast.LENGTH_SHORT,
                                //     gravity: Toast.BOTTOM);
                              },
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate('str_confirm'),
                                  textAlign: TextAlign.center,
                                  style: style.copyWith(
                                      fontSize: 18,
                                      color: Color(0xffffffff),
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 28,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget>[
        //     SizedBox(
        //       height: 80,
        //     ),
        //     Padding(
        //       padding: EdgeInsets.all(20),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: <Widget>[
        //           Align(
        //             alignment: Alignment.center,
        //             child: SizedBox(
        //               height: 80.0,
        //               child: Image.asset(
        //                 "assets/images/shopping_cart.png",
        //                 fit: BoxFit.contain,
        //               ),
        //             ),
        //           ),
        //           SizedBox(
        //             height: 16,
        //           ),
        //           Align(
        //             alignment: Alignment.center,
        //             child: Text(
        //               "Mayra Sales",
        //               //textAlign: Alignment.center,
        //               style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 28,
        //                   fontFamily: 'Poppins',
        //                   fontWeight: FontWeight.w400),
        //             ),
        //           ),
        //           SizedBox(height: 32),
        //           // Align(
        //           //   alignment: Alignment.center,
        //           //   child: Text(
        //           //     "Welcome",
        //           //     //textAlign: Alignment.center,
        //           //     style: TextStyle(
        //           //         color: Colors.white,
        //           //         fontSize: 24,
        //           //         fontFamily: 'Poppins',
        //           //         fontWeight: FontWeight.w400),
        //           //   ),
        //           // )

        //           Expanded(),

        //           //SizedBox(height: 10,),
        //           //Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18),),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        // // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     SizedBox(
        //       height: 80.0,
        //       child: Image.asset(
        //         "assets/images/shopping_cart.png",
        //         fit: BoxFit.contain,
        //       ),
        //     ),
        //     SizedBox(height: 16.0),
        //     Text(
        //       "Mayra Sales",
        //       style: TextStyle(
        //           fontFamily: 'Montserrat', color: Colors.white, fontSize: 20),
        //     ),
        //     SizedBox(height: 16.0),
        //     Padding(
        //       padding: EdgeInsets.all(20),
        //       child: Column(
        //         children: <Widget>[
        //           TextFormField(
        //             decoration: new InputDecoration(
        //               labelText: "Enter Email",
        //               // labelStyle: TextStyle(
        //               //     color: myFocusNode.hasFocus
        //               //         ? Colors.blue
        //               //         : Colors.white),
        //               fillColor: Colors.white,
        //               border: new OutlineInputBorder(
        //                 borderRadius: new BorderRadius.circular(25.0),
        //                 borderSide: new BorderSide(),
        //               ),
        //               focusedBorder: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(25.0),
        //                 borderSide: BorderSide(
        //                   color: Colors.white,
        //                 ),
        //               ),
        //               enabledBorder: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(25.0),
        //                 borderSide: BorderSide(
        //                   color: Colors.blue,
        //                   // width: 2.0,
        //                 ),
        //               ),
        //               //fillColor: Colors.green
        //             ),
        //             validator: (val) {
        //               if (val.length == 0) {
        //                 return "Email cannot be empty";
        //               } else {
        //                 return null;
        //               }
        //             },
        //             keyboardType: TextInputType.emailAddress,
        //             style: new TextStyle(
        //               fontFamily: "Poppins",
        //             ),
        //           ),
        //           SizedBox(height: 16.0),
        //           TextFormField(
        //             obscureText: true,
        //             decoration: new InputDecoration(
        //               labelText: "Enter Password",
        //               fillColor: Colors.white,
        //               border: new OutlineInputBorder(
        //                 borderRadius: new BorderRadius.circular(25.0),
        //                 borderSide: new BorderSide(),
        //               ),
        //               focusedBorder: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(25.0),
        //                 borderSide: BorderSide(
        //                   color: Colors.white,
        //                 ),
        //               ),
        //               enabledBorder: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(25.0),
        //                 borderSide: BorderSide(
        //                     // color: Colors.red,
        //                     // width: 2.0,
        //                     ),
        //               ),
        //               //fillColor: Colors.green
        //             ),
        //             keyboardType: TextInputType.visiblePassword,
        //             style: new TextStyle(
        //               fontFamily: "Poppins",
        //             ),
        //           ),
        //           SizedBox(height: 16.0),
        //           Material(
        //             elevation: 5.0,
        //             borderRadius: BorderRadius.circular(30.0),
        //             color: Color(0xff01A0C7),
        //             child: MaterialButton(
        //               minWidth: MediaQuery.of(context).size.width,
        //               padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        //               onPressed: () {},
        //               child: Text("Login",
        //                   textAlign: TextAlign.center,
        //                   style: style.copyWith(
        //                       color: Colors.white,
        //                       fontWeight: FontWeight.bold)),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
