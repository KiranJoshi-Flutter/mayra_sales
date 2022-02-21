import 'dart:convert';
import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';
import 'package:mayrasales/model/imageupdatemodel.dart';
import 'package:mayrasales/model/user_model.dart';
import 'package:mayrasales/model/userpreferences.dart';
import 'package:mayrasales/view/homepage.dart';
import 'package:mayrasales/widgets/widgets.dart';
import 'package:requests/requests.dart';
import 'package:http/http.dart' as http;
//import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  Future<User> fUsers;

  //save the result of gallery file
  File galleryFile;
  //String base64Image = '';

  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  Future<String> fprofilePic;

//save the result of camera file
  File cameraFile;

  String profilePicURL = '';

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final mobileController = TextEditingController();
  final pincodeController = TextEditingController();
  final stateController = TextEditingController();
  final addrController = TextEditingController();

  void initState() {
    super.initState();
    //_fetchProductDetails();

    fUsers = _getProfile();

    //fprofilePic = _getProfilePic();
  }

  @override
  void dispose() {
    super.dispose();
  }

  imageSelectorGallery(BuildContext context) async {
    // ignore: deprecated_member_use
    file = ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    galleryFile = await file;
    //print("You selected gallery image : " + galleryFile.path);

    if (galleryFile != null) {
      base64Image =
          "data:image/jpeg;base64,${base64Encode(galleryFile.readAsBytesSync()).toString()}";

      uploadImage(base64Image, context, galleryFile);
    }
    //print(base64Image);
    setState(() {});
  }

  uploadImage(String base64Img, BuildContext context, File imgFile) async {
    var apiToken = await UserPreferences.getApiToken();

    String updateURL =
        "https://mayrasales.com/api/user/modify?api_token=$apiToken";
    print(updateURL);

    //print(base64Img);

    //print(base64Encode(imgFile.readAsBytesSync()));
    try {
      var r = await http.post(
        updateURL,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'photo': base64Img,
        }),
      );
      //String responseBody = r.body;

      print(r.body);

      if (r.statusCode == 200) {
        String responseBody = r.body;
        ImageUpdateModel imageUpdateModel =
            imageUpdateModelFromJson(responseBody);
        UserPreferences.setProfilePic(imageUpdateModel.image);
        Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          reverseAnimationCurve: Curves.easeOut,
          message:
              AppLocalizations.of(context).translate('str_profile_update_msg'),
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(8),
          borderRadius: 8,
          flushbarStyle: FlushbarStyle.FLOATING,
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Color(0xff228B22),
        )..show(context);
      }
    } on HttpException catch (error) {
      print(error.toString());
    } catch (error) {
      print(error);
    }
  }

  Future<User> _getProfile() async {
    String apiToken = await UserPreferences.getToken();
    var pp = await UserPreferences.getProfilePic();

    if (pp == null || pp == '') {
      profilePicURL =
          "https://scontent.fktm1-2.fna.fbcdn.net/v/t1.0-1/p100x100/119225648_200665931405962_4949444025816031879_o.jpg?_nc_cat=107&_nc_sid=dbb9e7&_nc_ohc=atn3WVwd-9IAX_c1im2&_nc_ht=scontent.fktm1-2.fna&tp=6&oh=3b59f50fd1f3c641f023883ca5f2792c&oe=5F867D26";
    } else {
      profilePicURL =
          "https://mayrasales.com/assets/images/users/${pp.toString().replaceAll(' ', '')}";
    }
    var headers = {'Authorization': 'Bearer $apiToken'};
    var request = http.MultipartRequest(
        'GET', Uri.parse('https://mayrasales.com/api/user/details'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var responseBody = await response.stream.bytesToString();

      print(responseBody);

      // var jsonResponse = json.decode(responseBody);

      User details = userFromJson(responseBody);

      return details;
    } else {
      return null;
      // print(response.reasonPhrase);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(
          context, AppLocalizations.of(context).translate('str_my_profile')),
      body: FutureBuilder(
        future: fUsers, // async work
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      backgroundColor: kGradientPrimary,
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        kGradientTertiary,
                      ),
                    ),
                  ),
                ],
              );
            default:
              if (snapshot.hasError) {
                return Text(snapshot.hasError.toString());
              } else {
                if (snapshot.data != null) {
                  nameController.text = snapshot.data.name.toString();
                  addressController.text = snapshot.data.address.toString();
                  mobileController.text = snapshot.data.phone.toString();
                  pincodeController.text = snapshot.data.zip.toString();
                  stateController.text = snapshot.data.country.toString();

                  return Column(
                    children: [
                      Container(
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                CircleAvatar(
                                  minRadius: 60,
                                  backgroundColor: Color(0xffff85b2),
                                  child: GestureDetector(
                                    onTap: () {
                                      //print("Image Clicked");
                                      imageSelectorGallery(context);
                                    },
                                    child: CircleAvatar(
                                      backgroundImage: (galleryFile != null)
                                          ? FileImage(File(galleryFile.path))
                                          : NetworkImage(
                                              'https://www.pngarts.com/files/6/User-Avatar-in-Suit-PNG.png',
                                            ),
                                      minRadius: 58,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   height: 8,
                            // ),
                            Text(
                              snapshot.data.name,
                              style: appTextStyle(
                                FontWeight.bold,
                                22.0,
                                Colors.white,
                              ),
                            ),
                            Text(
                              snapshot.data.email,
                              style: appTextStyle(
                                FontWeight.w500,
                                16.0,
                                Colors.white,
                              ),
                            ),

                            SizedBox(
                              height: 16.0,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 25.0),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25.0,
                                              right: 25.0,
                                              top: 25.0),
                                          child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              new Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  new Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            'str_personal_information'),
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              new Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  _status
                                                      ? _getEditIcon()
                                                      : new Container(),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25.0,
                                              right: 25.0,
                                              top: 25.0),
                                          child: new Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              new Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  new Text(
                                                    AppLocalizations.of(context)
                                                        .translate('str_name'),
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25.0,
                                              right: 25.0,
                                              top: 2.0),
                                          child: new Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              new Flexible(
                                                child: new TextField(
                                                  decoration:
                                                      const InputDecoration(),
                                                  enabled: !_status,
                                                  autofocus: !_status,
                                                  controller: nameController,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25.0,
                                              right: 25.0,
                                              top: 25.0),
                                          child: new Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              new Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  new Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            'str_address'),
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25.0,
                                              right: 25.0,
                                              top: 2.0),
                                          child: new Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              new Flexible(
                                                child: new TextField(
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "Enter Email ID"),
                                                  enabled: !_status,
                                                  controller: addressController,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25.0,
                                              right: 25.0,
                                              top: 25.0),
                                          child: new Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              new Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  new Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            'str_contact_number'),
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25.0,
                                              right: 25.0,
                                              top: 2.0),
                                          child: new Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              new Flexible(
                                                child: new TextField(
                                                  decoration: const InputDecoration(
                                                      hintText:
                                                          "Enter Mobile Number"),
                                                  enabled: !_status,
                                                  controller: mobileController,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25.0,
                                              right: 25.0,
                                              top: 25.0),
                                          child: new Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  child: new Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            'str_pin_code'),
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                flex: 2,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: new Text(
                                                    AppLocalizations.of(context)
                                                        .translate('str_state'),
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                flex: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25.0,
                                              right: 25.0,
                                              top: 2.0),
                                          child: new Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10.0),
                                                  child: new TextField(
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          "Enter Pin Code",
                                                    ),
                                                    enabled: !_status,
                                                    controller:
                                                        pincodeController,
                                                  ),
                                                ),
                                                flex: 2,
                                              ),
                                              Flexible(
                                                child: new TextField(
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: "Enter State",
                                                  ),
                                                  enabled: !_status,
                                                  controller: stateController,
                                                ),
                                                flex: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  !_status
                                      ? _getActionButtons()
                                      : new Container(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Text(
                      'Something went wrong',
                      style: notFoundTextStyle,
                      //textAlign: TextAlign.center,
                    ),
                  );
                }
              }
          }
        },
      ),
    );
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text(
                    AppLocalizations.of(context).translate('str_save')),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
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
                            'Updating profile.....',
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

                  var apiToken = await UserPreferences.getToken();

                  print(addressController.text);
                  print(nameController.text);

                  final String name = nameController.text;
                  final String address = addressController.text;
                  final String pinCode = pincodeController.text;
                  final String phone = mobileController.text;
                  final String state = stateController.text;

                  var headers = {'Authorization': 'Bearer $apiToken'};
                  var request = http.MultipartRequest(
                      'POST',
                      Uri.parse(
                          'https://mayrasales.com/api/user/edit_profile'));
                  request.fields.addAll({
                    'name': '$name',
                    'address': '$address',
                    'zip': '$pinCode',
                    'phone': '$phone',
                    'country': '$state',
                  });
                  request.headers.addAll(headers);

                  http.StreamedResponse response = await request.send();

                  if (response.statusCode == 200) {
                    snackBar.close();

                    toastMessage(
                        AppLocalizations.of(context)
                            .translate('str_profile_update_msg'),
                        Color(0xff228B22),
                        context);

                    setState(() {
                      snackBar.close();
                      fUsers = _getProfile();
                    });
                  } else {
                    print(response.reasonPhrase);
                  }

                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text(
                    AppLocalizations.of(context).translate('str_cancel')),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Color(0xffff85b2),
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
