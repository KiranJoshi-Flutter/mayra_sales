import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';
import 'package:mayrasales/model/userpreferences.dart';
import 'package:mayrasales/model/wishlist_model.dart';
import 'package:mayrasales/view/cart.dart';
import 'package:mayrasales/view/login.dart';
import 'package:mayrasales/view/productdetails2.dart';
import 'package:mayrasales/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var formatter = NumberFormat('##,##,##,###');

  Future<WishlistModel> fWishlistProducts;

  void initState() {
    super.initState();
    //_fetchProductDetails();

    fWishlistProducts = _getWishList();
  }

  Future<WishlistModel> _getWishList() async {
    var token = await UserPreferences.getToken();

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse('$baseURL/user/wishlists'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());

      var responseBody = await response.stream.bytesToString();

      print(responseBody);

      var jsonResponse = json.decode(responseBody);

      if (jsonResponse["status"] == "success") {
        WishlistModel products = wishlistModelFromJson(responseBody);

        return products;
      } else {
        return null;
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, "My Wishlist"),
        body: FutureBuilder(
          future: fWishlistProducts, // async work
          builder:
              (BuildContext context, AsyncSnapshot<WishlistModel> snapshot) {
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
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          // vertical: 16.0,
                        ),
                        // itemExtent: 80,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                    productId: snapshot.data.details[index].id,
                                    productTitle:
                                        snapshot.data.details[index].name,
                                  ),
                                ),
                              );
                            }),
                            child: Container(
                              // height: 120,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Stack(
                                        children: [
                                          FutureBuilder(
                                            future: imageURLCheck(
                                                '$thumbnailBaseURL/${snapshot.data.details[index].thumbnail}'),
                                            builder: (context, asyncSnapshot) {
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: GFButton(
                                                  textStyle: appTextStyle(
                                                    FontWeight.bold,
                                                    12.0,
                                                    kGradientPrimary,
                                                  ),
                                                  onPressed: () async {
                                                    var userLoggedIn =
                                                        await UserPreferences
                                                            .getLoginStatus();
                                                    var token =
                                                        await UserPreferences
                                                            .getToken();

                                                    if (userLoggedIn) {
                                                      // print(token);
                                                      var snackBar =
                                                          snackBarMessage(
                                                        context,
                                                        'Saving item in the cart...',
                                                        Duration(
                                                          hours: 1,
                                                        ),
                                                      );
                                                      var headers = {
                                                        'Authorization':
                                                            'Bearer $token'
                                                      };
                                                      var request =
                                                          http.Request(
                                                        'POST',
                                                        Uri.parse(
                                                            '$baseURL/user/cart/add?price=${snapshot.data.details[index].price}&product_id=${snapshot.data.details[index].id}&qty=1'),
                                                      );

                                                      request.headers
                                                          .addAll(headers);

                                                      http.StreamedResponse
                                                          response =
                                                          await request.send();

                                                      if (response.statusCode ==
                                                          200) {
                                                        var responseBody =
                                                            await response
                                                                .stream
                                                                .bytesToString();
                                                        var responseJSON =
                                                            json.decode(
                                                                responseBody);

                                                        // print(responseJSON);
                                                        snackBar.close();
                                                        snackBarMessageWithAction(
                                                          context,
                                                          AppLocalizations.of(
                                                                  context)
                                                              .translate(
                                                                  'str_add_item_cart_msg'),
                                                          Duration(
                                                            seconds: 3,
                                                          ),
                                                          AppLocalizations.of(
                                                                  context)
                                                              .translate(
                                                                  'str_go_to_cart'),
                                                          () {
                                                            // print('Go To Cart');
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Cart(),
                                                              ),
                                                            );
                                                          },
                                                        );

                                                        // toastMessage(
                                                        //     'Item added to cart',
                                                        //     kLogoGreen,
                                                        //     context);
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
                                                    } else {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              Login(
                                                            titlePage: AppLocalizations
                                                                    .of(context)
                                                                .translate(
                                                                    'str_user_login'),
                                                          ),
                                                        ),
                                                      );
                                                    }

                                                    // print(vQty);
                                                  },
                                                  icon: Icon(
                                                    Icons
                                                        .shopping_cart_outlined,
                                                    color: kGradientPrimary,
                                                    size: 16.0,
                                                  ),
                                                  text: AppLocalizations.of(
                                                          context)
                                                      .translate(
                                                    'str_add_to_cart',
                                                  ),
                                                  shape: GFButtonShape.square,
                                                  type: GFButtonType.outline,
                                                  size: GFSize.SMALL,
                                                  textColor: kGradientPrimary,
                                                  splashColor: kGradientPrimary
                                                      .withOpacity(
                                                    0.1,
                                                  ),
                                                  highlightColor:
                                                      kGradientPrimary
                                                          .withOpacity(
                                                    0.1,
                                                  ),
                                                  color: kGradientPrimary,
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: GFButton(
                                                  textStyle: appTextStyle(
                                                    FontWeight.w500,
                                                    12.0,
                                                    kLogoRed,
                                                  ),
                                                  onPressed: () async {
                                                    print(
                                                        '$baseURL/user/wishlist/remove/${snapshot.data.details[index].id}');
                                                    var snackBar =
                                                        snackBarMessage(
                                                      context,
                                                      'Removing item from the wishlist...',
                                                      Duration(
                                                        hours: 1,
                                                      ),
                                                    );
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
                                                            '$baseURL/user/wishlist/remove/${snapshot.data.details[index].id}'));

                                                    request.headers
                                                        .addAll(headers);

                                                    http.StreamedResponse
                                                        response =
                                                        await request.send();

                                                    print(response.statusCode);

                                                    if (response.statusCode ==
                                                        200) {
                                                      snackBar.close();

                                                      snackBarMessageWithAction(
                                                        context,
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                'str_delete_item_wishlist_msg'),
                                                        Duration(
                                                          seconds: 3,
                                                        ),
                                                        '',
                                                        () {},
                                                      );
                                                      setState(() {
                                                        fWishlistProducts =
                                                            _getWishList();
                                                      });
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
                                                    Icons
                                                        .delete_outline_rounded,
                                                    color: kLogoRed,
                                                    size: 16.0,
                                                  ),
                                                  text: AppLocalizations.of(
                                                          context)
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
                          );
                        },
                        itemCount: snapshot.data.details.length,
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
                                'Your Wishlist is empty',
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
        ));
  }

  // Widget cartItems(List<Detail> products, int index) {
  //   //var qty = products[index].qty;

  //   return RoundedContainer(
  //     padding: const EdgeInsets.all(0),
  //     margin: EdgeInsets.all(10),
  //     height: 130,
  //     child: Row(
  //       children: <Widget>[
  //         Container(
  //           width: 130,
  //           decoration: BoxDecoration(
  //             image: DecorationImage(
  //               image: NetworkImage(
  //                   'https://mayrasales.com/assets/images/thumbnails/${products[index].thumbnail}'),
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //         ),
  //         Flexible(
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 10),
  //             child: Column(
  //               children: <Widget>[
  //                 Row(
  //                   mainAxisSize: MainAxisSize.max,
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: <Widget>[
  //                     Flexible(
  //                       child: Text(
  //                         products[index].name,
  //                         overflow: TextOverflow.fade,
  //                         softWrap: true,
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.w600, fontSize: 15),
  //                       ),
  //                     ),
  //                     Container(
  //                       width: 50,
  //                       alignment: Alignment.centerRight,
  //                       child: IconButton(
  //                         onPressed: () {
  //                           print("Button Pressed");
  //                           removeFromWishlist(products[index].productId);
  //                         },
  //                         color: Colors.red,
  //                         icon: Icon(Icons.delete),
  //                         iconSize: 20,
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //                 Row(
  //                   children: <Widget>[
  //                     Text("Unit Price: "),
  //                     SizedBox(
  //                       width: 5,
  //                     ),
  //                     Text(
  //                       'Rs. ${products[index].price.toString()}',
  //                       style: TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.w300),
  //                     )
  //                   ],
  //                 ),
  //                 // Row(
  //                 //   children: <Widget>[
  //                 //     Text("Sub Total: "),
  //                 //     SizedBox(
  //                 //       width: 5,
  //                 //     ),
  //                 //     Text(
  //                 //         'Rs. ${(products[index].price).toString()}',
  //                 //         style: TextStyle(
  //                 //           fontSize: 16,
  //                 //           fontWeight: FontWeight.w300,
  //                 //           color: Colors.orange,
  //                 //         ))
  //                 //   ],
  //                 // ),
  //                 Row(
  //                   children: <Widget>[
  //                     Text(
  //                       "Ships Free",
  //                       style: TextStyle(color: Colors.orange),
  //                     ),
  //                     Spacer(),
  //                     Row(
  //                       children: <Widget>[
  //                         // InkWell(
  //                         //   onTap: () {
  //                         //     setState(
  //                         //       () {
  //                         //         qty--;
  //                         //       },
  //                         //     );
  //                         //     //print(qty);
  //                         //   },
  //                         //   //splashColor: Colors.redAccent.shade200,
  //                         //   child: Container(
  //                         //     decoration: BoxDecoration(
  //                         //         borderRadius: BorderRadius.circular(50)),
  //                         //     alignment: Alignment.center,
  //                         //     child: Padding(
  //                         //       padding: const EdgeInsets.all(6.0),
  //                         //       child: Icon(
  //                         //         Icons.remove,
  //                         //         color: Colors.redAccent,
  //                         //         size: 20,
  //                         //       ),
  //                         //     ),
  //                         //   ),
  //                         // ),
  //                         // IconButton(
  //                         //   onPressed: _add(qty),
  //                         //   icon: new Icon(
  //                         //     Icons.add,
  //                         //     color: Colors.black,
  //                         //   ),
  //                         //   //backgroundColor: Colors.white,
  //                         // ),
  //                         // Container(
  //                         //   child: Padding(
  //                         //     padding: const EdgeInsets.all(0.0),
  //                         //     child: Text("Quantity"),
  //                         //   ),
  //                         // ),
  //                         // SizedBox(
  //                         //   width: 8,
  //                         // ),
  //                         // Container(
  //                         //   child: Padding(
  //                         //     padding: const EdgeInsets.all(0.0),
  //                         //     child: Text(qty.toString()),
  //                         //   ),
  //                         // ),
  //                         // SizedBox(
  //                         //   width: 4,
  //                         // ),
  //                         // InkWell(
  //                         //   onTap: () {
  //                         //     setState(
  //                         //       () {
  //                         //         qty++;
  //                         //       },
  //                         //     );
  //                         //     //print(qty);
  //                         //   },
  //                         //   //splashColor: Colors.lightBlue,
  //                         //   child: Container(
  //                         //     decoration: BoxDecoration(
  //                         //         borderRadius: BorderRadius.circular(50)),
  //                         //     alignment: Alignment.center,
  //                         //     child: Padding(
  //                         //       padding: const EdgeInsets.all(6.0),
  //                         //       child: Icon(
  //                         //         Icons.add,
  //                         //         color: Colors.green,
  //                         //         size: 20,
  //                         //       ),
  //                         //     ),
  //                         //   ),
  //                         // ),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // removeFromWishlist(int productId) async {
  //   var apiToken = await UserPreferences.getApiToken();

  //   String removeFromCartURL =
  //       "https://mayrasales.com/api/user/wishlist/remove/${productId.toString()}?api_token=$apiToken";
  //   print(removeFromCartURL);

  //   var r = await Requests.get(removeFromCartURL);
  //   r.raiseForStatus();
  //   String responseBody = r.content();
  //   print(r.headers);
  //   print(r.statusCode);
  //   print(responseBody);

  //   if (r.statusCode == 200) {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => super.widget));
  //   }
  // }
}
