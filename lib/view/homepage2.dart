// import 'dart:html';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';
import 'package:mayrasales/model/ads_model.dart';
import 'package:mayrasales/model/model_featured_products.dart';
//import 'package:mayrasales/model/products_model.dart';
import 'package:mayrasales/model/premium_product_model.dart';
import 'package:mayrasales/model/slider_model.dart';
import 'package:mayrasales/model/userdetails_model.dart';
//import 'package:mayrasales/model/premium_product_model.dart'
//as premiumProductModel;
import 'package:mayrasales/model/userpreferences.dart';
import 'package:http/http.dart' as http;
import 'package:mayrasales/view/appaboutus.dart';
import 'package:mayrasales/view/cart.dart';
import 'package:mayrasales/view/categorproduct.dart';
import 'package:mayrasales/view/category.dart';
import 'package:mayrasales/view/login.dart';
import 'package:mayrasales/view/orders.dart';
import 'package:mayrasales/view/productdetails2.dart';
import 'package:mayrasales/view/products.dart';
import 'package:mayrasales/view/profile.dart';
import 'package:mayrasales/view/screens/main_screen.dart';
import 'package:mayrasales/view/search.dart';
import 'package:mayrasales/view/setting.dart';
import 'package:mayrasales/wishlist.dart';
import 'package:pk_skeleton/pk_skeleton.dart';

import 'package:requests/requests.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

final titles = [
  'Fashion',
  'Smartphones',
  'Electronics',
  'Grocery',
  'Fast Food'
];

final catIds = [34, 36, 40, 17, 18];

final icons = [
  'assets/icons/ic_fashion.png',
  'assets/icons/ic_mobiles.png',
  'assets/icons/ic_electronics.png',
  'assets/icons/ic_grocery.png',
  'assets/icons/ic_fast_food.png'
];

final categoryBgColor = [
  0xfff0b8d1,
  0xffcabbf0,
  0xffa4e4fb,
  0xfff0b8d1,
  0xffcabbf0,
];

final productImages = [
  'assets/images/poco_f2_pro.webp',
  'assets/images/realmi5i.webp',
  'assets/images/tv.webp',
  'assets/images/samsung.webp',
];

class _HomeState extends State<Home> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  Widget appBarTitle = new Text("Mayra");
  Icon actionIcon = new Icon(Icons.search);
  int _current = 0;
  Drawer drawer;
  String username;
  bool loginStatus;

  Future<bool> lss;
  List<IconButton> actionList;

  Future<List<SliderModel>> fSliders;
  Future<List<AdsModel>> fAdvertise;
  List<String> bannerImgList = <String>[];

  Future<PremiumProductsModel> _premiumProducts;
  Future<FeaturedProductsModel> _featuredProducts;

  Future<String> fprofilePic;

  List<String> advertise1 = <String>[];
  List<Widget> imageSliders = <Widget>[];

  String profilePicURL;

  @override
  void initState() {
    super.initState();

    lss = _getUserLoggedIn();

    _init();
  }

  _init() {
    fSliders = _fetchSliders();

    _premiumProducts = _fetchPremiumProducts();

    _featuredProducts = _fetchFeaturedProducts();
  }

  Future<bool> _getUserLoggedIn() async {
    String apitoken = await UserPreferences.getApiToken();
    if (await UserPreferences.getLoginStatus()) {
      final String url =
          "https://mayrasales.com/api/user/details?api_token=" + apitoken;

      // print(url);

      final response = await http.get(url);

      if (response.statusCode > 199 && response.statusCode < 300) {
        final String responseString = response.body;

        UserDetailsModel userDetailsModel =
            userDetailsModelFromJson(responseString);

        UserPreferences.setContactNumber(userDetailsModel.phone);
        UserPreferences.setAddress(userDetailsModel.address);
        UserPreferences.setProfilePic(userDetailsModel.photo);

        var pp = await UserPreferences.getProfilePic();

        if (pp != null || pp != '') {
          profilePicURL =
              "https://mayrasales.com/assets/images/users/${pp.toString().replaceAll(' ', '')}";
        } else {
          profilePicURL = "";
        }
      }
    }
    return await UserPreferences.getLoginStatus() ?? false;
  }

  Future<List<SliderModel>> _fetchSliders() async {
    String url = 'https://mayrasales.com/api/slider';
    var r = await Requests.get(url);
    print(url);
    r.raiseForStatus();
    String responseBody = r.content();

    List<SliderModel> sliders = sliderModelFromJson(responseBody);

    for (var a = 0; a < sliders.length; a++) {
      bannerImgList.add(
          "https://mayrasales.com/assets/images/sliders/${sliders[a].photo}");
    }

    print(bannerImgList);
    imageSliders = bannerImgList.map((item) {
      var index = bannerImgList.indexOf(item);
      return Container(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(item, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(sliders[index].titleText,
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                        Text(
                          sliders[index].subtitleText,
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();

    return sliders;
  }

  Future<PremiumProductsModel> _fetchPremiumProducts() async {
    final request = await http.get(
      "https://mayrasales.com/api/premium_products",
      headers: {"Content-Type": "application/json"},
    );

    print("******************************************* ${request.body}");

    // print(request.statusCode);

    var response = json.decode(request.body);
    if (response["status"] == "success") {
      PremiumProductsModel premiumProductsModel =
          premiumProductsModelFromJson(request.body);
      return premiumProductsModel;
    } else {
      return null;
    }
  }

  Future<FeaturedProductsModel> _fetchFeaturedProducts() async {
    final request = await http.get(
      "https://mayrasales.com/api/featured_products",
      headers: {"Content-Type": "application/json"},
    );

    print(
        "F*E*A*T*U*R*E*D**P*R*O*D*U*C*T*S************************* ${request.body}");

    // print(request.statusCode);

    var response = json.decode(request.body);
    if (response["status"] == "success") {
      FeaturedProductsModel featuredProductsModel =
          featuredProductsModelFromJson(request.body);
      return featuredProductsModel;
    } else {
      return null;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuilder(context),
      drawer: _drawerBuild(context),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4.0),
          child: Container(
            //height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FutureBuilder(
                  future: fSliders,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return PKCardPageSkeleton(
                        totalLines: 1,
                      );
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                          color: Color(0xfff8f8f8),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
                            CarouselSlider(
                              items: imageSliders,
                              options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 3.0,
                                onPageChanged: (index, reason) {
                                  setState(
                                    () {
                                      _current = index;
                                    },
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: bannerImgList.map(
                                (url) {
                                  int index = bannerImgList.indexOf(url);
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
                                    //child: Text("Abcd"),
                                  );
                                },
                              ).toList(),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),

                Container(
                  // color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('str_shop_by_category'),
                          style: largeBoldTextStyle,
                        ),
                      ),
                      FlatButton(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        onPressed: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => Category());
                          Navigator.push(context, route);
                        },
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('str_view_all'),
                          style: appTextStyle(
                            FontWeight.normal,
                            14.0,
                            kLogoPurple.withOpacity(0.75),
                          ),

                          // TextStyle(color: Hexcolor("#ff00e5ff")),
                        ),
                      ),
                    ],
                  ),
                ),

                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 90,
                    maxHeight: 100,
                  ),
                  //maxHeight: 150.0,
                  //flex: FlexFit.loose,

                  child: new ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: titles.length,
                    itemBuilder: (context, index) {
                      return new Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Container(
                          width: 80.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CateoryProducts(
                                                categoryId: catIds[index],
                                                subCategoryId: '',
                                                categoryName:
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                  'str_' +
                                                      titles[index]
                                                          .toLowerCase()
                                                          .replaceAll(" ", "_"),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: Color(
                                              categoryBgColor[index],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Tab(
                                            icon: Container(
                                              padding: EdgeInsets.all(0.0),
                                              child: Image(
                                                image: AssetImage(
                                                  icons[index],
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              height: 25,
                                              width: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        AppLocalizations.of(context).translate(
                                            'str_' +
                                                titles[index]
                                                    .toLowerCase()
                                                    .replaceAll(" ", "_")),
                                        style: extraSmallTextStyle,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // _customDivider(context),

                SizedBox(
                  height: 8.0,
                ),

                SizedBox(
                  height: 8.0,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('str_premium_products'),
                        style: largeBoldTextStyle,
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      onPressed: () {
                        Route route =
                            MaterialPageRoute(builder: (context) => Products());
                        Navigator.push(context, route);
                      },
                      child: Text(
                        AppLocalizations.of(context).translate('str_view_all'),
                        style: appTextStyle(
                          FontWeight.normal,
                          14,
                          kLogoPurple.withOpacity(0.75),
                        ),
                      ),
                    ),
                  ],
                ),

                _premiumProductsView(context),

                SizedBox(
                  height: 8,
                ),

                // _customDivider(context),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('str_featured_products'),
                        style: largeBoldTextStyle,
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      onPressed: () {
                        Route route =
                            MaterialPageRoute(builder: (context) => Products());
                        Navigator.push(context, route);
                      },
                      child: Text(
                        AppLocalizations.of(context).translate('str_view_all'),
                        style: appTextStyle(
                          FontWeight.normal,
                          14.0,
                          kLogoPurple.withOpacity(0.75),
                        ),
                      ),
                    ),
                  ],
                ),

                // _featuredProducts(context),

                SizedBox(
                  height: 8,
                ),

                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // dynamic _advertise1Img(List<String> images) {
  //   var imgs;

  //   for (var a = 0; a < images.length; a++) {
  //     // imgs[a] = Image.network(
  //     //     'https://mayrasales.com/assets/images/banners/${images[a]}',
  //     //     fit: BoxFit.fill);

  //     imgs.add(Image.network(
  //         'https://mayrasales.com/assets/images/banners/${images[a]}',
  //         fit: BoxFit.fill));
  //   }

  //   print(imgs);

  //   return imgs;
  // }

  Widget _premiumProductsView(BuildContext context) {
    return FutureBuilder(
      future: _premiumProducts, // async work
      builder:
          (BuildContext context, AsyncSnapshot<PremiumProductsModel> snapshot) {
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
                return Container(
                  // child: Text("Abcd"),
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.details.length,
                    physics: BouncingScrollPhysics(),
                    //   //controller: _scrollController,
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: GestureDetector(
                            onTap: () {
                              print(snapshot.data.details[index].photo);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => DetailScreen(
                              //       productId: snapshot.data.data[index].id,
                              //       // arguments: ProductDetailsArguments(product: this.product),
                              //     ),
                              //   ),
                              // );
                              int productId = snapshot.data.details[index].id;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                    productId: productId,
                                    productTitle:
                                        snapshot.data.details[index].name,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                  aspectRatio: 1.02,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        // color: kLogoBlur.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: FutureBuilder(
                                        future: imageURLCheck(
                                            "$thumbnailBaseURL/${snapshot.data.details[index].thumbnail}"),
                                        builder: (context, asyncSnapshot) {
                                          if (asyncSnapshot.hasData) {
                                            if (asyncSnapshot.data) {
                                              // return Hero(
                                              //   tag: generateRandomString(16),
                                              //   child: Image.network(
                                              //     "$thumbnailBaseURL/${snapshot.data.details[index].thumbnail}",
                                              //   ),
                                              // );
                                              return ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(14.0),
                                                child: Image.network(
                                                  "$thumbnailBaseURL/${snapshot.data.details[index].thumbnail}",
                                                  // height: 150.0,
                                                  // width: 100.0,
                                                ),
                                              );
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child:
                                                        CircularProgressIndicator(
                                                      backgroundColor:
                                                          kGradientSecondary,
                                                      strokeWidth: 1,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
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
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  //     bool discounted;
                  //     Future<bool> favourite;
                  //     var finalPrice;
                  //     // var existed = false;

                  //     favourite = dbHelper
                  //         .searchItemInWishlist(snapshot.data.data[index].id);

                  //     // existed = checkFavourite(
                  //     //     snapshot.data.data[index].id);

                  //     if (snapshot.data.data[index].discount == 0) {
                  //       discounted = false;
                  //       finalPrice = snapshot.data.data[index].price;
                  //     } else {
                  //       discounted = true;
                  //       var discountAmt =
                  //           (snapshot.data.data[index].discount / 100) *
                  //               snapshot.data.data[index].price;
                  //       finalPrice =
                  //           snapshot.data.data[index].price - discountAmt;
                  //     }

                  //     print(discounted);

                  // return Padding(
                  //   padding: EdgeInsets.only(
                  //       left: getProportionateScreenWidth(20)),
                  //   child: SizedBox(
                  //     width: getProportionateScreenWidth(140),
                  //     child: GestureDetector(
                  //       onTap: () {
                  //         print(snapshot.data.data[index].slug);
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => DetailScreen(
                  //               productId: snapshot.data.data[index].id,
                  //               // arguments: ProductDetailsArguments(product: this.product),
                  //             ),
                  //           ),
                  //         );
                  //       },
                  // child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     AspectRatio(
                  //       aspectRatio: 1.02,
                  //       child: Container(
                  //         padding: EdgeInsets.all(
                  //             getProportionateScreenWidth(20)),
                  //         decoration: BoxDecoration(
                  //           color: kSecondaryColor.withOpacity(0.1),
                  //           borderRadius: BorderRadius.circular(15),
                  //         ),
                  //         child: FutureBuilder(
                  //           future: imageURLCheck(
                  //               "$imgBase${snapshot.data.data[index].image}"),
                  //           builder: (context, asyncSnapshot) {
                  //             if (asyncSnapshot.hasData) {
                  //               if (asyncSnapshot.data) {
                  //                 return Hero(
                  //                   tag: generateRandomString(16),
                  //                   child: Image.network(
                  //                     "$imgBase${snapshot.data.data[index].image}",
                  //                   ),
                  //                 );
                  //               } else {
                  //                 return Hero(
                  //                   tag: generateRandomString(16),
                  //                   child: Image.network(
                  //                     "https://www.labikineria.shop/assets/images/no_image.png",
                  //                   ),
                  //                 );
                  //               }
                  //             } else {
                  //               return Padding(
                  //                 padding: EdgeInsets.all(8.0),
                  //                 child: Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.center,
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.center,
                  //                   children: [
                  //                     Align(
                  //                       alignment: Alignment.center,
                  //                       child:
                  //                           CircularProgressIndicator(
                  //                         backgroundColor:
                  //                             kPrimaryColor,
                  //                         strokeWidth: 1,
                  //                         valueColor:
                  //                             AlwaysStoppedAnimation<
                  //                                 Color>(
                  //                           kLightColor,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               );
                  //             }
                  //           },
                  //         ),
                  //       ),
                  //     ),
                  //               const SizedBox(height: 10),
                  //               Container(
                  //                 height: getProportionateScreenHeight(
                  //                   40,
                  //                 ),
                  //                 child: Text(
                  //                   snapshot.data.data[index].name,
                  //                   style: TextStyle(
                  //                     color: Colors.black,
                  //                     fontFamily: "FCustomR",
                  //                   ),
                  //                   maxLines: 2,
                  //                   overflow: TextOverflow.ellipsis,
                  //                 ),
                  //               ),
                  //               Row(
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.spaceBetween,
                  //                 crossAxisAlignment:
                  //                     CrossAxisAlignment.baseline,
                  //                 children: [
                  //                   Text(
                  //                     "Rs. ${formatter.format(finalPrice)}",
                  //                     style: TextStyle(
                  //                       fontSize:
                  //                           getProportionateScreenWidth(16),
                  //                       color: kPrimaryColor,
                  //                       fontFamily: "FCustomB",
                  //                     ),
                  //                   ),
                  //                   FavoriteIcon(
                  //                     productId: snapshot.data.data[index].id,
                  //                     scaffoldKey: _scaffoldKey,
                  //                   ),
                  //                   // InkWell(
                  //                   //   borderRadius:
                  //                   //       BorderRadius.circular(
                  //                   //           50),
                  //                   //   onTap: () {
                  //                   //     // var add =
                  //                   //     //     dbHelper.addWishlist(
                  //                   //     //   MyWishL(
                  //                   //     //     id: null,
                  //                   //     //     productId:
                  //                   //     //         "${snapshot.data.data[index].id}",
                  //                   //     //     productImage: snapshot
                  //                   //     //         .data
                  //                   //     //         .data[index]
                  //                   //     //         .image,
                  //                   //     //     productName: snapshot
                  //                   //     //         .data
                  //                   //     //         .data[index]
                  //                   //     //         .name,
                  //                   //     //     qty: "1",
                  //                   //     //     unitPrice:
                  //                   //     //         "$finalPrice",
                  //                   //     //   ),
                  //                   //     // );
                  //                   //     // print(add);
                  //                   // _addToWishlist(snapshot
                  //                   //     .data.data[index].id);
                  //                   //   },
                  //                   //   child: Container(
                  //                   //     padding: EdgeInsets.all(
                  //                   //         getProportionateScreenWidth(
                  //                   //             8)),
                  //                   //     height:
                  //                   //         getProportionateScreenWidth(
                  //                   //             28),
                  //                   //     width:
                  //                   //         getProportionateScreenWidth(
                  //                   //             28),
                  //                   //     decoration: BoxDecoration(
                  //                   //       color: kPrimaryColor
                  //                   //           .withOpacity(0.15),
                  //                   //       shape: BoxShape.circle,
                  //                   //     ),
                  //                   //     child: SvgPicture.asset(
                  //                   //       "assets/icons/Heart Icon_2.svg",
                  //                   //       color:
                  //                   //           Color(0xFFFF4448),
                  //                   //     ),
                  //                   //   ),
                  //                   // ),
                  //                 ],
                  //               ),
                  //               SizedBox(
                  //                 height: 4.0,
                  //               ),
                  //               discounted
                  //                   ? Row(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.spaceBetween,
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.baseline,
                  //                       children: [
                  //                         Text(
                  //                           "Rs. ${formatter.format(snapshot.data.data[index].price)}",
                  //                           style: TextStyle(
                  //                             fontSize:
                  //                                 getProportionateScreenWidth(
                  //                                     12),
                  //                             color: Colors.black54,
                  //                             fontFamily: "FCustomB",
                  //                             decoration:
                  //                                 TextDecoration.lineThrough,
                  //                             decorationColor:
                  //                                 Colors.red.shade700,
                  //                           ),
                  //                         ),
                  //                         Text(
                  //                           "${snapshot.data.data[index].discount} % off",
                  //                           style: TextStyle(
                  //                             fontSize:
                  //                                 getProportionateScreenWidth(
                  //                                     12),
                  //                             color: Colors.red.shade400,
                  //                             fontFamily: "FCustomEB",
                  //                           ),
                  //                         ),
                  //                         // InkWell(
                  //                         //   borderRadius:
                  //                         //       BorderRadius.circular(
                  //                         //           50),
                  //                         //   onTap: () {},
                  //                         //   child: Container(
                  //                         //     padding: EdgeInsets.all(
                  //                         //         getProportionateScreenWidth(
                  //                         //             8)),
                  //                         //     height:
                  //                         //         getProportionateScreenWidth(
                  //                         //             28),
                  //                         //     width:
                  //                         //         getProportionateScreenWidth(
                  //                         //             28),
                  //                         //     decoration: BoxDecoration(
                  //                         //       color: kPrimaryColor
                  //                         //           .withOpacity(0.15),
                  //                         //       shape: BoxShape.circle,
                  //                         //     ),
                  //                         //     child: SvgPicture.asset(
                  //                         //       "assets/icons/Heart Icon_2.svg",
                  //                         //       color:
                  //                         //           Color(0xFFFF4848),
                  //                         //     ),
                  //                         //   ),
                  //                         // ),
                  //                       ],
                  //                     )
                  //                   : Container(),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                );
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
    );
    // return Container(
    //   padding: const EdgeInsets.only(left: 0.0, right: 0.0),
    //   height: 150,
    //   child: new ListView.builder(
    //     scrollDirection: Axis.horizontal,
    //     itemCount: pProducts.length,
    //     padding: const EdgeInsets.only(left: 8, right: 8),
    //     itemBuilder: (context, index) {
    //       return new Card(
    //         child: InkWell(
    //           onTap: () {
    //             print(pProducts[index].id);

    //             int productId = pProducts[index].id;

    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) =>
    //                     ProductDetailPage(productId: productId),
    //               ),
    //             );
    //           },
    //           child: Container(
    //             width: 100,
    //             //constraints: new BoxConstraints.expand(),
    //             margin: EdgeInsets.all(5.0),
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.all(Radius.circular(5.0)),
    //               child: Stack(
    //                 children: <Widget>[
    //                   Positioned(
    //                     child: Container(
    //                       decoration: BoxDecoration(
    //                         image: new DecorationImage(
    //                           // image: new AssetImage(productImages[index]),
    //                           image: NetworkImage(
    //                               "https://mayrasales.com/assets/images/thumbnails/${pProducts[index].thumbnail}"),
    //                           fit: BoxFit.fitWidth,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }

  // Widget _featuredProducts(BuildContext context) {
  //   if (fProducts.length != 0) {
  //     return GridView.count(
  //       crossAxisCount: 2,
  //       crossAxisSpacing: 4.0,
  //       mainAxisSpacing: 4.0,
  //       shrinkWrap: true,
  //       physics: NeverScrollableScrollPhysics(),
  //       childAspectRatio: 0.75,
  //       children: List.generate(
  //         fProducts.length,
  //         (index) {
  //           return InkWell(
  //             onTap: () {
  //               print(fProducts[index].id);
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) =>
  //                       ProductDetailPage(productId: fProducts[index].id),
  //                 ),
  //               );
  //             },
  //             child: Container(
  //               width: MediaQuery.of(context).size.width / 2,
  //               height: 260,
  //               padding: const EdgeInsets.only(left: 8, right: 0),
  //               child: Card(
  //                 child: new Container(
  //                   padding: new EdgeInsets.all(8.0),
  //                   child: new Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: <Widget>[
  //                       Container(
  //                         padding: new EdgeInsets.all(2.0),
  //                         height: 170,
  //                         child: Image.network(
  //                           "https://mayrasales.com/assets/images/thumbnails/${fProducts[index].thumbnail}",
  //                           fit: BoxFit.fitWidth,
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 8,
  //                       ),
  //                       Align(
  //                         alignment: Alignment
  //                             .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
  //                         child: Text(
  //                           fProducts[index].name,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: TextStyle(
  //                               fontSize: 14, fontWeight: FontWeight.w400),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 8,
  //                       ),
  //                       Align(
  //                         alignment: Alignment
  //                             .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
  //                         child: Text(
  //                           AppLocalizations.of(context).translate('str_rs') +
  //                               " ${fProducts[index].price.toString()}",
  //                           style: TextStyle(
  //                             fontSize: 14,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ),
  //                       //new Text('Rs. 35,000')
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     );
  //   } else {
  //     return Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0.0),
  //       child: Text(
  //         AppLocalizations.of(context).translate('str_no_item_found'),
  //         style: TextStyle(
  //           fontSize: 16.0,
  //           fontStyle: FontStyle.italic,
  //           fontWeight: FontWeight.w500,
  //         ),
  //       ),
  //     );
  //   }
  // }

  FutureOr onBack(dynamic value) {
    _drawerBuild(context);
    setState(() {});
  }

  Drawer _drawerBuild(BuildContext context) {
    return Drawer(
      child: SizedBox(
        //width: MediaQuery.of(context).size.width * 0.5,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            new SizedBox(
              height: 140.0,
              child: new DrawerHeader(
                margin: EdgeInsets.only(bottom: 0),
                decoration: BoxDecoration(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // FutureBuilder(
                    //       future: fprofilePic,
                    //       builder: (BuildContext context, AsyncSnapshot snapshot) {
                    //         //print("UserLIS = ${snapshot.data}");

                    //         if (snapshot.data != "" || snapshot.data != null) {
                    //           return Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: <Widget>[
                    //     Container(
                    //       child: Container(
                    //         width: 50,
                    //         height: 50,
                    //         decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           image: DecorationImage(
                    //               image: NetworkImage("https://mayrasales.com/assets/images/users/${snapshot.data}"),
                    //               fit: BoxFit.fill),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    //           );
                    //         }else{
                    //           return

                    //   ],
                    //           );
                    //         }
                    // )

                    FutureBuilder(
                      future: fprofilePic,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        //print("UserLIS = ${snapshot.data}");

                        if (snapshot.data == null) {
                          return Container(
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage('assets/icons/user.png'),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            child: GestureDetector(
                              onTap: () async {
                                bool userLoggedIn =
                                    await UserPreferences.getLoginStatus();

                                if (userLoggedIn) {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Profile(),
                                    ),
                                  );
                                } else {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(
                                          titlePage:
                                              AppLocalizations.of(context)
                                                  .translate('str_user_login')),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://mayrasales.com/assets/images/users/${snapshot.data}"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            // CircleAvatar(
                            //   minRadius: 60,
                            //   backgroundColor: Hexcolor("#ffff85b2"),
                            //   child: CircleAvatar(
                            //     backgroundImage
                            //         : NetworkImage(profilePicURL),
                            //     //backgroundImage: NetworkImage(
                            //     //"https://scontent.fktm1-2.fna.fbcdn.net/v/t1.0-1/p100x100/119225648_200665931405962_4949444025816031879_o.jpg?_nc_cat=107&_nc_sid=dbb9e7&_nc_ohc=atn3WVwd-9IAX_c1im2&_nc_ht=scontent.fktm1-2.fna&tp=6&oh=3b59f50fd1f3c641f023883ca5f2792c&oe=5F867D26"),
                            //     minRadius: 58,
                            //   ),
                            // ),
                          );
                          //print(snapshot.data);
                        }

                        // if (snapshot.data != "" || snapshot.data != null) {
                        //   print(
                        //       "https://mayrasales.com/assets/images/users/${snapshot.data}");
                        //   return Container(
                        //     child: Container(
                        //       width: 50,
                        //       height: 50,
                        //       decoration: BoxDecoration(
                        //         shape: BoxShape.circle,
                        //         image: DecorationImage(
                        //             image: NetworkImage(
                        //                 "https://mayrasales.com/assets/images/users/${snapshot.data.toString().replaceAll(' ', '')}"),
                        //             fit: BoxFit.fill),
                        //       ),
                        //     ),
                        //     //child: Text(snapshot.data),
                        //   );
                        // } else {
                        // return Container(
                        //   child: Container(
                        //     width: 50,
                        //     height: 50,
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       image: DecorationImage(
                        //           image: AssetImage('assets/icons/user.png'),
                        //           fit: BoxFit.fill),
                        //     ),
                        //   ),
                        // );
                        // }
                      },
                    ),

                    // Container(
                    //   child: Container(
                    //     width: 50,
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       image: DecorationImage(
                    //           image: AssetImage('assets/icons/user.png'),
                    //           fit: BoxFit.fill),
                    //     ),
                    //   ),
                    // ),

                    SizedBox(
                      height: 4,
                    ),
                    //   Text(
                    //     "Rajat Palankar",
                    //     style: TextStyle(
                    //         fontSize: 15.0,
                    //         fontWeight: FontWeight.w500,
                    //         color: Colors.white),
                    //   ),

                    // FutureBuilder(
                    //   future: lss,
                    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
                    //     //print("UserLIS = ${snapshot.data}");

                    //     if (loginStatus) {
                    //       return Container(
                    //         child: Text(
                    //           username,
                    //           style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.w600),
                    //         ),
                    //       );
                    //     } else {
                    //       return Container(
                    //         child: FlatButton(
                    //           padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                    //           onPressed: () {
                    //             /*...*/
                    //             // Toast.show("Forgot Password ..........", context,
                    //             //     duration: Toast.LENGTH_SHORT,
                    //             //     gravity: Toast.BOTTOM);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Login(
                    //       titlePage: AppLocalizations.of(context)
                    //           .translate('str_user_login'),
                    //     ),
                    //   ),
                    // );
                    //           },
                    //           child: Text(
                    //             AppLocalizations.of(context)
                    //                 .translate('str_sign_in_sign_up'),
                    //             style: TextStyle(
                    //                 color: Colors.white,
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w600),
                    //           ),
                    //         ),
                    //       );
                    //     }
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
            ListTile(
              //leading: Icon(Icons.home),
              title: Text(AppLocalizations.of(context).translate('str_home'),
                  style: TextStyle(fontSize: 16.0)),
              onTap: () {
                Navigator.pop(context);
                //   Navigator.push(
                //       context, MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
            ListTile(
              //leading: Icon(Icons.home),
              title: Text(
                  AppLocalizations.of(context)
                      .translate('str_shop_by_category'),
                  style: TextStyle(fontSize: 16.0)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Category()));
              },
            ),
            ListTile(
              //leading: Icon(Icons.home),
              title: Text(
                  AppLocalizations.of(context).translate('str_today_deal'),
                  style: TextStyle(fontSize: 16.0)),
              onTap: () {
                Navigator.pop(context);
                //   Navigator.push(
                //       context, MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
            ListTile(
              //leading: Icon(Icons.home),
              title: Text(
                  AppLocalizations.of(context)
                      .translate('str_premium_products'),
                  style: TextStyle(fontSize: 16.0)),
              onTap: () {
                Navigator.pop(context);
                //   Navigator.push(
                //       context, MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
            Container(
              margin: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 4),
              height: 0.5,
              decoration: BoxDecoration(
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
            ),
            // ListTile(
            //   //leading: Icon(Icons.home),
            //   title: Text("My Profile"),
            //   onTap: () {
            //     Navigator.pop(context);
            //     //   Navigator.push(
            //     //       context, MaterialPageRoute(builder: (context) => Profile()));
            //   },
            // ),

            ListTile(
              //leading: Icon(Icons.home),
              title: Text(
                  AppLocalizations.of(context).translate('str_my_profile'),
                  style: TextStyle(fontSize: 16.0)),
              onTap: () async {
                bool userLoggedIn = await UserPreferences.getLoginStatus();

                if (userLoggedIn) {
                  //Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ),
                  ).then(onBack);
                } else {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(
                          titlePage: AppLocalizations.of(context)
                              .translate('str_user_login')),
                    ),
                  );
                }
              },
            ),
            ListTile(
              //leading: Icon(Icons.home),
              title: Text(
                  AppLocalizations.of(context).translate('str_my_orders'),
                  style: TextStyle(fontSize: 16.0)),
              onTap: () async {
                bool userLoggedIn = await UserPreferences.getLoginStatus();
                Navigator.pop(context);
                if (userLoggedIn) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Orders(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(
                          titlePage: AppLocalizations.of(context)
                              .translate('str_user_login')),
                    ),
                  );
                }
              },
            ),
            ListTile(
              //leading: Icon(Icons.home),
              title: Text(AppLocalizations.of(context).translate('str_my_cart'),
                  style: TextStyle(fontSize: 16.0)),
              onTap: () async {
                bool userLoggedIn = await UserPreferences.getLoginStatus();
                Navigator.pop(context);
                if (userLoggedIn) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Cart(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(
                          titlePage: AppLocalizations.of(context)
                              .translate('str_user_login')),
                    ),
                  );
                }
              },
            ),
            ListTile(
              //leading: Icon(Icons.home),
              title: Text(
                  AppLocalizations.of(context).translate('str_my_wishlist'),
                  style: TextStyle(fontSize: 16.0)),
              onTap: () async {
                bool userLoggedIn = await UserPreferences.getLoginStatus();
                Navigator.pop(context);
                if (userLoggedIn) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Wishlist(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(
                          titlePage: AppLocalizations.of(context)
                              .translate('str_user_login')),
                    ),
                  );
                }
              },
            ),
            Container(
              margin: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 4),
              height: 0.5,
              decoration: BoxDecoration(
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
            ),
            ListTile(
              //leading: Icon(Icons.home),
              title: Text(
                  AppLocalizations.of(context).translate('str_about_us'),
                  style: TextStyle(fontSize: 16.0)),
              onTap: () {
                //Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AppAboutUs()));
              },
            ),
            ListTile(
              //leading: Icon(Icons.home),
              title: Text(
                  AppLocalizations.of(context)
                      .translate('str_customer_service'),
                  style: TextStyle(fontSize: 16.0)),
              onTap: () {
                Navigator.pop(context);
                //   Navigator.push(
                //       context, MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
            ListTile(
              //leading: Icon(Icons.home),
              title: Text(
                  AppLocalizations.of(context).translate('str_settings'),
                  style: TextStyle(fontSize: 16.0)),
              onTap: () {
                Navigator.pop(context);
                //   Navigator.push(
                //       context, MaterialPageRoute(builder: (context) => Profile()));

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            ),

            // FutureBuilder(
            //   future: lss,
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     //print("UserLIS = ${snapshot.data}");

            //     if (loginStatus) {
            //       return Column(
            //         children: [
            //           // ListTile(
            //           //   //leading: Icon(Icons.home),
            //           //   title: Text(
            //           //       AppLocalizations.of(context)
            //           //           .translate('str_message_us'),
            //           //       style: TextStyle(fontSize: 16.0)),
            //           //   onTap: () {
            //           //     Navigator.pop(context);
            //           //     //   Navigator.push(
            //           //     //       context, MaterialPageRoute(builder: (context) => Profile()));
            //           //   },
            //           // ),
            //           ListTile(
            //             //leading: Icon(Icons.home),
            //             title: Text(
            //                 AppLocalizations.of(context)
            //                     .translate('str_logout'),
            //                 style: TextStyle(fontSize: 16.0)),
            //             onTap: () async {
            //               //Navigator.pop(context);
            //               UserPreferences.logout();
            //               Navigator.pushReplacement(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) => super.widget));
            //             },
            //           ),
            //         ],
            //       );
            //     } else {
            //       return Column(
            //         children: [
            //           ListTile(
            //             //leading: Icon(Icons.home),
            //             title: Text(
            //                 AppLocalizations.of(context)
            //                     .translate('str_login_as_vendor'),
            //                 style: TextStyle(fontSize: 16.0)),
            //             onTap: () {
            //               // Navigator.push(
            //               //   context,
            //               //   MaterialPageRoute(
            //               //     builder: (context) => HomePage(
            //               //       titlePage: "Vendor Login",
            //               //     ),
            //               //   ),
            //               // );
            //             },
            //           ),
            //           ListTile(
            //             //leading: Icon(Icons.home),
            //             title: Text(
            //                 AppLocalizations.of(context)
            //                     .translate('str_register_as_vendor'),
            //                 style: TextStyle(fontSize: 16.0)),
            //             onTap: () {
            //               // Navigator.pop(context);
            //               // Navigator.push(
            //               //     context,
            //               //     MaterialPageRoute(
            //               //         builder: (context) => VendorRegistration()));
            //             },
            //           ),
            //         ],
            //       );
            //     }
            //   },
            // ),

            _customDivider(context),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    padding: EdgeInsets.all(8),
                    icon: new Image.asset('assets/icons/ic_facebook.png'),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    padding: EdgeInsets.all(8),
                    icon: new Image.asset('assets/icons/ic_instagram.png'),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    padding: EdgeInsets.all(8),
                    icon: new Image.asset('assets/icons/ic_twitter.png'),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    padding: EdgeInsets.all(8),
                    icon: new Image.asset('assets/icons/ic_youtube.png'),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBarBuilder(BuildContext context) {
    return AppBar(
      title: Text(
        AppLocalizations.of(context).translate('str_mayra'),
        style: GoogleFonts.mukta(
          textStyle: TextStyle(
            fontSize: 20,
            // color: kTextColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      //backgroundColor: Hexcolor("#ffff85b2"),
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
      actions: [
        IconButton(
          icon: actionIcon,
          onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          },
        ),
        IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () async {
            bool userLoggedIn = await UserPreferences.getLoginStatus();
            Navigator.pop(context);
            if (userLoggedIn) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cart(),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(
                      titlePage: AppLocalizations.of(context)
                          .translate('str_user_login')),
                ),
              );
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ),
            );
          },
        )
      ],
    );
  }
}

Widget _customDivider(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(left: 0.0, right: 0.0),
    height: 0.5,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xffff85b2), Color(0xffa797ff), Color(0xff00e5ff)],
      ),
    ),
  );
}

// Widget _FeatureProductContainer(BuildContext context) {
//   return Container(
//     margin: const EdgeInsets.only(left: 0.0, right: 0.0),
//     height: 0.5,
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [
//           Hexcolor("#ffff85b2"),
//           Hexcolor("#ffa797ff"),
//           Hexcolor("#ff00e5ff")
//         ],
//       ),
//     ),
//   );
// }

class DataSearch extends SearchDelegate<String> {
  final cities = [
    "Gent Wear",
    "Shoes",
    "Tshirts",
    "Vests",
    "Jackets",
    "Pants",
    "Jeans",
    "Hardware",
    "Laptops",
    "Computers",
    "Mobiles",
    "Smart phones",
  ];

  final recentCities = [
    "Smartphones",
    "Tshirts",
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar

    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          //close(context, null);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of app bar
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    // Navigator.push(
    //   context,
    //   new MaterialPageRoute(
    //     builder: (context) => SearchPage(query),
    //   ),
    // );

    //return null;

    return Container(
        // child: Center(
        //   child: Text(query),
        // ),

        );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for somethin

    print(query);

    // var searchLists = [];

    // if (query != "") {
    //   searchLists = _getSearchResult(query);
    // }

    final suggestionList = query.isEmpty
        ? recentCities
        : cities.where((element) => element.startsWith(query)).toList();

    return suggestionList.isEmpty
        ? Padding(
            padding: EdgeInsets.all(16.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => SearchScreen(query: query),
                  ),
                );
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xffff85b2),
                  // gradient: LinearGradient(
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  //   colors: [
                  //     Hexcolor("#ffff85b2"),
                  //     Hexcolor("#ffa797ff"),
                  //     Hexcolor("#ff00e5ff")
                  //   ],
                  // ),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate('str_search'),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ))
        : ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: (context, index) => ListTile(
              title: RichText(
                text: TextSpan(
                  text: suggestionList[index].substring(0, query.length),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: suggestionList[index].substring(query.length),
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              onTap: () {
                //showResults(context);

                print(suggestionList[index]);

                print(query);

                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) =>
                        SearchScreen(query: suggestionList[index]),
                  ),
                );
              },
            ),
          );
  }

  // List<String> _getSearchResult(String query) async {
  //   //if()
  // String getSearchURL = "https://mayrasales.com/api/search/$query";
  // var r = http.get(getSearchURL);
  // print(getSearchURL);
  // //r.raiseForStatus();
  // var responseBody = r.body;

  // search.SearchProductModel searchProducts =
  //     search.searchProductModelFromJson(responseBody);

  // var names = [];

  // if (searchProducts.status == 'success') {
  //   if (searchProducts.details.length != 0) {
  //     for (var a = 0; a < searchProducts.details.length; a++) {
  //       names.add(searchProducts.details[a].name);
  //     }
  //     print(names);
  //   }
  // }

  //return names;
}

// Future<List<User>> _getUsers() async {
//   var data = await http.get("https://jsonplaceholder.typicode.com/users");

//   var jsonData = json.decode(data.body);

//   print(jsonData);

//   List<User> users = [];

//   for (var u in jsonData) {
//     User user =
//         User(u["id"], u["name"], u["username"], u["email"], u["website"]);

//     users.add(user);
//   }

//   print("aaaaaaaa");

//   return users;
// }
//}

// class User {
//   final int id;
//   final String name;
//   final String username;
//   final String email;
//   final String website;

//   User(this.id, this.name, this.username, this.email, this.website);
// }
