import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mayrasales/constants.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:location/location.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';
import 'package:mayrasales/model/checkout_model.dart';
import 'package:mayrasales/model/orders_model.dart';
import 'package:mayrasales/model/userpreferences.dart';
import 'package:mayrasales/view/orders.dart';
import 'package:mayrasales/widgets/widgets.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_html/flutter_html.dart';

class ConfirmOrderPage extends StatefulWidget {
  final int qty;
  final String address;
  const ConfirmOrderPage({Key key, this.qty, this.address}) : super(key: key);
  @override
  _ConfirmOrderPageState createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  Future<Checkout> fCheckoutDetails;
  Future<OrdersModel> fuser_Order;

  int selectedRadio;
  int selectedRadioTile;
  int selectedContactNumber;
  int selectedPaymentMethod;
  String selectedPaymentType;
  String paymentMethod;
  bool newAddress = false;
  bool newCN = false;
  bool paymentType = false;
  String address;
  String contactnumber;

  final snController = TextEditingController();
  final ctyController = TextEditingController();
  final distController = TextEditingController();
  final phoneController = TextEditingController();
  final transController = TextEditingController();

  // var location = new Location();
  // Map<String, double> userLocation;

  void initState() {
    super.initState();
    //_fetchProductDetails();
    selectedRadio = 0;
    selectedRadioTile = 1;
    selectedPaymentMethod = 99;
    newAddress = false;
    paymentType = false;

    selectedContactNumber = 1;

    fCheckoutDetails = _getCheckoutDetails();
    fuser_Order = _getUserOrder();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
      newAddress = !newAddress;
    });
  }

  setSelectedContactNumber(int val) {
    setState(() {
      selectedContactNumber = val;
      newCN = !newCN;
    });
  }

  setSelectedPaymentMethod(int val, String pt, String dtls, String title) {
    setState(() {
      selectedPaymentMethod = val;
      selectedPaymentType = pt;
      desc = dtls;
      paymentMethod = title;
      if (pt == "cash-on-delivery") {
        paymentType = false;
      } else {
        paymentType = true;
      }
      //newCN = !newCN;
    });
  }

  Future<File> file;
  String status = '';
  String base64Image = '';
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  String desc = '';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          print(base64Image.toString());
          return Flexible(
            fit: FlexFit.loose,
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  // chooseImage() {
  //   setState(() {
  //     file = ImagePicker.pickImage(source: ImageSource.gallery);
  //   });
  // }
  Future<OrdersModel> _getUserOrder() async {
    String token = await UserPreferences.getToken();

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://mayrasales.com/api/user/user_orders'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());

      var responseBody = await response.stream.bytesToString();

      print(responseBody);

      var jsonResponse = json.decode(responseBody);

      if (jsonResponse["status"] == "success") {
        OrdersModel user_order = ordersModelFromJson(responseBody);
        print('Data featched');
        print('success');
        print('$user_order');

        return user_order;
      } else {
        return null;
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<Checkout> _getCheckoutDetails() async {
    String token = await UserPreferences.getToken();

    address = await UserPreferences.getAddress();
    contactnumber = await UserPreferences.getContactNumber();

    print("Add = $address");

    print("CN = $contactnumber");
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://mayrasales.com/api/user/checkout'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());

      var responseBody = await response.stream.bytesToString();

      print(responseBody);

      var jsonResponse = json.decode(responseBody);

      if (jsonResponse["status"] == "success") {
        Checkout checkoutDetails = checkoutFromJson(responseBody);
        print('Data featched');
        print('$checkoutDetails');

        return checkoutDetails;
      } else {
        return null;
      }
    } else {
      print(response.reasonPhrase);
    }

    // String url = 'https://mayrasales.com/api/user/checkout?api_token=${token}';
    // var r = await Requests.get(url);
    // print(url);
    // r.raiseForStatus();
    // String responseBody = r.content();

    // Checkout checkoutDetails = checkoutFromJson(responseBody);
    // //print("Ad Ad Ad Ad Ad Ad Ad Ad Ad Ad Ad Ad Ad Ad Ad Ad Ad");
    // // print(adsModel.photo);

    // //advertise1.add(adsModel.photo);

    // return checkoutDetails;
  }

  Widget build(BuildContext context) {
    //print(_cart);
    return Scaffold(
      // debugShowCheckedModeBanner: false,
      // home: Home(),
      key: _scaffoldKey,
      appBar: buildAppBar(
          context, AppLocalizations.of(context).translate('str_my_cart')),
      body: FutureBuilder(
        future: fCheckoutDetails,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      backgroundColor: kGradientPrimary,
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        kGradientSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            if (snapshot.data.status == "success") {
              String addVal = "";
              final String addr = widget.address;
              final String phone = contactnumber;
              final double total =
                  snapshot.data.totalWithoutShipping.toDouble();
              final double delivery = snapshot.data.shippingPrice.toDouble();
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Subtotal"),
                        Text("Rs. $total"),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Delivery fee"),
                        Text("Rs. $delivery"),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Total",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text("Rs. ${total + delivery}",
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      // padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delivery Address",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            widget.address,
                            // style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Payment Option",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),

                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.paymentMethods.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, int index) {
                        return RadioListTile(
                          selected: false,
                          value: index,
                          groupValue: selectedPaymentMethod,
                          title: Text(
                            snapshot.data.paymentMethods[index].title,
                          ),
                          onChanged: (val) {
                            //print("Radio Tile Pressed $val");
                            setSelectedPaymentMethod(
                                val,
                                snapshot.data.paymentMethods[index].subtitle,
                                snapshot.data.paymentMethods[index].details,
                                snapshot.data.paymentMethods[index].title);
                            //print("newAddress = $newAddress");
                          },
                          activeColor: Color(0xffff85b2),
                        );
                      },
                    ),

                    Visibility(
                      visible: paymentType,
                      child: Card(
                        elevation: 0.0,
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 8.0, bottom: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Html(data: desc),
                              Form(
                                //key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      style: TextStyle(color: Colors.black),
                                      cursorColor: Color(0xffff85b2),
                                      autofocus: false,
                                      decoration: new InputDecoration(
                                        labelText: AppLocalizations.of(context)
                                            .translate('str_transaction'),
                                        // "Transaction ID",
                                        labelStyle:
                                            TextStyle(color: Color(0xffff85b2)),
                                        hintStyle:
                                            TextStyle(color: Color(0xffff85b2)),
                                        // icon: new Icon(
                                        //   Icons.mail,
                                        //   color: Colors.white,
                                        // ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffff85b2)),
                                        ),
                                      ),
                                      keyboardType: TextInputType.streetAddress,
                                      textInputAction: TextInputAction.next,
                                      controller: transController,
                                    ),
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('str_or'),
                                ),
                              ),
                              OutlineButton(
                                onPressed: chooseImage,
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('str_choose_image'),
                                ),
                              ),
                              SizedBox(height: 16.0),
                              showImage(),
                              SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                status,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0,
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

                    // RadioListTile(
                    //   groupValue: true,
                    //   value: true,
                    //   title: Text("Cash on Delivery"),
                    //   onChanged: (value) {},
                    // ),
                    GestureDetector(
                      onTap: () async {
                        // Flushbar(
                        //             title: 'str_invalid_quantity',
                        //             forwardAnimationCurve: Curves.decelerate,
                        //             reverseAnimationCurve: Curves.easeOut,
                        //             message:
                        //                 'Please select screenshot of the transaction.',
                        //             duration: Duration(seconds: 2),
                        //             margin: EdgeInsets.all(8),
                        //             borderRadius: 8,
                        //             flushbarStyle: FlushbarStyle.FLOATING,
                        //             flushbarPosition: FlushbarPosition.TOP,
                        //             backgroundColor: Colors.redAccent,)
                        //           ..show(context);
                        FocusScope.of(context).requestFocus(new FocusNode());
                        String token = await UserPreferences.getToken();
                        String userEmail = await UserPreferences.getEmail();
                        String username = await UserPreferences.getUsername();
                        String contactNumber;
                        String deliveryAddress;
                        String url = "";
                        print(base64Image);
                        print("totalQty ${widget.qty}");
                        print("total $total");
                        print("shipping_cost $delivery");
                        print("userEmail $userEmail");
                        print("username $username");

                        if (selectedContactNumber == 1) {
                          contactNumber =
                              await UserPreferences.getContactNumber();
                        } else {
                          contactNumber = phoneController.text;
                        }

                        print("username $contactNumber");

                        if (selectedRadioTile == 1) {
                          // deliveryAddress = await UserPreferences.getAddress();
                          deliveryAddress = widget.address;
                          print('$deliveryAddress');
                        } else {
                          deliveryAddress =
                              "${snController.text}, ${ctyController.text}, ${distController.text}";
                        }

                        print("deliveryAddress $deliveryAddress");
                        print("paymentMethod $paymentMethod");

                        print("transController.text.toString()" +
                            transController.text.toString());

                        if (selectedPaymentMethod != 99 &&
                            selectedRadioTile != 0 &&
                            selectedContactNumber != 0) {
                          if (selectedPaymentType == "cash-on-delivery") {
                            final snackBar =
                                ScaffoldMessenger.of(context).showSnackBar(
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
                                      'Confirming Order.....',
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

                            var headers = {'Authorization': 'Bearer $token'};
                            var request = http.Request(
                                'GET',
                                Uri.parse(
                                    "https://mayrasales.com/api/user/gateway?totalQty=${widget.qty}&total=$total&method=$paymentMethod&email=$userEmail&name=$username&shipping_cost=$delivery&phone=$contactNumber&address=$deliveryAddress&customer_country=Nepal&city&zip=44600&longitude&customer_latitude&shipping_name&shipping_phone=$contactNumber&shipping_address=$deliveryAddress&shipping_country&shipping_city&shipping_zip&shipping_longitude&shipping_latitude&order_note&delivery_range_end&delivery_range_end&txn_image"));

                            request.headers.addAll(headers);

                            http.StreamedResponse response =
                                await request.send();

                            if (response.statusCode == 200) {
                              snackBar.close();
                              // Flushbar(
                              //   forwardAnimationCurve: Curves.decelerate,
                              //   reverseAnimationCurve: Curves.easeOut,
                              //   message: AppLocalizations.of(context)
                              //       .translate('str_order_placed'),
                              //   duration: Duration(seconds: 3),
                              //   margin: EdgeInsets.all(8),
                              //   borderRadius: 8,
                              //   flushbarStyle: FlushbarStyle.FLOATING,
                              //   flushbarPosition: FlushbarPosition.TOP,
                              //   backgroundColor: Color(0xff228B22),
                              //   mainButton: TextButton(
                              //     onPressed: () {
                              //       Navigator.pop(context);
                              //       Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) => Orders(),
                              //         ),
                              //       );
                              //     },
                              //     child: Text(
                              //       AppLocalizations.of(context)
                              //           .translate('str_go_to_order'),
                              //       style: TextStyle(color: Colors.white),
                              //     ),
                              //   ),
                              // )..show(context);
                              snackBarMessageWithAction(
                                context,
                                AppLocalizations.of(context)
                                    .translate('str_order_placed'),
                                Duration(
                                  seconds: 3,
                                ),
                                AppLocalizations.of(context)
                                    .translate('str_go_to_order'),
                                () {
                                  // print('Go To Cart');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Orders(),
                                    ),
                                  );
                                },
                              );
                              Future.delayed(Duration(seconds: 100), () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Orders(),
                                  ),
                                );
                              });
                              // print(await response.stream.bytesToString());
                              // print('success');
                            } else {
                              snackBar.close();
                              print(response.reasonPhrase);
                            }
                            //   url =
                            //       "https://mayrasales.com/api/user/gateway?totalQty=${widget.qty}&total=$total&method=$paymentMethod&email=$userEmail&name=$username&shipping_cost=$delivery&phone=$contactNumber&address=$deliveryAddress&customer_country=Nepal&city&zip=44600&longitude&customer_latitude&shipping_name&shipping_phone=$contactNumber&shipping_address=$deliveryAddress&shipping_country&shipping_city&shipping_zip&shipping_longitude&shipping_latitude&order_note&delivery_range_end&delivery_range_end&txn_image";
                          } else {
                            if (transController.text.toString() == "" &&
                                base64Image == "") {
                              Flushbar(
                                title: AppLocalizations.of(context)
                                    .translate('str_invalid_transaction'),
                                forwardAnimationCurve: Curves.decelerate,
                                reverseAnimationCurve: Curves.easeOut,
                                message: AppLocalizations.of(context)
                                    .translate('str_select_transaction'),
                                duration: Duration(seconds: 2),
                                margin: EdgeInsets.all(8),
                                borderRadius: 8,
                                flushbarStyle: FlushbarStyle.FLOATING,
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Colors.redAccent,
                              )..show(context);
                            } else {
                              if (transController.text.toString() != "") {
                                final snackBar =
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                          'Confirming Order.....',
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

                                String transId =
                                    transController.text.toString();

                                var headers = {
                                  'Authorization': 'Bearer $token'
                                };
                                var request = http.Request(
                                    'GET',
                                    Uri.parse(
                                        'https://mayrasales.com/api/user/gateway?totalQty=${widget.qty}&total=$total&method=$paymentMethod&email=$userEmail&name=$username&shipping_cost=$delivery&phone=$contactNumber&address=$deliveryAddress&customer_country=Nepal&city&zip=44600&longitude&customer_latitude&shipping_name&shipping_phone=$contactNumber&shipping_address=$deliveryAddress&shipping_country&shipping_city&shipping_zip&shipping_longitude&shipping_latitude&order_note=$transId&delivery_range_end&delivery_range_end&txn_image'));

                                request.headers.addAll(headers);

                                http.StreamedResponse response =
                                    await request.send();

                                if (response.statusCode == 200) {
                                  snackBar.close();
                                  snackBarMessageWithAction(
                                    context,
                                    AppLocalizations.of(context)
                                        .translate('str_order_placed'),
                                    Duration(
                                      seconds: 3,
                                    ),
                                    AppLocalizations.of(context)
                                        .translate('str_go_to_order'),
                                    () {
                                      // print('Go To Cart');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Orders(),
                                        ),
                                      );
                                    },
                                  );
                                  Future.delayed(Duration(seconds: 100), () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Orders(),
                                      ),
                                    );
                                  });
                                } else {
                                  snackBar.close();
                                  print(response.reasonPhrase);
                                }

                                //   url =
                                //       "https://mayrasales.com/api/user/gateway?totalQty=${widget.qty}&total=$total&method=$paymentMethod&email=$userEmail&name=$username&shipping_cost=$delivery&phone=$contactNumber&address=$deliveryAddress&customer_country=Nepal&city&zip=44600&longitude&customer_latitude&shipping_name&shipping_phone=$contactNumber&shipping_address=$deliveryAddress&shipping_country&shipping_city&shipping_zip&shipping_longitude&shipping_latitude&order_note=$transId&delivery_range_end&delivery_range_end&txn_image";
                              } else {
                                if (transController.text.toString() == "") {
                                  print("aaaaaaa");
                                  if ((base64Image != null) ||
                                      (base64Image != "")) {
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
                                              'Confirming Order.....',
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
                                    var headers = {
                                      'Authorization': 'Bearer $token'
                                    };
                                    var request = http.Request(
                                        'GET',
                                        Uri.parse(
                                            "https://mayrasales.com/api/user/gateway?totalQty=${widget.qty}&total=$total&method=$paymentMethod&email=$userEmail&name=$username&shipping_cost=$delivery&phone=$contactNumber&address=$deliveryAddress&customer_country=Nepal&city&zip=44600&longitude&customer_latitude&shipping_name&shipping_phone=$contactNumber&shipping_address=$deliveryAddress&shipping_country&shipping_city&shipping_zip&shipping_longitude&shipping_latitude&order_note&delivery_range_end&delivery_range_end&txn_image=$base64Image"));

                                    request.headers.addAll(headers);

                                    http.StreamedResponse response =
                                        await request.send();

                                    if (response.statusCode == 200) {
                                      snackBar.close();
                                      snackBarMessageWithAction(
                                        context,
                                        AppLocalizations.of(context)
                                            .translate('str_order_placed'),
                                        Duration(
                                          seconds: 3,
                                        ),
                                        AppLocalizations.of(context)
                                            .translate('str_go_to_order'),
                                        () {
                                          // print('Go To Cart');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Orders(),
                                            ),
                                          );
                                        },
                                      );
                                      Future.delayed(Duration(seconds: 100),
                                          () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Orders(),
                                          ),
                                        );
                                        // Do something
                                      });
                                    } else {
                                      print(response.reasonPhrase);
                                    }
                                    //   url =
                                    //       "https://mayrasales.com/api/user/gateway?totalQty=${widget.qty}&total=$total&method=$paymentMethod&email=$userEmail&name=$username&shipping_cost=$delivery&phone=$contactNumber&address=$deliveryAddress&customer_country=Nepal&city&zip=44600&longitude&customer_latitude&shipping_name&shipping_phone=$contactNumber&shipping_address=$deliveryAddress&shipping_country&shipping_city&shipping_zip&shipping_longitude&shipping_latitude&order_note&delivery_range_end&delivery_range_end&txn_image=$base64Image";
                                  } else {
                                    Flushbar(
                                      //title: 'str_invalid_quantity',
                                      forwardAnimationCurve: Curves.decelerate,
                                      reverseAnimationCurve: Curves.easeOut,
                                      message: AppLocalizations.of(context)
                                          .translate('str_select_screenshot'),
                                      duration: Duration(seconds: 2),
                                      margin: EdgeInsets.all(8),
                                      borderRadius: 8,
                                      flushbarStyle: FlushbarStyle.FLOATING,
                                      flushbarPosition: FlushbarPosition.TOP,
                                      backgroundColor: Colors.redAccent,
                                    )..show(context);
                                  }
                                } else {
                                  Flushbar(
                                    title: AppLocalizations.of(context)
                                        .translate('str_invalid_transaction'),
                                    forwardAnimationCurve: Curves.decelerate,
                                    reverseAnimationCurve: Curves.easeOut,
                                    message: AppLocalizations.of(context)
                                        .translate(
                                            'str_invalid_transaction_id'),
                                    duration: Duration(seconds: 2),
                                    margin: EdgeInsets.all(8),
                                    borderRadius: 8,
                                    flushbarStyle: FlushbarStyle.FLOATING,
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: Colors.redAccent,
                                  )..show(context);
                                }
                              }
                            }
                          }
//my commented code
                          // var r = await Requests.get(url);
                          // print(url);
                          // r.raiseForStatus();
                          // String responseBody = r.content();

                          // print(responseBody);

                          // if (r.statusCode == 200) {
                          //   Flushbar(
                          //     forwardAnimationCurve: Curves.decelerate,
                          //     reverseAnimationCurve: Curves.easeOut,
                          //     message: AppLocalizations.of(context)
                          //         .translate('str_order_placed'),
                          //     duration: Duration(seconds: 3),
                          //     margin: EdgeInsets.all(8),
                          //     borderRadius: 8,
                          //     flushbarStyle: FlushbarStyle.FLOATING,
                          //     flushbarPosition: FlushbarPosition.TOP,
                          //     backgroundColor: Color(0xff228B22),
                          //     // mainButton: FlatButton(
                          //     //   onPressed: () {
                          //     //     Navigator.pop(context);
                          //     //     Navigator.push(
                          //     //       context,
                          //     //       MaterialPageRoute(
                          //     //         builder: (context) => Wishlist(),
                          //     //       ),
                          //     //     );
                          //     //   },
                          //     //   child: Text(
                          //     //     AppLocalizations.of(context)
                          //     //         .translate('str_go_to_wishlist'),
                          //     //     style: TextStyle(color: Colors.white),
                          //     //   ),
                          //     // ),
                          //   )..show(context);
                          // }
                        } else {
                          Flushbar(
                            title: AppLocalizations.of(context)
                                .translate('str_invalid_payment_method'),
                            forwardAnimationCurve: Curves.decelerate,
                            reverseAnimationCurve: Curves.easeOut,
                            message: AppLocalizations.of(context)
                                .translate('str_select_payment_method'),
                            duration: Duration(seconds: 2),
                            margin: EdgeInsets.all(8),
                            borderRadius: 8,
                            flushbarStyle: FlushbarStyle.FLOATING,
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Colors.redAccent,
                          )..show(context);
                        }

                        print(url);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xffff85b2),
                              Color(0xffa797ff),
                              Color(0xff00e5ff)
                            ],
                          ),
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('str_confirm'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }
        },
      ),
    );
  }

//   Widget showImage() {
//     return FutureBuilder<File>(
//       future: file,
//       builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
//         if (snapshot.connectionState == ConnectionState.done &&
//             null != snapshot.data) {
//           tmpFile = snapshot.data;
//           base64Image = base64Encode(snapshot.data.readAsBytesSync());
//           return Flexible(
//             child: Image.file(
//               snapshot.data,
//               fit: BoxFit.fill,
//             ),
//           );
//         } else if (null != snapshot.error) {
//           return const Text(
//             'Error Picking Image',
//             textAlign: TextAlign.center,
//           );
//         } else {
//           return const Text(
//             'No Image Selected',
//             textAlign: TextAlign.center,
//           );
//         }
//       },
//     );
//   }
// }
}
