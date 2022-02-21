import 'dart:convert';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';
import 'package:mayrasales/model/cartlist_model.dart';
import 'package:mayrasales/model/userpreferences.dart';
import 'package:mayrasales/view/checkout_screen.dart';
import 'package:mayrasales/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  _CartState();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var formatter = NumberFormat('##,##,##,###');
  Future<CartlistModel> fCartProducts;

  int productQty = 0;

  List<int> arrayQty = [];

  List<String> images = [
    'assets/images/poco_f2_pro.webp',
    'assets/images/realmi5i.webp',
    'assets/images/tv.webp',
    'assets/images/samsung.webp',
  ];

  void initState() {
    super.initState();

    fCartProducts = _getCartList();
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

        for (int a = 0; a < products.details.length; a++) {
          setState(() {
            arrayQty.add(products.details[a].qty);
          });
        }

        print(arrayQty);
        return products;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(
          context, AppLocalizations.of(context).translate('str_my_cart')),
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
                            return Stack(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
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
                                              builder:
                                                  (context, asyncSnapshot) {
                                                if (asyncSnapshot.hasData) {
                                                  if (asyncSnapshot.data !=
                                                      null) {
                                                    return Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 4.0,
                                                        vertical: 4.0,
                                                      ),
                                                      child: Image.network(
                                                        '$thumbnailBaseURL/${snapshot.data.details[index].thumbnail}',
                                                        // fit: BoxFit.fitWidth,
                                                      ),
                                                    );
                                                  } else {
                                                    return Container(
                                                      // color: Colors.black,
                                                      // width: 200,
                                                      child: CircleAvatar(
                                                        radius: 60,
                                                        backgroundColor:
                                                            Colors.transparent,
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
                                                FontWeight.w500,
                                                16.0,
                                                kTextColor,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)
                                                          .translate('str_rs') +
                                                      " ${formatter.format(snapshot.data.details[index].price)} /-",
                                                  softWrap: true,
                                                  style: appTextStyle(
                                                    FontWeight.bold,
                                                    18.0,
                                                    kTextColor.withOpacity(0.8),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8.0,
                                                ),
                                                snapshot.data.details[index]
                                                            .previousPrice !=
                                                        0
                                                    ? Container(
                                                        height: 16.0,
                                                        child: Text(
                                                          " Rs. ${formatter.format(snapshot.data.details[index].previousPrice)} ",
                                                          style:
                                                              GoogleFonts.mukta(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12,
                                                            color: Colors.red,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            decorationThickness:
                                                                4.0,
                                                            decorationColor:
                                                                Colors.red,
                                                          ),
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)
                                                          .translate(
                                                        'str_quantity',
                                                      ) +
                                                      ' : ',
                                                  softWrap: true,
                                                  style: appTextStyle(
                                                    FontWeight.bold,
                                                    14.0,
                                                    kTextColor.withOpacity(0.8),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16.0,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      arrayQty[index] =
                                                          arrayQty[index] + 1;
                                                    });
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 9.0,
                                                    backgroundColor:
                                                        kGradientPrimary,
                                                    child: CircleAvatar(
                                                      radius: 8.0,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Center(
                                                          child: Icon(
                                                        Icons.remove,
                                                        color: kGradientPrimary,
                                                        size: 14.0,
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16.0,
                                                ),
                                                Text(
                                                  arrayQty[index].toString(),
                                                  softWrap: true,
                                                  style: appTextStyle(
                                                    FontWeight.bold,
                                                    14.0,
                                                    kTextColor.withOpacity(0.8),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16.0,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      arrayQty[index] =
                                                          arrayQty[index] + 1;
                                                    });
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 9.0,
                                                    backgroundColor:
                                                        kGradientPrimary,
                                                    child: CircleAvatar(
                                                      radius: 8.0,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Center(
                                                          child: Icon(
                                                        Icons.add_rounded,
                                                        color: kGradientPrimary,
                                                        size: 14.0,
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: GFButton(
                                                textStyle: appTextStyle(
                                                  FontWeight.w500,
                                                  12.0,
                                                  kLogoRed,
                                                ),
                                                onPressed: () async {
                                                  var snackBar =
                                                      snackBarMessage(
                                                    context,
                                                    'Removing item from the cart...',
                                                    Duration(
                                                      hours: 1,
                                                    ),
                                                  );
                                                  print(
                                                      '$baseURL/user/wishlist/remove/${snapshot.data.details[index].id}');
                                                  var token =
                                                      await UserPreferences
                                                          .getToken();
                                                  var headers = {
                                                    'Authorization':
                                                        'Bearer $token'
                                                  };
                                                  var request = http.Request(
                                                      'GET',
                                                      Uri.parse(
                                                          '$baseURL/user/cart/remove?product_id=${snapshot.data.details[index].id}&qty=1&size&color'));

                                                  request.headers
                                                      .addAll(headers);

                                                  http.StreamedResponse
                                                      response =
                                                      await request.send();

                                                  print(response.statusCode);

                                                  if (response.statusCode ==
                                                      200) {
                                                    setState(() {
                                                      fCartProducts =
                                                          _getCartList();
                                                    });
                                                    snackBar.close();
                                                    snackBarMessageWithAction(
                                                      context,
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'str_remove_item_cart_msg'),
                                                      Duration(
                                                        seconds: 3,
                                                      ),
                                                      '',
                                                      () {},
                                                    );
                                                  } else {
                                                    snackBar.close();
                                                    toastMessage(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'str_something_went_wrong'),
                                                      kLogoRed,
                                                      context,
                                                    );
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.delete_outline_rounded,
                                                  color: kLogoRed,
                                                  size: 16.0,
                                                ),
                                                text:
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                  'str_remove',
                                                ),
                                                shape: GFButtonShape.square,
                                                type: GFButtonType.outline,
                                                size: GFSize.SMALL,
                                                splashColor:
                                                    kLogoRed.withOpacity(
                                                  0.1,
                                                ),
                                                highlightColor:
                                                    kLogoRed.withOpacity(
                                                  0.1,
                                                ),
                                                color: kLogoRed,
                                              ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutScreen(),
            ),
          );
        },
        label: Row(
          children: [
            Text(
              AppLocalizations.of(context).translate('str_checkout'),
              style: appTextStyle(
                FontWeight.w500,
                16.0,
                Colors.white,
              ),
            ),
            SizedBox(
              width: 4.0,
            ),
            Icon(
              Feather.arrow_right_circle,
              size: 20.0,
            )
          ],
        ),
        // icon: Icon(Icons.thumb_up),
        backgroundColor: kGradientPrimary,
        // icon: ,
      ),
    );
  }
}
