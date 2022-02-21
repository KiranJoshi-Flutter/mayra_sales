import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mayrasales/constants.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:location/location.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';
import 'package:mayrasales/model/address_place_model.dart';
import 'package:mayrasales/model/checkout_list_model.dart';
import 'package:mayrasales/model/checkout_model.dart';
import 'package:mayrasales/model/userpreferences.dart';
import 'package:mayrasales/view/confirmorder.dart';
import 'package:mayrasales/widgets/defalut_button.dart';
import 'package:mayrasales/widgets/widgets.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:requests/requests.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mayrasales/model/cartlist_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';

class CheckoutScreen extends StatefulWidget {
  final int qty;
  const CheckoutScreen({Key key, this.qty}) : super(key: key);
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<AutoCompleteTextFieldState<String>> shippingCityKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  Future<CheckoutListModel> fCheckoutDetails;
  int selectedRadio;
  int selectedRadioTile;
  int selectedContactNumber;
  int selectedPaymentMethod;
  String selectedPaymentType;
  String paymentMethod;
  bool newAddress = false;
  bool newCN = false;
  bool paymentType = false;
  String address = '';
  String shippingAddress = '';
  String shippingContactName = '';
  String shippingContactNumber = '';
  String billingAddress = '';
  String billingContactName = '';
  String billingContactNumber = '';
  String contactnumber;

  String shippingProvince = '';
  String billingProvince = '';

  final snController = TextEditingController();
  final ctyController = TextEditingController();
  final distController = TextEditingController();
  final phoneController = TextEditingController();
  final transController = TextEditingController();

  final shippingFullNameController = TextEditingController();
  final shippingCityController = TextEditingController();
  final shippingProvinceController = TextEditingController();
  final shippingContactNumberController = TextEditingController();
  final shippingDistrictController = TextEditingController();
  final shippingAddressController = TextEditingController();

  //strings from here
  String fullName;
  String city;
  String region;
  String contact;
  String area;
  String add;

  final billingFullNameController = TextEditingController();
  final billingCityController = TextEditingController();
  final billingRegionController = TextEditingController();
  final billingContactNumberController = TextEditingController();
  final billingAreaController = TextEditingController();
  final billingAddressController = TextEditingController();

  bool sameAsShippingAddress = false;

  Future<CartlistModel> fCartProducts;
  // var location = new Location();
  // Map<String, double> userLocation;

  var formatter = NumberFormat('##,##,##,###');

  List _testList = [
    {'keyword': 'blue'},
    {'keyword': 'black'},
    {'keyword': 'red'}
  ];
  List<DropdownMenuItem> _dropdownTestItems;
  var _selectedTest;

  List<AddressPlaceModel> locations;

  int selectedShippingProvince = -1;
  int selectedShippingDistrict = -1;
  String selectedShippingCity = '';

  void initState() {
    super.initState();
    // _fetchProductDetails();
    readJson();
    selectedRadio = 0;
    selectedRadioTile = 1;
    selectedPaymentMethod = 99;
    newAddress = false;
    paymentType = false;

    selectedContactNumber = 1;

    fCheckoutDetails = _getCheckoutDetails();
    fCartProducts = _getCartList();

    _dropdownTestItems = buildDropdownTestItems(_testList);
  }

  List<DropdownMenuItem> buildDropdownTestItems(List _testList) {
    List<DropdownMenuItem> items = [];
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i['keyword']),
        ),
      );
    }
    return items;
  }

  onChangeDropdownTests(selectedTest) {
    print(selectedTest);
    setState(() {
      _selectedTest = selectedTest;
    });
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

  Future<void> readJson() async {
    final String response = await rootBundle
        .loadString('assets/json/province_district_cities.json');
    final data = await json.decode(response);

    List<AddressPlaceModel> addressPlaces = addressPlaceModelFromJson(response);

    setState(() {
      locations = addressPlaces;
    });

    print(addressPlaces.length);
    // ...
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

  Future<CartlistModel> _getCartList() async {
    String token = await UserPreferences.getToken();

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse('$baseURL/user/cart'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();

      var responseJSON = json.decode(responseBody);

      print(responseJSON);

      if (responseJSON["status"] == "success") {
        CartlistModel products = cartlistModelFromJson(responseBody);

        return products;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<CheckoutListModel> _getCheckoutDetails() async {
    var token = await UserPreferences.getToken();
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse('$baseURL/user/checkout'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();

      CheckoutListModel checkoutDetail =
          checkoutListModelFromJson(responseBody);

      return checkoutDetail;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  Widget build(BuildContext context) {
    //print(_cart);
    return Scaffold(
      // debugShowCheckedModeBanner: false,
      // home: Home(),
      key: _scaffoldKey,
      appBar: buildAppBar(
        context,
        AppLocalizations.of(context).translate(
          'str_checkout',
        ),
      ),
      body: FutureBuilder(
        future: fCartProducts, // async work
        builder: (BuildContext context, AsyncSnapshot<CartlistModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
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
            default:
              if (snapshot.hasError) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: "no_data",
                        child: Material(
                          color: Colors.transparent,
                          child: Image.asset(
                            "assets/icons/no_data.png",
                            fit: BoxFit.fitHeight,
                            height: 80,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Something went wrong.',
                        style: appTextStyle(
                          FontWeight.w500,
                          14.0,
                          Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              } else {
                if (snapshot.data != null) {
                  if (snapshot.data.details.length != 0) {
                    return FadedSlideAnimation(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('str_shipping_address'),
                                        style: appTextStyle(
                                          FontWeight.bold,
                                          16.0,
                                          kTextColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      shippingAddress.isNotEmpty
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.person,
                                                      size: 18.0,
                                                      color: kGradientPrimary,
                                                    ),
                                                    SizedBox(
                                                      width: 8.0,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        shippingContactName,
                                                        style: appTextStyle(
                                                          FontWeight.w500,
                                                          14.0,
                                                          Colors.black87
                                                              .withOpacity(
                                                                  0.65),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 4.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.call,
                                                      size: 18.0,
                                                      color: kGradientPrimary,
                                                    ),
                                                    SizedBox(
                                                      width: 8.0,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        shippingContactNumber,
                                                        style: appTextStyle(
                                                          FontWeight.w500,
                                                          14.0,
                                                          Colors.black87
                                                              .withOpacity(
                                                                  0.65),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 4.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.person_pin_circle,
                                                      size: 18.0,
                                                      color: kGradientPrimary,
                                                    ),
                                                    SizedBox(
                                                      width: 8.0,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        shippingAddress,
                                                        style: appTextStyle(
                                                          FontWeight.w500,
                                                          14.0,
                                                          Colors.black87
                                                              .withOpacity(
                                                                  0.65),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      shippingAddress.isEmpty
                                          ? InkWell(
                                              onTap: () {
                                                showMaterialModalBottomSheet(
                                                  context: context,
                                                  bounce: true,
                                                  builder: (context) =>
                                                      StatefulBuilder(
                                                    builder: (BuildContext
                                                            context,
                                                        StateSetter
                                                            setState /*You can rename this!*/) {
                                                      return shippingAddressWidget();
                                                    },
                                                  ),
                                                );
                                              },
                                              splashColor: kGradientPrimary
                                                  .withAlpha(50),
                                              child: Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: kGradientPrimary
                                                      .withOpacity(
                                                    0.15,
                                                  ),
                                                  border: Border.all(
                                                    color: kGradientPrimary,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Feather.plus_square,
                                                    color: kGradientPrimary,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                showMaterialModalBottomSheet(
                                                  context: context,
                                                  bounce: true,
                                                  builder: (context) =>
                                                      StatefulBuilder(
                                                    builder: (BuildContext
                                                            context,
                                                        StateSetter
                                                            setState /*You can rename this!*/) {
                                                      return shippingAddressWidget();
                                                    },
                                                  ),
                                                );
                                              },
                                              // splashColor: kGradientPrimary
                                              //     .withAlpha(50),
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Icon(
                                                  Feather.edit,
                                                  color: kGradientPrimary,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 2.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  kGradientPrimary,
                                  kGradientSecondary,
                                  kGradientTertiary,
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              // physics: BouncingScrollPhysics(),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data.details.length,

                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  // vertical: 16.0,
                                ),
                                // itemExtent: 80,
                                itemBuilder: (context, index) {
                                  var discount = 0;

                                  if (snapshot
                                          .data.details[index].previousPrice !=
                                      0) {
                                    var oldPrice = snapshot
                                        .data.details[index].previousPrice;

                                    var newPrice =
                                        snapshot.data.details[index].price;

                                    // discount = int.parse((oldPrice - newPrice) / oldPrice * 100).toString();

                                    var disAmt = oldPrice - newPrice;
                                    discount =
                                        ((disAmt / oldPrice) * 100).toInt();

                                    print('Discont Per = $discount');
                                  }
                                  return Stack(
                                    children: [
                                      Card(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Container(
                                          // height: 100,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Stack(
                                                  children: [
                                                    FutureBuilder(
                                                      future: imageURLCheck(
                                                          '$thumbnailBaseURL/${snapshot.data.details[index].thumbnail}'),
                                                      builder: (context,
                                                          asyncSnapshot) {
                                                        if (asyncSnapshot
                                                            .hasData) {
                                                          if (asyncSnapshot
                                                                  .data !=
                                                              null) {
                                                            return Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                horizontal: 4.0,
                                                                vertical: 4.0,
                                                              ),
                                                              child:
                                                                  Image.network(
                                                                '$thumbnailBaseURL/${snapshot.data.details[index].thumbnail}',
                                                                // fit: BoxFit.fitWidth,
                                                              ),
                                                            );
                                                          } else {
                                                            return Container(
                                                              // color: Colors.black,
                                                              // width: 200,
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 60,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                  "assets/images/no_image.png",
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        } else {
                                                          return Center(
                                                            child:
                                                                CupertinoActivityIndicator(
                                                              radius: 8,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8.0,
                                              ),
                                              Expanded(
                                                flex: 6,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 16.0,
                                                    ),
                                                    Text(
                                                      '${snapshot.data.details[index].name}',
                                                      style: appTextStyle(
                                                        FontWeight.bold,
                                                        16.0,
                                                        kTextColor,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          AppLocalizations.of(
                                                                      context)
                                                                  .translate(
                                                                      'str_rs') +
                                                              " ${formatter.format(snapshot.data.details[index].price)} /-",
                                                          softWrap: true,
                                                          style: appTextStyle(
                                                            FontWeight.w500,
                                                            14.0,
                                                            kTextColor
                                                                .withOpacity(
                                                                    0.8),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            child: snapshot
                                                                        .data
                                                                        .details[
                                                                            index]
                                                                        .previousPrice !=
                                                                    0
                                                                ? Row(
                                                                    children: [
                                                                      Text(
                                                                        " Rs. ${formatter.format(snapshot.data.details[index].previousPrice)} ",
                                                                        style: GoogleFonts
                                                                            .mukta(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.red,
                                                                          decoration:
                                                                              TextDecoration.lineThrough,
                                                                          decorationThickness:
                                                                              4.0,
                                                                          decorationColor:
                                                                              Colors.red,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            4.0,
                                                                      ),
                                                                      Text(
                                                                        "-$discount% ",
                                                                        style:
                                                                            appTextStyle(
                                                                          FontWeight
                                                                              .bold,
                                                                          10.0,
                                                                          Colors
                                                                              .black54,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                          ),
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: 'Qty: ',
                                                                style:
                                                                    appTextStyle(
                                                                  FontWeight
                                                                      .normal,
                                                                  12.0,
                                                                  kTextColor
                                                                      .withOpacity(
                                                                          0.8),
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: snapshot
                                                                    .data
                                                                    .details[
                                                                        index]
                                                                    .qty
                                                                    .toString(),
                                                                style:
                                                                    appTextStyle(
                                                                  FontWeight
                                                                      .bold,
                                                                  12.0,
                                                                  kTextColor
                                                                      .withOpacity(
                                                                    0.8,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //   right: 0,
                                      //   child: GestureDetector(
                                      //     child: CircleAvatar(
                                      //       radius: 12,
                                      //       backgroundColor: kLogoRed,
                                      //       child: Icon(
                                      //         Icons.close_rounded,
                                      //         size: 16.0,
                                      //         color: Colors.white,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      beginOffset: Offset(0, 0.3),
                      endOffset: Offset(0, 0),
                      slideCurve: Curves.linearToEaseOut,
                    );
                  } else {
                    return Center(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Hero(
                              tag: "no_data",
                              child: Material(
                                color: Colors.transparent,
                                child: Image.asset(
                                  "assets/icons/no_data.png",
                                  fit: BoxFit.fitHeight,
                                  height: 80,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('str_no_product_in_cart'),
                              style: appTextStyle(
                                FontWeight.w500,
                                14.0,
                                Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(
                            tag: "no_data",
                            child: Material(
                              color: Colors.transparent,
                              child: Image.asset(
                                "assets/icons/no_data.png",
                                fit: BoxFit.fitHeight,
                                height: 80,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Something went wrong.',
                            style: appTextStyle(
                              FontWeight.w500,
                              14.0,
                              Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }
          }
        },
      ),

      //here

      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 30,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 10,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(),
                      child: DefaultButton(
                        text: "Proceed to Payment",
                        press: () {
                          _confirmOrder(address);
                        },
                        btnColor: kGradientPrimary,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //new code from here
  _confirmOrder(String address) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmOrderPage(
          address: shippingAddress,
        ),
      ),
    );
  }

  Widget modalBottomSheetProvince() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Text(
              AppLocalizations.of(context).translate('str_province'),
              style: appTextStyle(
                FontWeight.bold,
                18.0,
                kTextColor,
              ),
            ),
          ),
          Divider(
            color: kGradientPrimary,
          ),
          Expanded(
            child: ListView.builder(
              // controller:
              //     _scrollController,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                // vertical: 16.0,
              ),
              // itemExtent: 80,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedShippingProvince = index + 1;
                      shippingProvinceController.text = locations[index].name;
                      selectedShippingDistrict = -1;
                      shippingDistrictController.text = '';
                    });

                    Navigator.pop(
                      context,
                    );
                  },
                  child: Card(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 16.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              locations[index].name,
                              style: appTextStyle(
                                FontWeight.w500,
                                14.0,
                                kTextColor,
                              ),
                            ),
                          ),
                          selectedShippingProvince == index + 1
                              ? Icon(
                                  Icons.check,
                                  size: 18,
                                  color: kGradientPrimary,
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: locations.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget modalBottomSheetDistrict() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Text(
              AppLocalizations.of(context).translate('str_district'),
              style: appTextStyle(
                FontWeight.bold,
                18.0,
                kTextColor,
              ),
            ),
          ),
          Divider(
            color: kGradientPrimary,
          ),
          Expanded(
            child: ListView.builder(
              // controller:
              //     _scrollController,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                // vertical: 16.0,
              ),
              // itemExtent: 80,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedShippingDistrict = index + 1;
                      shippingDistrictController.text =
                          locations[selectedShippingProvince - 1]
                              .districts[index]
                              .district;
                    });

                    Navigator.pop(
                      context,
                    );
                  },
                  child: Card(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 16.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              locations[selectedShippingProvince - 1]
                                  .districts[index]
                                  .district,
                              style: appTextStyle(
                                FontWeight.w500,
                                14.0,
                                kTextColor,
                              ),
                            ),
                          ),
                          selectedShippingDistrict == index + 1
                              ? Icon(
                                  Icons.check,
                                  size: 18,
                                  color: kGradientPrimary,
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount:
                  locations[selectedShippingProvince - 1].districts.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget shippingAddressWidget() {
    return Container(
      // padding: EdgeInsets.symmetric(
      //   vertical: 8.0,
      //   horizontal: 16.0,
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context).translate(
                      'str_shipping_address',
                    ),
                    style: appTextStyle(
                      FontWeight.normal,
                      18.0,
                      kTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: kDefaultColor2,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            color: Colors.white,
            child: Column(
              children: [
                TextFormField(
                  style: appTextStyle(
                    FontWeight.w500,
                    14.0,
                    kTextColor,
                  ),
                  cursorColor: kGradientPrimary,
                  autofocus: false,
                  decoration: new InputDecoration(
                    labelText: AppLocalizations.of(context).translate(
                      'str_name',
                    ),
                    labelStyle: appTextStyle(
                      FontWeight.w500,
                      16.0,
                      Colors.black54,
                    ),
                    hintStyle: appTextStyle(
                      FontWeight.w500,
                      16.0,
                      kTextColor,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: kGradientPrimary,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  controller: shippingFullNameController,
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  style: appTextStyle(
                    FontWeight.w500,
                    14.0,
                    kTextColor,
                  ),
                  cursorColor: kGradientPrimary,
                  autofocus: false,
                  decoration: new InputDecoration(
                    labelText: AppLocalizations.of(context).translate(
                      'str_mobile',
                    ),
                    labelStyle: appTextStyle(
                      FontWeight.w500,
                      16.0,
                      Colors.black54,
                    ),
                    hintStyle: appTextStyle(
                      FontWeight.w500,
                      16.0,
                      kTextColor,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: kGradientPrimary,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller: shippingContactNumberController,
                ),
                SizedBox(
                  height: 8.0,
                ),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    showModalBottomSheet(
                        context: context,
                        barrierColor: Colors.black26,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8.0,
                          ),
                        ),
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (BuildContext context,
                                StateSetter setState /*You can rename this!*/) {
                              return modalBottomSheetProvince();
                            },
                          );
                        });
                  },
                  child: TextFormField(
                    style: appTextStyle(
                      FontWeight.w500,
                      14.0,
                      kTextColor,
                    ),
                    enabled: false,
                    cursorColor: kGradientPrimary,
                    autofocus: false,
                    decoration: new InputDecoration(
                      labelText: AppLocalizations.of(context).translate(
                        'str_province',
                      ),
                      labelStyle: appTextStyle(
                        FontWeight.w500,
                        16.0,
                        Colors.black54,
                      ),
                      hintStyle: appTextStyle(
                        FontWeight.w500,
                        16.0,
                        kTextColor,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kGradientPrimary,
                        ),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                    controller: shippingProvinceController,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    showModalBottomSheet(
                        context: context,
                        barrierColor: Colors.black26,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8.0,
                          ),
                        ),
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (BuildContext context,
                                StateSetter setState /*You can rename this!*/) {
                              return modalBottomSheetDistrict();
                            },
                          );
                        });
                  },
                  child: TextFormField(
                    enabled: false,
                    style: appTextStyle(
                      FontWeight.w500,
                      14.0,
                      kTextColor,
                    ),
                    cursorColor: kGradientPrimary,
                    autofocus: false,
                    decoration: new InputDecoration(
                      labelText: AppLocalizations.of(context).translate(
                        'str_district',
                      ),
                      labelStyle: appTextStyle(
                        FontWeight.w500,
                        16.0,
                        Colors.black54,
                      ),
                      hintStyle: appTextStyle(
                        FontWeight.w500,
                        16.0,
                        kTextColor,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kGradientPrimary,
                        ),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                    controller: shippingDistrictController,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                SimpleAutoCompleteTextField(
                  key: shippingCityKey,
                  style: appTextStyle(
                    FontWeight.w500,
                    14.0,
                    kTextColor,
                  ),
                  decoration: new InputDecoration(
                    labelText: AppLocalizations.of(context).translate(
                      'str_city',
                    ),
                    labelStyle: appTextStyle(
                      FontWeight.w500,
                      16.0,
                      Colors.black54,
                    ),
                    hintStyle: appTextStyle(
                      FontWeight.w500,
                      16.0,
                      kTextColor,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: kGradientPrimary,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  controller: shippingCityController,
                  suggestions: selectedShippingDistrict != -1
                      ? locations[selectedShippingProvince - 1]
                          .districts[selectedShippingDistrict - 1]
                          .cities
                      : [],
                  textChanged: (text) => selectedShippingCity = text,
                  clearOnSubmit: false,
                  textSubmitted: (text) => setState(() {
                    if (text != "") {
                      selectedShippingCity = text;
                      shippingCityController.text = text;
                    }
                  }),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  style: appTextStyle(
                    FontWeight.w500,
                    14.0,
                    kTextColor,
                  ),
                  cursorColor: kGradientPrimary,
                  autofocus: false,
                  decoration: new InputDecoration(
                    labelText: AppLocalizations.of(context).translate(
                      'str_address',
                    ),
                    labelStyle: appTextStyle(
                      FontWeight.w500,
                      16.0,
                      Colors.black54,
                    ),
                    hintStyle: appTextStyle(
                      FontWeight.w500,
                      16.0,
                      kTextColor,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: kGradientPrimary,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  controller: shippingAddressController,
                ),
                SizedBox(
                  height: 16,
                ),
                GFButton(
                  focusColor: kGradientSecondary,
                  color: kGradientPrimary,
                  onPressed: () {
                    fullName = shippingFullNameController.text;
                    city = shippingCityController.text;
                    region = shippingProvinceController.text;
                    contact = shippingContactNumberController.text;
                    area = shippingDistrictController.text;
                    add = shippingAddressController.text;

                    setState(() {
                      address = '$add, $city, $area, $region';
                      shippingAddress = '$add, $city, $region, $area';
                      shippingContactName = fullName;
                      shippingContactNumber = contact;

                      print(shippingAddress);
                    });

                    Navigator.pop(context);
                  },
                  text: 'Add',
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
        ],
      ),
    );
  }
}
