import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';
import 'package:mayrasales/model/model_product_details.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:mayrasales/model/userpreferences.dart';
import 'package:mayrasales/view/cart.dart';
import 'package:mayrasales/view/login.dart';
import 'package:mayrasales/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mayrasales/wishlist.dart';
import 'package:social_share/social_share.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;
  final String productTitle;
  const ProductDetailScreen({Key key, this.productId, this.productTitle})
      : super(key: key);
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

List<String> imgList = [
  // 'https://www.gizmochina.com/wp-content/uploads/2020/01/Xiaomi-Mi-10-Pro-5G-1-500x500.jpg',
  // 'https://i01.appmifile.com/webfile/globalimg/in/cms/D1301D76-E04D-EF09-6195-53229DE6D543.jpg',
  // 'https://img.gkbcdn.com/p/2020-04-28/Xiaomi-Mi-10-Lite-6-57-Inch-5G-Smartphone-6GB-128GB-Gray-903190-._w500_.jpg'
];

var screenSize = 0;

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  var formatter = NumberFormat('##,##,##,###');
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int _n = 0;
  int _current = 0;
  int vQty = 0;

  var productPrice = 0;

  Future<ProductDetailsModel> _productDetails;
  List<Widget> imageSliders = List<Widget>();

  bool isWishlist = false;

  @override
  void initState() {
    super.initState();

    _productDetails = _fetchProductDetails();
  }

  Future<ProductDetailsModel> _fetchProductDetails() async {
    var request = await http.get("$baseURL/product/${widget.productId}");

    print("https://mayrasales.com/api/product/${widget.productId}");

    var response = request.body;

    var jsonResponse = json.decode(request.body);

    if (jsonResponse["status"] == "success") {
      ProductDetailsModel productDetailsModel =
          productDetailsModelFromJson(response);

      imgList = [];
      print(
          "https://mayrasales.com/assets/images/products = ${productDetailsModel.details.photo}");

      productPrice = productDetailsModel.details.price;

      if (productDetailsModel.gallery.length != 0) {
        for (var u = 0; u < productDetailsModel.gallery.length; u++) {
          print("$u" + productDetailsModel.gallery[u].photo);
          imgList.add(
              "https://mayrasales.com/assets/images/products/${productDetailsModel.gallery[u].photo}");
        }
      } else {
        print(
            "productDetailsModel.details.photo = ${productDetailsModel.details.thumbnail}");
        imgList.add(
            "https://mayrasales.com/assets/images/thumbnails/${productDetailsModel.details.thumbnail}");
      }

      imageSliders = imgList
          .map(
            (item) => Container(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                //color: Hexcolor("#ffa797ff"),
                margin: EdgeInsets.all(0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Stack(
                    children: <Widget>[
                      FutureBuilder(
                        future: imageURLCheck(item),
                        builder: (context, asyncSnapshot) {
                          if (asyncSnapshot.hasData) {
                            print("ITEM = $item");
                            if (asyncSnapshot.data) {
                              return Image.network(item,
                                  fit: BoxFit.fitHeight, width: 1000.0);
                            } else {
                              return Hero(
                                tag: generateRandomString(16),
                                child: Image.asset(
                                  "assets/icons/no_image.png",
                                ),
                              );
                            }
                          } else {
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(
                                      backgroundColor: kGradientSecondary,
                                      strokeWidth: 1,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        kGradientTertiary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList();

      return productDetailsModel;
    } else {
      return null;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      // appBar: buildAppBar(context, widget.productTitle),
      appBar: AppBar(
        //iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        titleSpacing: 0.0,
        elevation: 0.5,
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
        title: Text(
          widget.productTitle,
          style: appTextStyle(
            FontWeight.w500,
            20.0,
            Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       _addToCart(widget.productId, productPrice);
        //     },
        //     child: Container(
        //       padding: EdgeInsets.only(
        //         right: 16.0,
        //       ),
        //       child: Icon(
        //         Icons.add_shopping_cart_rounded,
        //         color: kLightColor,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: FutureBuilder(
        future: _productDetails, // async work
        builder: (BuildContext context,
            AsyncSnapshot<ProductDetailsModel> snapshot) {
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
                  print(snapshot.data.details.isDiscount);

                  // var isDiscounted = snapshot.data.details.isDiscount;
                  var isDiscounted = 5;

                  bool discounted;

                  var finalPrice;
                  var discount = 0;

                  if (isDiscounted != 0) {
                    discounted = true;
                  } else {
                    discounted = false;
                    finalPrice = snapshot.data.details.price;
                  }

                  if (snapshot.data.details.previousPrice != 0) {
                    var oldPrice = snapshot.data.details.previousPrice;

                    var newPrice = snapshot.data.details.price;

                    // discount = int.parse((oldPrice - newPrice) / oldPrice * 100).toString();

                    var disAmt = oldPrice - newPrice;
                    discount = ((disAmt / oldPrice) * 100).toInt();

                    print('Discont Per = $discount');
                  }

                  return SafeArea(
                      child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      SingleChildScrollView(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          //decoration: BoxDecoration(
                          padding: EdgeInsets.only(top: 16),
                          color: Color(0xffffffff),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Stack(
                                children: [
                                  CarouselSlider(
                                    items: imageSliders,
                                    options: CarouselOptions(
                                      autoPlay: false,
                                      enlargeCenterPage: true,
                                      aspectRatio: 1.8,
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      onPageChanged: (index, reason) {
                                        setState(
                                          () {
                                            _current = index;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  snapshot.data.details.previousPrice != 0
                                      ? Positioned(
                                          left: 16,
                                          child: Container(
                                            height: 54,
                                            width: 54,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                // colorFilter: ColorFilter.mode(
                                                //   Colors.red,
                                                //   BlendMode.color,
                                                // ),
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                  'assets/icons/sticker.png',
                                                ),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '$discount % off',
                                                style: appTextStyle(
                                                  FontWeight.bold,
                                                  12.0,
                                                  Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  Positioned(
                                    right: 16,
                                    bottom: 0,
                                    child: Container(
                                      height: 54,
                                      width: 54,
                                      child: IconButton(
                                        // child: Text(
                                        //   '$discount % off',
                                        //   style: appTextStyle(
                                        //     FontWeight.bold,
                                        //     12.0,
                                        //     Colors.white,
                                        //   ),
                                        // ),
                                        icon: Icon(
                                          isWishlist
                                              ? Icons.favorite_border
                                              : Icons.favorite_border_rounded,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async {
                                          var userLoggedIn =
                                              await UserPreferences
                                                  .getLoginStatus();
                                          var token =
                                              await UserPreferences.getToken();

                                          if (userLoggedIn) {
                                            print(userLoggedIn);
                                            if (isWishlist) {
                                              print('removed');
                                              var snackBar = snackBarMessage(
                                                context,
                                                'Removing item from the wishlist...',
                                                Duration(
                                                  hours: 1,
                                                ),
                                              );
                                              var headers = {
                                                'Authorization': 'Bearer $token'
                                              };
                                              var request = http.Request(
                                                  'GET',
                                                  Uri.parse(
                                                      '$baseURL/user/wishlist/remove/${widget.productId}'));

                                              request.headers.addAll(headers);

                                              http.StreamedResponse response =
                                                  await request.send();

                                              if (response.statusCode == 200) {
                                                snackBar.close();

                                                snackBarMessageWithAction(
                                                  context,
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'str_delete_item_wishlist_msg'),
                                                  Duration(
                                                    seconds: 3,
                                                  ),
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'str_go_to_wishlist'),
                                                  () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Wishlist(),
                                                      ),
                                                    );
                                                  },
                                                );
                                              } else {
                                                snackBar.close();

                                                toastMessage(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'str_something_went_wrong'),
                                                  kLogoRed,
                                                  context,
                                                );
                                                print(response.reasonPhrase);
                                              }
                                            } else {
                                              print('added');
                                              var snackBar = snackBarMessage(
                                                context,
                                                'Adding item to the wishlist...',
                                                Duration(
                                                  hours: 1,
                                                ),
                                              );
                                              var headers = {
                                                'Authorization': 'Bearer $token'
                                              };
                                              var request = http.Request(
                                                  'GET',
                                                  Uri.parse(
                                                      '$baseURL/user/wishlist/add/${widget.productId}'));

                                              request.headers.addAll(headers);

                                              http.StreamedResponse response =
                                                  await request.send();

                                              if (response.statusCode == 200) {
                                                snackBar.close();
                                                snackBarMessageWithAction(
                                                  context,
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'str_add_item_wishlist_msg'),
                                                  Duration(
                                                    seconds: 3,
                                                  ),
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'str_go_to_wishlist'),
                                                  () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Wishlist(),
                                                      ),
                                                    );
                                                  },
                                                );
                                              } else {
                                                snackBar.close();

                                                toastMessage(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'str_something_went_wrong'),
                                                  kLogoRed,
                                                  context,
                                                );
                                              }
                                            }
                                            setState(() {
                                              isWishlist = !isWishlist;
                                              print('isWishlist = $isWishlist');
                                            });
                                          } else {
                                            print('reqire to login first');
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Login(
                                                  titlePage:
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'str_user_login'),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: imgList.map(
                                  (url) {
                                    int index = imgList.indexOf(url);
                                    return Container(
                                      width: 8.0,
                                      height: 8.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _current == index
                                            ? Color.fromRGBO(0, 0, 0, 0.9)
                                            : Color.fromRGBO(0, 0, 0, 0.4),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 4.0, bottom: 4.0),
                                height: 0.5,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xffff85b2),
                                      Color(0xffa797ff),
                                      Color(0xff00e5ff),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  snapshot.data.details.name,
                                  softWrap: true,
                                  style: appTextStyle(
                                    FontWeight.w600,
                                    20.0,
                                    kTextColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                    .translate('str_rs') +
                                                " ${formatter.format(snapshot.data.details.price)} /-",
                                            softWrap: true,
                                            style: appTextStyle(
                                              FontWeight.bold,
                                              22.0,
                                              kTextColor.withOpacity(0.8),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          snapshot.data.details.previousPrice !=
                                                  0
                                              ? Container(
                                                  height: 16.0,
                                                  child: Text(
                                                    " Rs. ${formatter.format(snapshot.data.details.previousPrice)} ",
                                                    style: GoogleFonts.mukta(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      color: Colors.red,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationThickness: 4.0,
                                                      decorationColor:
                                                          Colors.red,
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      icon: Icon(Icons.share),
                                      iconSize: 24.0,
                                      onPressed: () {
                                        SocialShare.shareFacebookStory(
                                            imgList[0],
                                            "#ffffff",
                                            "#000000",
                                            "https://deep-link-url",
                                            appId: "305953653803550");
                                        /*...*/
                                        // Toast.show("Forgot Password ..........", context,
                                        //     duration: Toast.LENGTH_SHORT,
                                        //     gravity: Toast.BOTTOM);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              ExpansionTile(
                                collapsedIconColor: kGradientPrimary,
                                iconColor: kLogoBlur,
                                initiallyExpanded: true,
                                title: Text(
                                  AppLocalizations.of(context).translate(
                                    'str_product_description',
                                  ),
                                  style: appTextStyle(
                                    FontWeight.bold,
                                    16.0,
                                    kTextColor,
                                  ),
                                ),
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        bottom: 8, left: 16, right: 8),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Html(
                                        data: snapshot.data.details.details,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ExpansionTile(
                                collapsedIconColor: kGradientPrimary,
                                iconColor: kLogoBlur,
                                title: Text(
                                  AppLocalizations.of(context)
                                      .translate('str_seller_info'),
                                  style: appTextStyle(
                                    FontWeight.bold,
                                    16.0,
                                    kTextColor,
                                  ),
                                ),
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      AppLocalizations.of(context)
                                          .translate('str_shop_name'),
                                      style: appTextStyle(
                                        FontWeight.w500,
                                        14.0,
                                        kTextColor,
                                      ),
                                    ),
                                    subtitle: Text(
                                      snapshot.data.details.shopName,
                                      style: appTextStyle(
                                        FontWeight.normal,
                                        12.0,
                                        kTextColor,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      AppLocalizations.of(context).translate(
                                        'str_owner_name',
                                      ),
                                      style: appTextStyle(
                                        FontWeight.w500,
                                        14.0,
                                        kTextColor,
                                      ),
                                    ),
                                    subtitle: Text(
                                      snapshot.data.details.ownerName,
                                      style: appTextStyle(
                                        FontWeight.normal,
                                        12.0,
                                        kTextColor,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      AppLocalizations.of(context).translate(
                                        'str_address',
                                      ),
                                      style: appTextStyle(
                                        FontWeight.w500,
                                        14.0,
                                        kTextColor,
                                      ),
                                    ),
                                    subtitle: Text(
                                      snapshot.data.details.shopAddress,
                                      style: appTextStyle(
                                        FontWeight.normal,
                                        12.0,
                                        kTextColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: GFButton(
                                        textStyle: appTextStyle(
                                          FontWeight.bold,
                                          12.0,
                                          kGradientPrimary,
                                        ),
                                        onPressed: () {},
                                        text: AppLocalizations.of(context)
                                            .translate('str_visit_store'),
                                        shape: GFButtonShape.square,
                                        type: GFButtonType.outline,
                                        color: kGradientPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ));
                } else {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Text(
                      'No products found.',
                      style: notFoundTextStyle,
                      //textAlign: TextAlign.center,
                    ),
                  );
                }
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _addToCart(widget.productId, productPrice);
        },
        icon: Icon(
          Icons.shopping_cart_outlined,
          size: 20.0,
        ),
        label: Text(
          AppLocalizations.of(context).translate('str_add_to_cart'),
          style: appTextStyle(
            FontWeight.w600,
            14.0,
            Colors.white,
          ),
        ),
        // icon: Icon(Icons.thumb_up),
        backgroundColor: kGradientPrimary,
      ),
    );
  }

  _addToCart(int productId, dynamic price) async {
    var userLoggedIn = await UserPreferences.getLoginStatus();
    var token = await UserPreferences.getToken();

    if (userLoggedIn) {
      print(token);

      var snackBar = snackBarMessage(
        context,
        'Saving item in the cart...',
        Duration(
          hours: 1,
        ),
      );

      var headers = {'Authorization': 'Bearer $token'};
      var request = http.Request(
        'POST',
        Uri.parse(
            '$baseURL/user/cart/add?price=$price&product_id=$productId&qty=1'),
      );

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        snackBar.close();
        var responseBody = await response.stream.bytesToString();
        var responseJSON = json.decode(responseBody);

        print(responseJSON);
        snackBarMessageWithAction(
          context,
          AppLocalizations.of(context).translate('str_add_item_cart_msg'),
          Duration(
            seconds: 3,
          ),
          AppLocalizations.of(context).translate('str_go_to_cart'),
          () {
            // print('Go To Cart');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Cart(),
              ),
            );
          },
        );

        // toastMessage('Item added to cart', kLogoGreen, context);
      } else {
        snackBar.close();
        print(response.reasonPhrase);
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(
            titlePage: AppLocalizations.of(context).translate('str_user_login'),
          ),
        ),
      );
    }
  }
}
