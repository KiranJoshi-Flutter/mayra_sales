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
import 'package:mayrasales/model/search_result_model.dart';
import 'package:mayrasales/model/userpreferences.dart';
import 'package:mayrasales/view/cart.dart';
import 'package:mayrasales/view/home_screen.dart';
import 'package:mayrasales/view/login.dart';
import 'package:mayrasales/view/productdetails2.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mayrasales/widgets/widgets.dart';
import 'package:recase/recase.dart';

class SearchResultScreen extends StatefulWidget {
  final List<Product> productList;
  final String query;
  const SearchResultScreen({
    Key key,
    this.productList,
    this.query,
  }) : super(key: key);
  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  _SearchResultScreenState();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var formatter = NumberFormat('##,##,##,###');

  TextEditingController searchController = TextEditingController();

  List<Product> searchedList = [];
  List<String> productListName = [];

  Future<SearchResultModel> searchResult;

  void initState() {
    super.initState();

    init();

    searchResult = fetchSearchResult();
  }

  init() {
    print(widget.productList[0].title);

    for (int a = 0; a < widget.productList.length; a++) {
      productListName.add(widget.productList[a].title);
    }
  }

  Future<SearchResultModel> fetchSearchResult() async {
    var request =
        http.Request('GET', Uri.parse('$baseURL/search/${widget.query}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var responseJSON = json.decode(responseBody);

      print(responseJSON);

      if (responseJSON['status'] == 'success') {
        SearchResultModel searchResults =
            searchResultModelFromJson(responseBody);
        return searchResults;
      } else {
        return null;
      }
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context, widget.query.toString().titleCase),
      body: FutureBuilder(
        future: searchResult, // async work
        builder:
            (BuildContext context, AsyncSnapshot<SearchResultModel> snapshot) {
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
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
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
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailScreen(
                                            productId:
                                                snapshot.data.details[index].id,
                                            productTitle: snapshot
                                                .data.details[index].name,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: IntrinsicHeight(
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
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                  8.0,
                                                                ),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                  8.0,
                                                                ),
                                                              ),
                                                              image:
                                                                  DecorationImage(
                                                                image: NetworkImage(
                                                                    '$thumbnailBaseURL/${snapshot.data.details[index].thumbnail}'),
                                                              ),
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
                                                            child: CircleAvatar(
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
                                                      FontWeight.w500,
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
                                                          FontWeight.bold,
                                                          18.0,
                                                          kTextColor
                                                              .withOpacity(0.8),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8.0,
                                                      ),
                                                      snapshot
                                                                  .data
                                                                  .details[
                                                                      index]
                                                                  .previousPrice !=
                                                              0
                                                          ? Container(
                                                              height: 16.0,
                                                              child: Text(
                                                                " Rs. ${formatter.format(snapshot.data.details[index].previousPrice)} ",
                                                                style:
                                                                    GoogleFonts
                                                                        .mukta(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .red,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                  decorationThickness:
                                                                      4.0,
                                                                  decorationColor:
                                                                      Colors
                                                                          .red,
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: GFButton(
                                                          textStyle:
                                                              appTextStyle(
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
                                                                  .addAll(
                                                                      headers);

                                                              http.StreamedResponse
                                                                  response =
                                                                  await request
                                                                      .send();

                                                              if (response
                                                                      .statusCode ==
                                                                  200) {
                                                                var responseBody =
                                                                    await response
                                                                        .stream
                                                                        .bytesToString();

                                                                // print(responseJSON);
                                                                snackBar
                                                                    .close();
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
                                                                    Navigator
                                                                        .push(
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
                                                                snackBar
                                                                    .close();
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
                                                                  builder:
                                                                      (context) =>
                                                                          Login(
                                                                    titlePage: AppLocalizations.of(
                                                                            context)
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
                                                            color:
                                                                kGradientPrimary,
                                                            size: 16.0,
                                                          ),
                                                          text: AppLocalizations
                                                                  .of(context)
                                                              .translate(
                                                            'str_add_to_cart',
                                                          ),
                                                          shape: GFButtonShape
                                                              .square,
                                                          type: GFButtonType
                                                              .outline,
                                                          size: GFSize.SMALL,
                                                          textColor:
                                                              kGradientPrimary,
                                                          splashColor:
                                                              kGradientPrimary
                                                                  .withOpacity(
                                                            0.1,
                                                          ),
                                                          highlightColor:
                                                              kGradientPrimary
                                                                  .withOpacity(
                                                            0.1,
                                                          ),
                                                          color:
                                                              kGradientPrimary,
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
                                child: Icon(
                                  AntDesign.search1,
                                  size: 32,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('str_no_result_found'),
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
    );
  }
}
