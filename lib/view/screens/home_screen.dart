import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mayrasales/model/premium_product_model.dart';
import 'package:mayrasales/view/productdetails2.dart';
import 'package:mayrasales/widgets/ads_widget.dart';
import 'package:mayrasales/widgets/header_widget.dart';
import 'package:http/http.dart' as http;

//------------------------- HomeScreen ----------------------------------

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _active = false;
  int _selectedNavItem = 0;
  TextEditingController searchController = TextEditingController();

  final arrCategoryTitle = [
    'Fashion',
    'Smartphones',
    'Electronics',
    'Grocery',
    'Hardware',
    'Liquor',
    'Accessories',
  ];

  final arrCategoryId = [
    34,
    36,
    40,
    17,
    18,
    17,
    18,
  ];

  final arrCategoryIcons = [
    'https://mayrasales.com/assets/images/categories/1601794932fashion.png',
    'https://mayrasales.com/assets/images/categories/1601795038smartphone.png',
    'https://mayrasales.com/assets/images/categories/1601794918electronics.png',
    'https://mayrasales.com/assets/images/categories/1601794982grocery.png',
    'https://mayrasales.com/assets/images/categories/1601794999hardware.png',
    'https://mayrasales.com/assets/images/categories/1601795012liquor.png',
    'https://mayrasales.com/assets/images/categories/1602572238ddd.jpg',
  ];

  final arrCategoryBgColor = [
    kCatBgColor1,
    kCatBgColor2,
    kCatBgColor3,
    kCatBgColor4,
    kCatBgColor5,
    kCatBgColor6,
    kCatBgColor7,
  ];

  Future<PremiumProductsModel> _premiumProducts;

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        title: Text(
          AppLocalizations.of(context).translate('str_explore'),
          style: GoogleFonts.mukta(
            textStyle: TextStyle(
              fontSize: 12.0,
              color: _selectedNavItem == 0 ? kGradientPrimary : kDefaultColor,
              fontWeight:
                  _selectedNavItem == 0 ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
        icon: SvgPicture.asset(
          'assets/icons/ic_explore.svg',
          color: _selectedNavItem == 0 ? kGradientPrimary : kDefaultColor,
          height: 25,
        ),
      ),
      BottomNavigationBarItem(
        title: Text(
          AppLocalizations.of(context).translate('str_feed'),
          style: GoogleFonts.mukta(
            textStyle: TextStyle(
              fontSize: 12.0,
              color: _selectedNavItem == 1 ? kGradientPrimary : kDefaultColor,
              fontWeight:
                  _selectedNavItem == 1 ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
        icon: SvgPicture.asset(
          'assets/icons/ic_feed.svg',
          color: _selectedNavItem == 1 ? kGradientPrimary : kDefaultColor,
          height: 25,
        ),
      ),
      BottomNavigationBarItem(
        title: Text(
          'Notification',
          style: GoogleFonts.mukta(
            textStyle: TextStyle(
              fontSize: 12.0,
              color: _selectedNavItem == 2 ? kGradientPrimary : kDefaultColor,
              fontWeight:
                  _selectedNavItem == 2 ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
        icon: SvgPicture.asset(
          'assets/icons/ic_notification.svg',
          color: _selectedNavItem == 2 ? kGradientPrimary : kDefaultColor,
          height: 25,
        ),
      ),
      BottomNavigationBarItem(
        title: Text(
          'Profile',
          style: GoogleFonts.mukta(
            textStyle: TextStyle(
              fontSize: 12.0,
              color: _selectedNavItem == 3 ? kGradientPrimary : kDefaultColor,
              fontWeight:
                  _selectedNavItem == 3 ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
        icon: SvgPicture.asset(
          'assets/icons/ic_profile.svg',
          color: _selectedNavItem == 3 ? kGradientPrimary : kDefaultColor,
          height: 25,
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    _premiumProducts = _fetchPremiumProducts();
    searchController.addListener(_printLatestValue);
  }

  _printLatestValue() {
    print("Textfield value: ${searchController.text}");
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    searchController.dispose();
    super.dispose();
  }

  var dummyList = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

  // ----------------------------------------- Fetching Premium Products -----------------------------------------

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
// ----------------------------------------- Fetching Premium Products -----------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffECECEC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              // color: Colors.black,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 170,
                    color: kGradientPrimary,
                    padding: EdgeInsets.only(
                      bottom: 8.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 16.0,
                              right: 8.0,
                            ),
                            child: TextFormField(
                              scrollPadding: EdgeInsets.zero,
                              cursorColor: kLogoBlur,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    20.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 0.0,
                                  ),
                                ),
                                filled: true,
                                hintStyle: appTextStyle(
                                  FontWeight.w500,
                                  16.0,
                                  kDefaultColor,
                                ),
                                hintText: "Search...",
                                fillColor: Colors.white,
                                suffixIcon: InkWell(
                                  child: Icon(
                                    Icons.search,
                                    size: 24,
                                    color: kDefaultColor2,
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            right: 24.0,
                          ),
                          // color: Colors.black,
                          // child: IconButton(
                          //   onPressed: (() {}),
                          // icon: Icon(
                          //   Icons.shopping_cart,
                          //   size: 28,
                          //   color: Colors.white,
                          // ),
                          // ),
                          child: Badge(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0.5,
                            ),
                            padding: EdgeInsets.all(
                              8.0,
                            ),
                            badgeContent: Text(
                              '3',
                              style: appTextStyle(
                                FontWeight.normal,
                                14.0,
                                Colors.white,
                              ),
                            ),
                            badgeColor: kLogoOrange,
                            position: BadgePosition.topEnd(
                              top: -24,
                              end: -8,
                            ),
                            child: Icon(
                              Icons.shopping_cart,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 24.0,
                    left: 16.0,
                    right: 16.0,
                    child: Card(
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Container(
                        height: 100,
                        // color: kDefaultColor,
                        decoration: BoxDecoration(
                          color: kCatBgColor1,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              16,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Browse Now',
                            style: appTextStyle(
                              FontWeight.bold,
                              18.0,
                              Colors.white,
                            ),
                          ),
                        ),
                        // child: GFCarousel(
                        //   aspectRatio: 3.5,
                        //   items: imageList.map(
                        //     (url) {
                        //       return Container(
                        //         width: double.infinity,
                        //         color: kGradientPrimary,
                        //         height: 100,
                        //         child: ClipRRect(
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(5.0)),
                        //           child: Image.network(
                        //             url,
                        //             fit: BoxFit.cover,
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   ).toList(),
                        //   // items: [Text()],
                        //   onPageChanged: (index) {
                        //     setState(() {
                        //       index;
                        //     });
                        //   },
                        // ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ------------------------------ Shop By Category ------------------------------
            HeaderWidget(
              title: AppLocalizations.of(context).translate(
                'str_shop_by_category',
              ),
              onClick: (() {}),
            ),
            Container(
              // color: Colors.black45,
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              height: 80,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: arrCategoryTitle.length,
                itemBuilder: (context, index) {
                  return new Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: Container(
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            16,
                          ),
                        ),
                        border: Border.all(
                          color: arrCategoryBgColor[index],
                          width: 0.75,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: FutureBuilder(
                          future: imageURLCheck(arrCategoryIcons[index]),
                          builder: (context, asyncSnapshot) {
                            if (asyncSnapshot.hasData) {
                              if (asyncSnapshot.data != null) {
                                return Container(
                                  child: Image.network(
                                    arrCategoryIcons[index],
                                    // fit: BoxFit.fitWidth,
                                  ),
                                );
                              } else {
                                return Container(
                                  // color: Colors.black,
                                  // width: 200,
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: AssetImage(
                                      "assets/images/no_image.png",
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return CupertinoActivityIndicator(
                                radius: 5,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 4,
                  );
                },
              ),
            ),

            // ------------------------------ Shop By Category ------------------------------

            // ------------------------------ Ad Space ------------------------------

            AdsWidget(
              ad1Url: '',
              ad2Url: '',
              onClickAd1: (() {}),
              onClickAd2: (() {}),
            ),

            // ------------------------------ Ad Space ------------------------------

            SizedBox(
              height: 8.0,
            ),

            // ------------------------------ Premium Products ------------------------------

            _premiumProductsView(context),

            // ------------------------------ Premium Products ------------------------------

            SizedBox(
              height: 8.0,
            ),

            // ------------------------------ Ad Space ------------------------------

            AdsWidget(
              ad1Url: '',
              ad2Url: '',
              onClickAd1: (() {}),
              onClickAd2: (() {}),
            ),

            // ------------------------------ Ad Space ------------------------------

            SizedBox(height: 16),

            // ------------------------------ Featured Products ------------------------------
            // HeaderWidget(
            //   title: AppLocalizations.of(context).translate(
            //     'str_featured_products',
            //   ),
            //   onClick: (() {}),
            // ),

            // ------------------------------ Featured Products ------------------------------
          ],
        ),
      ),
    );
  }

  Widget _premiumProductsView(BuildContext context) {
    return FutureBuilder(
      future: _premiumProducts, // async work
      builder:
          (BuildContext context, AsyncSnapshot<PremiumProductsModel> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container(
              height: 120,
              child: GFLoader(
                type: GFLoaderType.circle,
                loaderColorOne: kGradientPrimary,
                loaderColorTwo: kGradientSecondary,
                loaderColorThree: kGradientTertiary,
              ),
            );
          default:
            if (snapshot.hasError) {
              return Text(snapshot.hasError.toString());
            } else {
              if (snapshot.data != null) {
                return Column(
                  children: [
                    HeaderWidget(
                      title: AppLocalizations.of(context).translate(
                        'str_premium_products',
                      ),
                      onClick: (() {}),
                    ),
                    Container(
                      // child: Text("Abcd"),
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.details.length,
                        physics: BouncingScrollPhysics(),
                        //   //controller: _scrollController,
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        itemBuilder: (context, index) {
                          print(snapshot.data.details[index].isDiscount);

                          var discount = 0;

                          if (snapshot.data.details[index].previousPrice != 0) {
                            var oldPrice =
                                snapshot.data.details[index].previousPrice;

                            var newPrice = snapshot.data.details[index].price;

                            // discount = int.parse((oldPrice - newPrice) / oldPrice * 100).toString();

                            var disAmt = oldPrice - newPrice;
                            discount = ((disAmt / oldPrice) * 100).toInt();

                            print('Discont Per = $discount');
                          }

                          return Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: GestureDetector(
                                onTap: () {
                                  print(snapshot.data.details[index].photo);
                                  int productId =
                                      snapshot.data.details[index].id;

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
                                child: Stack(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1.02,
                                      child: Card(
                                        elevation: 0,
                                        color: Colors.transparent,
                                        child: Container(
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                16,
                                              ),
                                            ),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4.0,
                                              horizontal: 4.0,
                                            ),
                                            child: FutureBuilder(
                                              future: imageURLCheck(
                                                  "$thumbnailBaseURL/${snapshot.data.details[index].thumbnail}"),
                                              builder:
                                                  (context, asyncSnapshot) {
                                                if (asyncSnapshot.hasData) {
                                                  if (asyncSnapshot.data !=
                                                      null) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(
                                                            16,
                                                          ),
                                                        ),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                            '$thumbnailBaseURL/${snapshot.data.details[index].thumbnail}',
                                                          ),
                                                        ),
                                                      ),
                                                      // child: Image.network(
                                                      //   '$thumbnailBaseURL/${snapshot.data.details[index].thumbnail}',
                                                      //   fit: BoxFit.cover,
                                                      // ),
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
                                                  return CupertinoActivityIndicator(
                                                    radius: 5,
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    snapshot.data.details[index]
                                                .previousPrice !=
                                            0
                                        ? Positioned(
                                            left: 0,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                left: 4.0,
                                                top: 4.0,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4.0,
                                                horizontal: 8.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(
                                                    16,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    16,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                '${discount.toInt()}% off',
                                                style: appTextStyle(
                                                  FontWeight.bold,
                                                  10,
                                                  Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
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
}
