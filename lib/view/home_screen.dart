import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';
import 'package:mayrasales/model/all_products_model.dart';
import 'package:mayrasales/model/home_screen_model.dart';
import 'package:mayrasales/model/userpreferences.dart';
import 'package:http/http.dart' as http;
import 'package:mayrasales/view/appaboutus.dart';
import 'package:mayrasales/view/cart.dart';
import 'package:mayrasales/view/categorproduct.dart';
import 'package:mayrasales/view/category.dart';
import 'package:mayrasales/view/login.dart';
import 'package:mayrasales/view/orders.dart';
import 'package:mayrasales/view/productdetails2.dart';
import 'package:mayrasales/view/profile.dart';
import 'package:mayrasales/view/screens/main_screen.dart';
import 'package:mayrasales/view/search.dart';
import 'package:mayrasales/view/search_screen.dart';
import 'package:mayrasales/view/setting.dart';
import 'package:mayrasales/widgets/ads_widget.dart';
import 'package:mayrasales/widgets/header_widget.dart';
import 'package:mayrasales/wishlist.dart';
import 'package:search_page/search_page.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
// import 'package:hexcolor/hexcolor.dart';

class Person {
  final String name, surname;
  final num age;

  Person(this.name, this.surname, this.age);
}

class Product {
  final dynamic id;
  final String title, price, img;
  final DateTime uploaded;
  // final num age;

  Product(
    this.id,
    this.title,
    this.price,
    this.img,
    this.uploaded,
  );
}

class NHomeScreen extends StatefulWidget {
  @override
  _NHomeScreenState createState() => _NHomeScreenState();
}

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

List<Person> people = [
  Person('Goldstar', 'Shoes', 64),
  Person('Todd', 'Black', 30),
  Person('Ahmad', 'Edwards', 55),
  Person('Anthony', 'Johnson', 67),
  Person('Annette', 'Brooks', 39),
];

List<Product> productList = [];

class _NHomeScreenState extends State<NHomeScreen> {
  bool isLoggedIn = false;

  Future<HomeScreenModel> _homeScreen;
  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();

    // fetchProducts = _fetchProductList();

    _init();

    _homeScreen = fetchHomeScreen();
  }

  _init() async {
    var loginStatus = await UserPreferences.getLoginStatus();

    // print('loginStatus = $loginStatus');
    if (loginStatus) {
      var un = await UserPreferences.getUsername();
      var em = await UserPreferences.getEmail();
      setState(() {
        isLoggedIn = loginStatus;
        userName = un;
        userEmail = em;
      });
    }

    final request = await http.get(
      "$baseURL/products",
    );

    // print(request.body);

    var res = json.decode(request.body);

    // print(res);

    if (res["status"] == "success") {
      AllProductModel allProducts = allProductModelFromJson(request.body);
      // return appProducts;

      List<Product> list = [];

      for (int a = 0; a < allProducts.details.length; a++) {
        list.add(
          Product(
            allProducts.details[a].id,
            allProducts.details[a].name,
            allProducts.details[a].price.toString(),
            allProducts.details[a].thumbnail,
            allProducts.details[a].updatedAt,
          ),
        );
      }

      // print(list);

      setState(() {
        productList = list;
      });
    }
  }

  Future<HomeScreenModel> fetchHomeScreen() async {
    final request = await http.get(
      "$baseURL/home",
    );

    // print(request.body);

    var res = json.decode(request.body);

    // print(res);

    if ((request.statusCode == 200) || (request.statusCode == 201)) {
      HomeScreenModel homeScreenModel = homeScreenModelFromJson(request.body);
      return homeScreenModel;
    } else {
      return null;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate(
            'str_mayra',
          ),
          style: appTextStyle(
            FontWeight.w500,
            20.0,
            Colors.white,
          ),
        ),
        flexibleSpace: Container(
          height: 100,
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
            color: kGradientPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () async {
              bool userLoggedIn = await UserPreferences.getLoginStatus();
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
            70,
          ),
          child: Container(
            // color: Colors.black,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
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
              color: kGradientPrimary,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.zero,
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
                          color: kGradientPrimary,
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
                      // on
                      suffixIcon: InkWell(
                        child: Icon(
                          Icons.search,
                          size: 24,
                          color: kDefaultColor2,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewSearchScreen(
                                productList: productList,
                              ),
                            ),
                          );
                          // showSearch(
                          //   context: context,
                          //   delegate: SearchPage<Person>(
                          //     onQueryUpdate: (s) => print(s),
                          //     items: people,
                          //     searchLabel: 'Search item',
                          //     suggestion: Center(
                          //       child: Text(
                          //         'Search Product',
                          //       ),
                          //     ),
                          //     failure: Center(
                          //       child: Text('No product found :('),
                          //     ),
                          //     filter: (person) => [
                          //       person.name,
                          //       person.surname,
                          //       person.age.toString(),
                          //     ],
                          //     builder: (person) => ListTile(
                          //       title: Text(person.name),
                          //       subtitle: Text(person.surname),
                          //       trailing: Text('${person.age} yo'),
                          //     ),
                          //   ),
                          // );
                        },
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewSearchScreen(
                            productList: productList,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 2.0,
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              padding: EdgeInsets.all(
                16.0,
              ),
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
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GFAvatar(
                    radius: 33.0,
                    backgroundColor: kLogoPurple,
                    child: GFAvatar(
                      radius: 32.0,
                      backgroundColor: Colors.black.withOpacity(0.5),
                      // borderRadius: BorderRadius.all(Radius.circular(16)),

                      backgroundImage: AssetImage(
                        "assets/icons/logo.png",
                      ),
                    ),
                  ),
                  isLoggedIn
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.0),
                            Container(
                              width: double.infinity,
                              child: Text(
                                userName,
                                style: appTextStyle(
                                  FontWeight.bold,
                                  16.0,
                                  Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Text(
                                userEmail,
                                style: appTextStyle(
                                  FontWeight.w500,
                                  14.0,
                                  Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(
                                    titlePage:
                                        AppLocalizations.of(context).translate(
                                      'str_user_login',
                                    ),
                                  ),
                                ),
                              );
                            },
                            // onPressed: () {},
                            child: Text(
                              AppLocalizations.of(context).translate(
                                'str_sign_in_sign_up',
                              ),
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context).translate('str_home'),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kTextColor,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    //leading: Icon(Icons.home),
                    title: Text(
                      AppLocalizations.of(context)
                          .translate('str_shop_by_category'),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kTextColor,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Category()));
                    },
                  ),
                  // ListTile(
                  //   //leading: Icon(Icons.home),
                  //   title: Text(
                  //     AppLocalizations.of(context).translate('str_today_deal'),
                  //     style: TextStyle(
                  //       fontSize: 16.0,
                  //       color: kTextColor,
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     //   Navigator.push(
                  //     //       context, MaterialPageRoute(builder: (context) => Profile()));
                  //   },
                  // ),
                  // ListTile(
                  //   //leading: Icon(Icons.home),
                  //   title: Text(
                  //     AppLocalizations.of(context)
                  //         .translate('str_premium_products'),
                  //     style: TextStyle(
                  //       fontSize: 16.0,
                  //       color: kTextColor,
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     //   Navigator.push(
                  //     //       context, MaterialPageRoute(builder: (context) => Profile()));
                  //   },
                  // ),
                  Divider(
                    color: kDefaultColor2,
                  ),
                  isLoggedIn
                      ? ListTile(
                          title: Text(
                            AppLocalizations.of(context)
                                .translate('str_my_profile'),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: kTextColor,
                            ),
                          ),
                          onTap: () async {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profile(),
                              ),
                            );
                          },
                        )
                      : Container(),
                  isLoggedIn
                      ? ListTile(
                          //leading: Icon(Icons.home),
                          title: Text(
                            AppLocalizations.of(context)
                                .translate('str_my_orders'),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: kTextColor,
                            ),
                          ),
                          onTap: () async {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Orders(),
                              ),
                            );
                          },
                        )
                      : Container(),
                  isLoggedIn
                      ? ListTile(
                          //leading: Icon(Icons.home),
                          title: Text(
                            AppLocalizations.of(context)
                                .translate('str_my_cart'),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: kTextColor,
                            ),
                          ),
                          onTap: () async {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Cart(),
                              ),
                            );
                          },
                        )
                      : Container(),
                  isLoggedIn
                      ? ListTile(
                          title: Text(
                            AppLocalizations.of(context)
                                .translate('str_my_wishlist'),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: kTextColor,
                            ),
                          ),
                          onTap: () async {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Wishlist(),
                              ),
                            );
                          },
                        )
                      : Container(),
                  isLoggedIn
                      ? Divider(
                          color: kDefaultColor2,
                        )
                      : Container(),
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context).translate('str_about_us'),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kTextColor,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppAboutUs(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    //leading: Icon(Icons.home),
                    title: Text(
                      AppLocalizations.of(context).translate('str_settings'),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kTextColor,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsPage(),
                        ),
                      );
                    },
                  ),
                  isLoggedIn
                      ? ListTile(
                          title: Text(
                            AppLocalizations.of(context)
                                .translate('str_logout'),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: kTextColor,
                            ),
                          ),
                          onTap: () async {
                            UserPreferences.logout();
                            setState(() {
                              isLoggedIn = false;
                            });
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => Wishlist(),
                            //   ),
                            // );
                          },
                        )
                      : Container(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 4.0,
                ),
                child: Row(
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
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: _homeScreen, // async work
        builder:
            (BuildContext context, AsyncSnapshot<HomeScreenModel> snapshot) {
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
                  return FadedSlideAnimation(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            width: double.infinity,
                            // padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CarouselSlider.builder(
                                  itemCount:
                                      snapshot.data.homeScreen.sliders.length,
                                  itemBuilder: (
                                    BuildContext context,
                                    int itemIndex,
                                    int pageViewIndex,
                                  ) {
                                    return GestureDetector(
                                      onTap: (() {
                                        launchURL(snapshot.data.homeScreen
                                            .sliders[itemIndex].link);
                                      }),
                                      child: Card(
                                        elevation: 1.25,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black87,
                                            borderRadius: BorderRadius.circular(
                                              8.0,
                                            ),
                                            image: DecorationImage(
                                              colorFilter: ColorFilter.mode(
                                                Colors.black.withOpacity(0.8),
                                                BlendMode.dstATop,
                                              ),
                                              image: NetworkImage(
                                                '$bannerBaseURL/${snapshot.data.homeScreen.sliders[itemIndex].photo}',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                // alignment: Alignment.bottomCenter,
                                                child: Container(
                                                  height: 100,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 16.0,
                                                  ),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(8.0),
                                                      bottomRight:
                                                          Radius.circular(8.0),
                                                    ),
                                                    gradient: LinearGradient(
                                                      end: const Alignment(
                                                          0.0, -1),
                                                      begin: const Alignment(
                                                          0.0, 0.4),
                                                      colors: <Color>[
                                                        const Color(0xAB000000),
                                                        Colors.black87
                                                            .withOpacity(
                                                          0.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        snapshot
                                                            .data
                                                            .homeScreen
                                                            .sliders[itemIndex]
                                                            .titleText,
                                                        style: appTextStyle(
                                                          FontWeight.bold,
                                                          16.0,
                                                          Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        snapshot
                                                            .data
                                                            .homeScreen
                                                            .sliders[itemIndex]
                                                            .subtitleText,
                                                        style: appTextStyle(
                                                          FontWeight.w500,
                                                          12.0,
                                                          Colors.white,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 16.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    aspectRatio: 3.0,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 16.0,
                          ),

                          // ------------------------------ Shop By Category ------------------------------
                          HeaderWidget(
                            title: AppLocalizations.of(context).translate(
                              'str_shop_by_category',
                            ),
                            onClick: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Category(),
                                ),
                              );
                            }),
                          ),

                          Container(
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
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CateoryProducts(
                                          categoryId: arrCategoryId[index],
                                          subCategoryId: '',
                                          categoryName: arrCategoryTitle[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: new Card(
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
                                          future: imageURLCheck(
                                              arrCategoryIcons[index]),
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
                                                    backgroundColor:
                                                        Colors.transparent,
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
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  width: 4,
                                );
                              },
                            ),
                          ),

                          // ------------------------------ Shop By Category ------------------------------

                          // ------------------------------ Ad Space ------------------------------

                          snapshot.data.homeScreen.ads.length != 0
                              ? AdsWidget(
                                  ad1Url: snapshot.data.homeScreen.ads[0].photo,
                                  ad2Url: snapshot.data.homeScreen.ads.length >=
                                          2
                                      ? snapshot.data.homeScreen.ads[1].photo
                                      : '',
                                  onClickAd1: (() {
                                    launchURL(
                                      snapshot.data.homeScreen.ads[0].link,
                                    );
                                  }),
                                  onClickAd2: (() {
                                    if (snapshot.data.homeScreen.ads.length >=
                                        2) {
                                      launchURL(
                                        snapshot.data.homeScreen.ads[0].link,
                                      );
                                    }
                                  }),
                                )
                              : Container(),

                          // ------------------------------ Ad Space ------------------------------

                          snapshot.data.homeScreen.premiumProducts.length != 0
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    HeaderWidget(
                                      title: AppLocalizations.of(context)
                                          .translate(
                                        'str_premium_products',
                                      ),
                                      onClick: (() {}),
                                    ),
                                    Container(
                                      // child: Text("Abcd"),
                                      height: 120,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data.homeScreen
                                            .premiumProducts.length,
                                        physics: BouncingScrollPhysics(),
                                        //   //controller: _scrollController,
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        itemBuilder: (context, index) {
                                          print(
                                            '$index = $thumbnailBaseURL/${snapshot.data.homeScreen.premiumProducts[index].thumbnail}',
                                          );
                                          print(snapshot
                                              .data
                                              .homeScreen
                                              .premiumProducts[index]
                                              .isDiscount);

                                          var discount = 0;

                                          if (snapshot
                                                  .data
                                                  .homeScreen
                                                  .premiumProducts[index]
                                                  .previousPrice !=
                                              0) {
                                            var oldPrice = snapshot
                                                .data
                                                .homeScreen
                                                .premiumProducts[index]
                                                .previousPrice;

                                            var newPrice = snapshot
                                                .data
                                                .homeScreen
                                                .premiumProducts[index]
                                                .price;

                                            // discount = int.parse((oldPrice - newPrice) / oldPrice * 100).toString();

                                            var disAmt = oldPrice - newPrice;
                                            discount =
                                                ((disAmt / oldPrice) * 100)
                                                    .toInt();

                                            // print('Discont Per = $discount');
                                          }

                                          return Padding(
                                            padding: EdgeInsets.only(left: 4),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              child: GestureDetector(
                                                onTap: () {
                                                  print(snapshot
                                                      .data
                                                      .homeScreen
                                                      .premiumProducts[index]
                                                      .photo);
                                                  int productId = snapshot
                                                      .data
                                                      .homeScreen
                                                      .premiumProducts[index]
                                                      .id;

                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductDetailScreen(
                                                        productId: productId,
                                                        productTitle: snapshot
                                                            .data
                                                            .homeScreen
                                                            .premiumProducts[
                                                                index]
                                                            .name,
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
                                                        color:
                                                            Colors.transparent,
                                                        child: Container(
                                                          width: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                16,
                                                              ),
                                                            ),
                                                          ),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              vertical: 4.0,
                                                              horizontal: 4.0,
                                                            ),
                                                            child:
                                                                FutureBuilder(
                                                              future: imageURLCheck(
                                                                  "$thumbnailBaseURL/${snapshot.data.homeScreen.premiumProducts[index].thumbnail}"),
                                                              builder: (context,
                                                                  asyncSnapshot) {
                                                                if (asyncSnapshot
                                                                    .hasData) {
                                                                  if (asyncSnapshot
                                                                          .data !=
                                                                      null) {
                                                                    return Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                          Radius
                                                                              .circular(
                                                                            16,
                                                                          ),
                                                                        ),
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              NetworkImage(
                                                                            '$thumbnailBaseURL/${snapshot.data.homeScreen.premiumProducts[index].thumbnail}',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      // child: Image.network(
                                                                      //   '$thumbnailBaseURL/${snapshot.data.homeScreen.premiumProducts[index].thumbnail}',
                                                                      //   fit: BoxFit.cover,
                                                                      // ),
                                                                    );
                                                                  } else {
                                                                    return Container(
                                                                      child:
                                                                          CircleAvatar(
                                                                        radius:
                                                                            60,
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
                                                    snapshot
                                                                .data
                                                                .homeScreen
                                                                .premiumProducts[
                                                                    index]
                                                                .previousPrice !=
                                                            0
                                                        ? Positioned(
                                                            left: 0,
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                left: 4.0,
                                                                top: 4.0,
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                vertical: 4.0,
                                                                horizontal: 8.0,
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                    16,
                                                                  ),
                                                                  bottomRight:
                                                                      Radius
                                                                          .circular(
                                                                    16,
                                                                  ),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                '${discount.toInt()}% off',
                                                                style:
                                                                    appTextStyle(
                                                                  FontWeight
                                                                      .bold,
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
                                )
                              : Container(),

                          snapshot.data.homeScreen.bigsaveProducts.length != 0
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    HeaderWidget(
                                      title: AppLocalizations.of(context)
                                          .translate(
                                        'str_big_save',
                                      ),
                                      onClick: (() {}),
                                    ),
                                    Container(
                                      // child: Text("Abcd"),
                                      height: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data.homeScreen
                                            .bigsaveProducts.length,
                                        physics: BouncingScrollPhysics(),
                                        //   //controller: _scrollController,
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        itemBuilder: (context, index) {
                                          // print(snapshot
                                          //     .data
                                          //     .homeScreen
                                          //     .bigsaveProducts[index]
                                          //     .isDiscount);

                                          var discount = 0;

                                          if (snapshot
                                                  .data
                                                  .homeScreen
                                                  .bigsaveProducts[index]
                                                  .previousPrice !=
                                              0) {
                                            var oldPrice = snapshot
                                                .data
                                                .homeScreen
                                                .bigsaveProducts[index]
                                                .previousPrice;

                                            var newPrice = snapshot
                                                .data
                                                .homeScreen
                                                .bigsaveProducts[index]
                                                .price;

                                            // discount = int.parse((oldPrice - newPrice) / oldPrice * 100).toString();

                                            var disAmt = oldPrice - newPrice;
                                            discount =
                                                ((disAmt / oldPrice) * 100)
                                                    .toInt();

                                            print('Discont Per = $discount');
                                          }

                                          return GestureDetector(
                                            onTap: () {
                                              int productId = snapshot
                                                  .data
                                                  .homeScreen
                                                  .bigsaveProducts[index]
                                                  .id;

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetailScreen(
                                                    productId: productId,
                                                    productTitle: snapshot
                                                        .data
                                                        .homeScreen
                                                        .bigsaveProducts[index]
                                                        .name,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Card(
                                              elevation: 1,
                                              margin: EdgeInsets.only(
                                                right: 16.0,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  16,
                                                ),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    16,
                                                  ),
                                                  // color: kGradientPrimary,
                                                ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                height: 200,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Stack(
                                                        children: [
                                                          FutureBuilder(
                                                            future: imageURLCheck(
                                                                "$thumbnailBaseURL/${snapshot.data.homeScreen.bigsaveProducts[index].thumbnail}"),
                                                            builder: (context,
                                                                asyncSnapshot) {
                                                              if (asyncSnapshot
                                                                  .hasData) {
                                                                if (asyncSnapshot
                                                                        .data !=
                                                                    null) {
                                                                  return Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                      vertical:
                                                                          8.0,
                                                                      horizontal:
                                                                          8.0,
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                          16.0,
                                                                        ),
                                                                        topRight:
                                                                            Radius.circular(
                                                                          16.0,
                                                                        ),
                                                                      ),
                                                                      image:
                                                                          DecorationImage(
                                                                        image:
                                                                            NetworkImage(
                                                                          '$thumbnailBaseURL/${snapshot.data.homeScreen.bigsaveProducts[index].thumbnail}',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return Center(
                                                                    child:
                                                                        Container(
                                                                      // color: Colors.black,
                                                                      // width: 200,
                                                                      child:
                                                                          CircleAvatar(
                                                                        radius:
                                                                            60,
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        backgroundImage:
                                                                            AssetImage(
                                                                          "assets/images/no_image.png",
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                              } else {
                                                                return Center(
                                                                  child:
                                                                      CupertinoActivityIndicator(
                                                                    radius: 5,
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                          ),
                                                          snapshot
                                                                      .data
                                                                      .homeScreen
                                                                      .bigsaveProducts[
                                                                          index]
                                                                      .previousPrice !=
                                                                  0
                                                              ? Positioned(
                                                                  left: 0,
                                                                  child:
                                                                      Container(
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left: 0.0,
                                                                      top: 0.0,
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                      vertical:
                                                                          4.0,
                                                                      horizontal:
                                                                          8.0,
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .red,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        // topRight:
                                                                        //     Radius
                                                                        //         .circular(
                                                                        //   16,
                                                                        // ),
                                                                        bottomRight:
                                                                            Radius.circular(
                                                                          16,
                                                                        ),
                                                                        topLeft:
                                                                            Radius.circular(
                                                                          16,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      '${discount.toInt()}% off',
                                                                      style:
                                                                          appTextStyle(
                                                                        FontWeight
                                                                            .bold,
                                                                        10,
                                                                        Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : Container(),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 8.0,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                snapshot
                                                                    .data
                                                                    .homeScreen
                                                                    .bigsaveProducts[
                                                                        index]
                                                                    .name,
                                                                style:
                                                                    appTextStyle(
                                                                  FontWeight
                                                                      .w500,
                                                                  14.0,
                                                                  kTextColor,
                                                                ),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    '${AppLocalizations.of(context).translate(
                                                                      'str_rs',
                                                                    )}${snapshot.data.homeScreen.bigsaveProducts[index].price}',
                                                                    style:
                                                                        appTextStyle(
                                                                      FontWeight
                                                                          .bold,
                                                                      16.0,
                                                                      kGradientPrimary,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  snapshot.data.homeScreen.bigsaveProducts[index]
                                                                              .previousPrice !=
                                                                          0
                                                                      ? '${AppLocalizations.of(context).translate(
                                                                          'str_rs',
                                                                        )} ${snapshot.data.homeScreen.bigsaveProducts[index].previousPrice}'
                                                                      : '',
                                                                  style:
                                                                      GoogleFonts
                                                                          .mukta(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        10.0,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 4.0,
                                                            ),
                                                          ],
                                                        ),
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
                                  ],
                                )
                              : Container(),

                          snapshot.data.homeScreen.hotProducts.length != 0
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    HeaderWidget(
                                      title: AppLocalizations.of(context)
                                          .translate(
                                        'str_hot_deals',
                                      ),
                                      onClick: (() {}),
                                    ),
                                    Container(
                                      // child: Text("Abcd"),
                                      height: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot
                                            .data.homeScreen.hotProducts.length,
                                        physics: BouncingScrollPhysics(),
                                        //   //controller: _scrollController,
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        itemBuilder: (context, index) {
                                          print(snapshot.data.homeScreen
                                              .hotProducts[index].isDiscount);

                                          var discount = 0;

                                          if (snapshot
                                                  .data
                                                  .homeScreen
                                                  .hotProducts[index]
                                                  .previousPrice !=
                                              0) {
                                            var oldPrice = snapshot
                                                .data
                                                .homeScreen
                                                .hotProducts[index]
                                                .previousPrice;

                                            var newPrice = snapshot
                                                .data
                                                .homeScreen
                                                .hotProducts[index]
                                                .price;

                                            // discount = int.parse((oldPrice - newPrice) / oldPrice * 100).toString();

                                            var disAmt = oldPrice - newPrice;
                                            discount =
                                                ((disAmt / oldPrice) * 100)
                                                    .toInt();

                                            // print('Discont Per = $discount');
                                          }

                                          return Card(
                                            elevation: 1,
                                            margin: EdgeInsets.only(
                                              right: 16.0,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  16,
                                                ),
                                                // color: kGradientPrimary,
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              height: 200,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Stack(
                                                      children: [
                                                        FutureBuilder(
                                                          future: imageURLCheck(
                                                              "$thumbnailBaseURL/${snapshot.data.homeScreen.hotProducts[index].thumbnail}"),
                                                          builder: (context,
                                                              asyncSnapshot) {
                                                            if (asyncSnapshot
                                                                .hasData) {
                                                              if (asyncSnapshot
                                                                      .data !=
                                                                  null) {
                                                                return Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        8.0,
                                                                    horizontal:
                                                                        8.0,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft:
                                                                          Radius
                                                                              .circular(
                                                                        16.0,
                                                                      ),
                                                                      topRight:
                                                                          Radius
                                                                              .circular(
                                                                        16.0,
                                                                      ),
                                                                    ),
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        '$thumbnailBaseURL/${snapshot.data.homeScreen.hotProducts[index].thumbnail}',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              } else {
                                                                return Center(
                                                                  child:
                                                                      Container(
                                                                    // color: Colors.black,
                                                                    // width: 200,
                                                                    child:
                                                                        CircleAvatar(
                                                                      radius:
                                                                          60,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      backgroundImage:
                                                                          AssetImage(
                                                                        "assets/images/no_image.png",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            } else {
                                                              return Center(
                                                                child:
                                                                    CupertinoActivityIndicator(
                                                                  radius: 5,
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        snapshot
                                                                    .data
                                                                    .homeScreen
                                                                    .hotProducts[
                                                                        index]
                                                                    .previousPrice !=
                                                                0
                                                            ? Positioned(
                                                                left: 0,
                                                                child:
                                                                    Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 0.0,
                                                                    top: 0.0,
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        4.0,
                                                                    horizontal:
                                                                        8.0,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      // topRight:
                                                                      //     Radius
                                                                      //         .circular(
                                                                      //   16,
                                                                      // ),
                                                                      bottomRight:
                                                                          Radius
                                                                              .circular(
                                                                        16,
                                                                      ),
                                                                      topLeft:
                                                                          Radius
                                                                              .circular(
                                                                        16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                    '${discount.toInt()}% off',
                                                                    style:
                                                                        appTextStyle(
                                                                      FontWeight
                                                                          .bold,
                                                                      10,
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 8.0,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              snapshot
                                                                  .data
                                                                  .homeScreen
                                                                  .hotProducts[
                                                                      index]
                                                                  .name,
                                                              style:
                                                                  appTextStyle(
                                                                FontWeight.w500,
                                                                14.0,
                                                                kTextColor,
                                                              ),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  '${AppLocalizations.of(context).translate(
                                                                    'str_rs',
                                                                  )}${snapshot.data.homeScreen.hotProducts[index].price}',
                                                                  style:
                                                                      appTextStyle(
                                                                    FontWeight
                                                                        .bold,
                                                                    16.0,
                                                                    kGradientPrimary,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                snapshot
                                                                            .data
                                                                            .homeScreen
                                                                            .hotProducts[index]
                                                                            .previousPrice !=
                                                                        0
                                                                    ? '${AppLocalizations.of(context).translate(
                                                                        'str_rs',
                                                                      )} ${snapshot.data.homeScreen.hotProducts[index].previousPrice}'
                                                                    : '',
                                                                style:
                                                                    GoogleFonts
                                                                        .mukta(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize:
                                                                      10.0,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 4.0,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),

                          // snapshot.data.homeScreen.latestProducts.length != 0
                          //     ? Column(
                          //         children: [
                          //           SizedBox(
                          //             height: 8.0,
                          //           ),
                          //           HeaderWidget(
                          //             title: AppLocalizations.of(context)
                          //                 .translate(
                          //               'str_latest',
                          //             ),
                          //             onClick: (() {}),
                          //           ),
                          //           Container(
                          //             // child: Text("Abcd"),
                          //             height: 200,
                          //             child: ListView.builder(
                          //               scrollDirection: Axis.horizontal,
                          //               itemCount: snapshot.data.homeScreen
                          //                   .latestProducts.length,
                          //               physics: BouncingScrollPhysics(),
                          //               //   //controller: _scrollController,
                          //               padding: const EdgeInsets.only(
                          //                   left: 8, right: 8),
                          //               itemBuilder: (context, index) {
                          //                 print(snapshot
                          //                     .data
                          //                     .homeScreen
                          //                     .latestProducts[index]
                          //                     .isDiscount);

                          //                 var discount = 0;

                          //                 if (snapshot
                          //                         .data
                          //                         .homeScreen
                          //                         .latestProducts[index]
                          //                         .previousPrice !=
                          //                     0) {
                          //                   var oldPrice = snapshot
                          //                       .data
                          //                       .homeScreen
                          //                       .latestProducts[index]
                          //                       .previousPrice;

                          //                   var newPrice = snapshot
                          //                       .data
                          //                       .homeScreen
                          //                       .latestProducts[index]
                          //                       .price;

                          //                   // discount = int.parse((oldPrice - newPrice) / oldPrice * 100).toString();

                          //                   var disAmt = oldPrice - newPrice;
                          //                   discount =
                          //                       ((disAmt / oldPrice) * 100)
                          //                           .toInt();

                          //                   print('Discont Per = $discount');
                          //                 }

                          //                 return Card(
                          //                   elevation: 1,
                          //                   margin: EdgeInsets.only(
                          //                     right: 16.0,
                          //                   ),
                          //                   shape: RoundedRectangleBorder(
                          //                     borderRadius:
                          //                         BorderRadius.circular(
                          //                       16,
                          //                     ),
                          //                   ),
                          //                   child: Container(
                          //                     decoration: BoxDecoration(
                          //                       borderRadius:
                          //                           BorderRadius.circular(
                          //                         16,
                          //                       ),
                          //                       // color: kGradientPrimary,
                          //                     ),
                          //                     width: MediaQuery.of(context)
                          //                             .size
                          //                             .width *
                          //                         0.4,
                          //                     height: 200,
                          //                     child: Column(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment.center,
                          //                       crossAxisAlignment:
                          //                           CrossAxisAlignment.start,
                          //                       children: [
                          //                         Expanded(
                          //                           flex: 3,
                          //                           child: Stack(
                          //                             children: [
                          //                               FutureBuilder(
                          //                                 future: imageURLCheck(
                          //                                     "$thumbnailBaseURL/${snapshot.data.homeScreen.latestProducts[index].photo}"),
                          //                                 builder: (context,
                          //                                     asyncSnapshot) {
                          //                                   if (asyncSnapshot
                          //                                       .hasData) {
                          //                                     if (asyncSnapshot
                          //                                             .data !=
                          //                                         null) {
                          //                                       return Container(
                          //                                         padding:
                          //                                             EdgeInsets
                          //                                                 .symmetric(
                          //                                           vertical:
                          //                                               8.0,
                          //                                           horizontal:
                          //                                               8.0,
                          //                                         ),
                          //                                         decoration:
                          //                                             BoxDecoration(
                          //                                           color: Colors
                          //                                               .white,
                          //                                           borderRadius:
                          //                                               BorderRadius
                          //                                                   .only(
                          //                                             topLeft:
                          //                                                 Radius
                          //                                                     .circular(
                          //                                               16.0,
                          //                                             ),
                          //                                             topRight:
                          //                                                 Radius
                          //                                                     .circular(
                          //                                               16.0,
                          //                                             ),
                          //                                           ),
                          //                                           image:
                          //                                               DecorationImage(
                          //                                             image:
                          //                                                 NetworkImage(
                          //                                               '$thumbnailBaseURL/${snapshot.data.homeScreen.latestProducts[index].photo}',
                          //                                             ),
                          //                                           ),
                          //                                         ),
                          //                                       );
                          //                                     } else {
                          //                                       return Center(
                          //                                         child:
                          //                                             Container(
                          //                                           // color: Colors.black,
                          //                                           // width: 200,
                          //                                           child:
                          //                                               CircleAvatar(
                          //                                             radius:
                          //                                                 60,
                          //                                             backgroundColor:
                          //                                                 Colors
                          //                                                     .transparent,
                          //                                             backgroundImage:
                          //                                                 AssetImage(
                          //                                               "assets/images/no_image.png",
                          //                                             ),
                          //                                           ),
                          //                                         ),
                          //                                       );
                          //                                     }
                          //                                   } else {
                          //                                     return Center(
                          //                                       child:
                          //                                           CupertinoActivityIndicator(
                          //                                         radius: 5,
                          //                                       ),
                          //                                     );
                          //                                   }
                          //                                 },
                          //                               ),
                          //                               snapshot
                          //                                           .data
                          //                                           .homeScreen
                          //                                           .latestProducts[
                          //                                               index]
                          //                                           .previousPrice !=
                          //                                       0
                          //                                   ? Positioned(
                          //                                       left: 0,
                          //                                       child:
                          //                                           Container(
                          //                                         margin:
                          //                                             EdgeInsets
                          //                                                 .only(
                          //                                           left: 0.0,
                          //                                           top: 0.0,
                          //                                         ),
                          //                                         padding:
                          //                                             const EdgeInsets
                          //                                                 .symmetric(
                          //                                           vertical:
                          //                                               4.0,
                          //                                           horizontal:
                          //                                               8.0,
                          //                                         ),
                          //                                         decoration:
                          //                                             BoxDecoration(
                          //                                           color: Colors
                          //                                               .red,
                          //                                           borderRadius:
                          //                                               BorderRadius
                          //                                                   .only(
                          //                                             // topRight:
                          //                                             //     Radius
                          //                                             //         .circular(
                          //                                             //   16,
                          //                                             // ),
                          //                                             bottomRight:
                          //                                                 Radius
                          //                                                     .circular(
                          //                                               16,
                          //                                             ),
                          //                                             topLeft:
                          //                                                 Radius
                          //                                                     .circular(
                          //                                               16,
                          //                                             ),
                          //                                           ),
                          //                                         ),
                          //                                         child: Text(
                          //                                           '${discount.toInt()}% off',
                          //                                           style:
                          //                                               appTextStyle(
                          //                                             FontWeight
                          //                                                 .bold,
                          //                                             10,
                          //                                             Colors
                          //                                                 .white,
                          //                                           ),
                          //                                         ),
                          //                                       ),
                          //                                     )
                          //                                   : Container(),
                          //                             ],
                          //                           ),
                          //                         ),
                          //                         Expanded(
                          //                           flex: 2,
                          //                           child: Padding(
                          //                             padding: const EdgeInsets
                          //                                 .symmetric(
                          //                               horizontal: 8.0,
                          //                             ),
                          //                             child: Column(
                          //                               crossAxisAlignment:
                          //                                   CrossAxisAlignment
                          //                                       .start,
                          //                               children: [
                          //                                 Expanded(
                          //                                   child: Text(
                          //                                     snapshot
                          //                                         .data
                          //                                         .homeScreen
                          //                                         .latestProducts[
                          //                                             index]
                          //                                         .name,
                          //                                     style:
                          //                                         appTextStyle(
                          //                                       FontWeight.w500,
                          //                                       14.0,
                          //                                       kTextColor,
                          //                                     ),
                          //                                     maxLines: 2,
                          //                                     overflow:
                          //                                         TextOverflow
                          //                                             .ellipsis,
                          //                                   ),
                          //                                 ),
                          //                                 Row(
                          //                                   children: [
                          //                                     Expanded(
                          //                                       child: Text(
                          //                                         '${AppLocalizations.of(context).translate(
                          //                                           'str_rs',
                          //                                         )}${snapshot.data.homeScreen.latestProducts[index].price}',
                          //                                         style:
                          //                                             appTextStyle(
                          //                                           FontWeight
                          //                                               .bold,
                          //                                           16.0,
                          //                                           kGradientPrimary,
                          //                                         ),
                          //                                       ),
                          //                                     ),
                          //                                     Text(
                          //                                       snapshot
                          //                                                   .data
                          //                                                   .homeScreen
                          //                                                   .latestProducts[index]
                          //                                                   .previousPrice !=
                          //                                               0
                          //                                           ? '${AppLocalizations.of(context).translate(
                          //                                               'str_rs',
                          //                                             )} ${snapshot.data.homeScreen.latestProducts[index].previousPrice}'
                          //                                           : '',
                          //                                       style:
                          //                                           GoogleFonts
                          //                                               .mukta(
                          //                                         color: Colors
                          //                                             .red,
                          //                                         fontSize:
                          //                                             10.0,
                          //                                         decoration:
                          //                                             TextDecoration
                          //                                                 .lineThrough,
                          //                                       ),
                          //                                     ),
                          //                                   ],
                          //                                 ),
                          //                                 SizedBox(
                          //                                   height: 4.0,
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                           ),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 );
                          //               },
                          //             ),
                          //           ),
                          //         ],
                          //       )
                          //     : Container(),

                          snapshot.data.homeScreen.trendingProducts.length != 0
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    HeaderWidget(
                                      title: AppLocalizations.of(context)
                                          .translate(
                                        'str_trending',
                                      ),
                                      onClick: (() {}),
                                    ),
                                    Container(
                                      // child: Text("Abcd"),
                                      height: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data.homeScreen
                                            .trendingProducts.length,
                                        physics: BouncingScrollPhysics(),
                                        //   //controller: _scrollController,
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        itemBuilder: (context, index) {
                                          // print(snapshot
                                          //     .data
                                          //     .homeScreen
                                          //     .trendingProducts[index]
                                          //     .isDiscount);

                                          var discount = 0;

                                          if (snapshot
                                                  .data
                                                  .homeScreen
                                                  .trendingProducts[index]
                                                  .previousPrice !=
                                              0) {
                                            var oldPrice = snapshot
                                                .data
                                                .homeScreen
                                                .trendingProducts[index]
                                                .previousPrice;

                                            var newPrice = snapshot
                                                .data
                                                .homeScreen
                                                .trendingProducts[index]
                                                .price;

                                            // discount = int.parse((oldPrice - newPrice) / oldPrice * 100).toString();

                                            var disAmt = oldPrice - newPrice;
                                            discount =
                                                ((disAmt / oldPrice) * 100)
                                                    .toInt();

                                            print('Discont Per = $discount');
                                          }

                                          return Card(
                                            elevation: 1,
                                            margin: EdgeInsets.only(
                                              right: 16.0,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  16,
                                                ),
                                                // color: kGradientPrimary,
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              height: 200,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Stack(
                                                      children: [
                                                        FutureBuilder(
                                                          future: imageURLCheck(
                                                              "$thumbnailBaseURL/${snapshot.data.homeScreen.trendingProducts[index].thumbnail}"),
                                                          builder: (context,
                                                              asyncSnapshot) {
                                                            if (asyncSnapshot
                                                                .hasData) {
                                                              if (asyncSnapshot
                                                                      .data !=
                                                                  null) {
                                                                return Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        8.0,
                                                                    horizontal:
                                                                        8.0,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft:
                                                                          Radius
                                                                              .circular(
                                                                        16.0,
                                                                      ),
                                                                      topRight:
                                                                          Radius
                                                                              .circular(
                                                                        16.0,
                                                                      ),
                                                                    ),
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        '$thumbnailBaseURL/${snapshot.data.homeScreen.trendingProducts[index].thumbnail}',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              } else {
                                                                return Center(
                                                                  child:
                                                                      Container(
                                                                    // color: Colors.black,
                                                                    // width: 200,
                                                                    child:
                                                                        CircleAvatar(
                                                                      radius:
                                                                          60,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      backgroundImage:
                                                                          AssetImage(
                                                                        "assets/images/no_image.png",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            } else {
                                                              return Center(
                                                                child:
                                                                    CupertinoActivityIndicator(
                                                                  radius: 5,
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        snapshot
                                                                    .data
                                                                    .homeScreen
                                                                    .trendingProducts[
                                                                        index]
                                                                    .previousPrice !=
                                                                0
                                                            ? Positioned(
                                                                left: 0,
                                                                child:
                                                                    Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 0.0,
                                                                    top: 0.0,
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        4.0,
                                                                    horizontal:
                                                                        8.0,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      // topRight:
                                                                      //     Radius
                                                                      //         .circular(
                                                                      //   16,
                                                                      // ),
                                                                      bottomRight:
                                                                          Radius
                                                                              .circular(
                                                                        16,
                                                                      ),
                                                                      topLeft:
                                                                          Radius
                                                                              .circular(
                                                                        16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                    '${discount.toInt()}% off',
                                                                    style:
                                                                        appTextStyle(
                                                                      FontWeight
                                                                          .bold,
                                                                      10,
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 8.0,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              snapshot
                                                                  .data
                                                                  .homeScreen
                                                                  .trendingProducts[
                                                                      index]
                                                                  .name,
                                                              style:
                                                                  appTextStyle(
                                                                FontWeight.w500,
                                                                14.0,
                                                                kTextColor,
                                                              ),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  '${AppLocalizations.of(context).translate(
                                                                    'str_rs',
                                                                  )}${snapshot.data.homeScreen.trendingProducts[index].price}',
                                                                  style:
                                                                      appTextStyle(
                                                                    FontWeight
                                                                        .bold,
                                                                    16.0,
                                                                    kGradientPrimary,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                snapshot
                                                                            .data
                                                                            .homeScreen
                                                                            .trendingProducts[index]
                                                                            .previousPrice !=
                                                                        0
                                                                    ? '${AppLocalizations.of(context).translate(
                                                                        'str_rs',
                                                                      )} ${snapshot.data.homeScreen.trendingProducts[index].previousPrice}'
                                                                    : '',
                                                                style:
                                                                    GoogleFonts
                                                                        .mukta(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize:
                                                                      10.0,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 4.0,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),

                          snapshot.data.homeScreen.saleProducts.length != 0
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    HeaderWidget(
                                      title: AppLocalizations.of(context)
                                          .translate(
                                        'str_sales',
                                      ),
                                      onClick: (() {}),
                                    ),
                                    Container(
                                      // child: Text("Abcd"),
                                      height: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data.homeScreen
                                            .saleProducts.length,
                                        physics: BouncingScrollPhysics(),
                                        //   //controller: _scrollController,
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        itemBuilder: (context, index) {
                                          print(snapshot.data.homeScreen
                                              .saleProducts[index].isDiscount);

                                          var discount = 0;

                                          if (snapshot
                                                  .data
                                                  .homeScreen
                                                  .saleProducts[index]
                                                  .previousPrice !=
                                              0) {
                                            var oldPrice = snapshot
                                                .data
                                                .homeScreen
                                                .saleProducts[index]
                                                .previousPrice;

                                            var newPrice = snapshot
                                                .data
                                                .homeScreen
                                                .saleProducts[index]
                                                .price;

                                            // discount = int.parse((oldPrice - newPrice) / oldPrice * 100).toString();

                                            var disAmt = oldPrice - newPrice;
                                            discount =
                                                ((disAmt / oldPrice) * 100)
                                                    .toInt();

                                            // print('Discont Per = $discount');
                                          }

                                          return Card(
                                            elevation: 1,
                                            margin: EdgeInsets.only(
                                              right: 16.0,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  16,
                                                ),
                                                // color: kGradientPrimary,
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              height: 200,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Stack(
                                                      children: [
                                                        FutureBuilder(
                                                          future: imageURLCheck(
                                                              "$thumbnailBaseURL/${snapshot.data.homeScreen.saleProducts[index].thumbnail}"),
                                                          builder: (context,
                                                              asyncSnapshot) {
                                                            if (asyncSnapshot
                                                                .hasData) {
                                                              if (asyncSnapshot
                                                                      .data !=
                                                                  null) {
                                                                return Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        8.0,
                                                                    horizontal:
                                                                        8.0,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft:
                                                                          Radius
                                                                              .circular(
                                                                        16.0,
                                                                      ),
                                                                      topRight:
                                                                          Radius
                                                                              .circular(
                                                                        16.0,
                                                                      ),
                                                                    ),
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        '$thumbnailBaseURL/${snapshot.data.homeScreen.saleProducts[index].thumbnail}',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              } else {
                                                                return Center(
                                                                  child:
                                                                      Container(
                                                                    // color: Colors.black,
                                                                    // width: 200,
                                                                    child:
                                                                        CircleAvatar(
                                                                      radius:
                                                                          60,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      backgroundImage:
                                                                          AssetImage(
                                                                        "assets/images/no_image.png",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            } else {
                                                              return Center(
                                                                child:
                                                                    CupertinoActivityIndicator(
                                                                  radius: 5,
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        snapshot
                                                                    .data
                                                                    .homeScreen
                                                                    .saleProducts[
                                                                        index]
                                                                    .previousPrice !=
                                                                0
                                                            ? Positioned(
                                                                left: 0,
                                                                child:
                                                                    Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 0.0,
                                                                    top: 0.0,
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        4.0,
                                                                    horizontal:
                                                                        8.0,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      // topRight:
                                                                      //     Radius
                                                                      //         .circular(
                                                                      //   16,
                                                                      // ),
                                                                      bottomRight:
                                                                          Radius
                                                                              .circular(
                                                                        16,
                                                                      ),
                                                                      topLeft:
                                                                          Radius
                                                                              .circular(
                                                                        16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                    '${discount.toInt()}% off',
                                                                    style:
                                                                        appTextStyle(
                                                                      FontWeight
                                                                          .bold,
                                                                      10,
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 8.0,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              snapshot
                                                                  .data
                                                                  .homeScreen
                                                                  .saleProducts[
                                                                      index]
                                                                  .name,
                                                              style:
                                                                  appTextStyle(
                                                                FontWeight.w500,
                                                                14.0,
                                                                kTextColor,
                                                              ),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  '${AppLocalizations.of(context).translate(
                                                                    'str_rs',
                                                                  )}${snapshot.data.homeScreen.saleProducts[index].price}',
                                                                  style:
                                                                      appTextStyle(
                                                                    FontWeight
                                                                        .bold,
                                                                    16.0,
                                                                    kGradientPrimary,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                snapshot
                                                                            .data
                                                                            .homeScreen
                                                                            .saleProducts[index]
                                                                            .previousPrice !=
                                                                        0
                                                                    ? '${AppLocalizations.of(context).translate(
                                                                        'str_rs',
                                                                      )} ${snapshot.data.homeScreen.saleProducts[index].previousPrice}'
                                                                    : '',
                                                                style:
                                                                    GoogleFonts
                                                                        .mukta(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize:
                                                                      10.0,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 4.0,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),

                          snapshot.data.homeScreen.bestsaleProducts.length != 0
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    HeaderWidget(
                                      title: AppLocalizations.of(context)
                                          .translate(
                                        'str_best_sale',
                                      ),
                                      onClick: (() {}),
                                    ),
                                    Container(
                                      // child: Text("Abcd"),
                                      height: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data.homeScreen
                                            .bestsaleProducts.length,
                                        physics: BouncingScrollPhysics(),
                                        //   //controller: _scrollController,
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        itemBuilder: (context, index) {
                                          print(snapshot
                                              .data
                                              .homeScreen
                                              .bestsaleProducts[index]
                                              .isDiscount);

                                          var discount = 0;

                                          if (snapshot
                                                  .data
                                                  .homeScreen
                                                  .bestsaleProducts[index]
                                                  .previousPrice !=
                                              0) {
                                            var oldPrice = snapshot
                                                .data
                                                .homeScreen
                                                .bestsaleProducts[index]
                                                .previousPrice;

                                            var newPrice = snapshot
                                                .data
                                                .homeScreen
                                                .bestsaleProducts[index]
                                                .price;

                                            // discount = int.parse((oldPrice - newPrice) / oldPrice * 100).toString();

                                            var disAmt = oldPrice - newPrice;
                                            discount =
                                                ((disAmt / oldPrice) * 100)
                                                    .toInt();

                                            print('Discont Per = $discount');
                                          }

                                          return Card(
                                            elevation: 1,
                                            margin: EdgeInsets.only(
                                              right: 16.0,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  16,
                                                ),
                                                // color: kGradientPrimary,
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              height: 200,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Stack(
                                                      children: [
                                                        FutureBuilder(
                                                          future: imageURLCheck(
                                                              "$thumbnailBaseURL/${snapshot.data.homeScreen.bestsaleProducts[index].thumbnail}"),
                                                          builder: (context,
                                                              asyncSnapshot) {
                                                            if (asyncSnapshot
                                                                .hasData) {
                                                              if (asyncSnapshot
                                                                      .data !=
                                                                  null) {
                                                                return Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        8.0,
                                                                    horizontal:
                                                                        8.0,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft:
                                                                          Radius
                                                                              .circular(
                                                                        16.0,
                                                                      ),
                                                                      topRight:
                                                                          Radius
                                                                              .circular(
                                                                        16.0,
                                                                      ),
                                                                    ),
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        '$thumbnailBaseURL/${snapshot.data.homeScreen.bestsaleProducts[index].thumbnail}',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              } else {
                                                                return Center(
                                                                  child:
                                                                      Container(
                                                                    // color: Colors.black,
                                                                    // width: 200,
                                                                    child:
                                                                        CircleAvatar(
                                                                      radius:
                                                                          60,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      backgroundImage:
                                                                          AssetImage(
                                                                        "assets/images/no_image.png",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            } else {
                                                              return Center(
                                                                child:
                                                                    CupertinoActivityIndicator(
                                                                  radius: 5,
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        snapshot
                                                                    .data
                                                                    .homeScreen
                                                                    .bestsaleProducts[
                                                                        index]
                                                                    .previousPrice !=
                                                                0
                                                            ? Positioned(
                                                                left: 0,
                                                                child:
                                                                    Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 0.0,
                                                                    top: 0.0,
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        4.0,
                                                                    horizontal:
                                                                        8.0,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      // topRight:
                                                                      //     Radius
                                                                      //         .circular(
                                                                      //   16,
                                                                      // ),
                                                                      bottomRight:
                                                                          Radius
                                                                              .circular(
                                                                        16,
                                                                      ),
                                                                      topLeft:
                                                                          Radius
                                                                              .circular(
                                                                        16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                    '${discount.toInt()}% off',
                                                                    style:
                                                                        appTextStyle(
                                                                      FontWeight
                                                                          .bold,
                                                                      10,
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 8.0,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              snapshot
                                                                  .data
                                                                  .homeScreen
                                                                  .bestsaleProducts[
                                                                      index]
                                                                  .name,
                                                              style:
                                                                  appTextStyle(
                                                                FontWeight.w500,
                                                                14.0,
                                                                kTextColor,
                                                              ),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  '${AppLocalizations.of(context).translate(
                                                                    'str_rs',
                                                                  )}${snapshot.data.homeScreen.bestsaleProducts[index].price}',
                                                                  style:
                                                                      appTextStyle(
                                                                    FontWeight
                                                                        .bold,
                                                                    16.0,
                                                                    kGradientPrimary,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                snapshot
                                                                            .data
                                                                            .homeScreen
                                                                            .bestsaleProducts[index]
                                                                            .previousPrice !=
                                                                        0
                                                                    ? '${AppLocalizations.of(context).translate(
                                                                        'str_rs',
                                                                      )} ${snapshot.data.homeScreen.bestsaleProducts[index].previousPrice}'
                                                                    : '',
                                                                style:
                                                                    GoogleFonts
                                                                        .mukta(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize:
                                                                      10.0,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 4.0,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),

                          snapshot.data.homeScreen.flashdealProducts.length != 0
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    HeaderWidget(
                                      title: AppLocalizations.of(context)
                                          .translate(
                                        'str_flash_deal',
                                      ),
                                      onClick: (() {}),
                                    ),
                                    Container(
                                      // child: Text("Abcd"),
                                      height: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data.homeScreen
                                            .flashdealProducts.length,
                                        physics: BouncingScrollPhysics(),
                                        //   //controller: _scrollController,
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        itemBuilder: (context, index) {
                                          print(snapshot
                                              .data
                                              .homeScreen
                                              .flashdealProducts[index]
                                              .isDiscount);

                                          var discount = 0;

                                          if (snapshot
                                                  .data
                                                  .homeScreen
                                                  .flashdealProducts[index]
                                                  .previousPrice !=
                                              0) {
                                            var oldPrice = snapshot
                                                .data
                                                .homeScreen
                                                .flashdealProducts[index]
                                                .previousPrice;

                                            var newPrice = snapshot
                                                .data
                                                .homeScreen
                                                .flashdealProducts[index]
                                                .price;

                                            // discount = int.parse((oldPrice - newPrice) / oldPrice * 100).toString();

                                            var disAmt = oldPrice - newPrice;
                                            discount =
                                                ((disAmt / oldPrice) * 100)
                                                    .toInt();

                                            print('Discont Per = $discount');
                                          }

                                          return Card(
                                            elevation: 1,
                                            margin: EdgeInsets.only(
                                              right: 16.0,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  16,
                                                ),
                                                // color: kGradientPrimary,
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              height: 200,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Stack(
                                                      children: [
                                                        FutureBuilder(
                                                          future: imageURLCheck(
                                                              "$thumbnailBaseURL/${snapshot.data.homeScreen.flashdealProducts[index].thumbnail}"),
                                                          builder: (context,
                                                              asyncSnapshot) {
                                                            if (asyncSnapshot
                                                                .hasData) {
                                                              if (asyncSnapshot
                                                                      .data !=
                                                                  null) {
                                                                return Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        8.0,
                                                                    horizontal:
                                                                        8.0,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft:
                                                                          Radius
                                                                              .circular(
                                                                        16.0,
                                                                      ),
                                                                      topRight:
                                                                          Radius
                                                                              .circular(
                                                                        16.0,
                                                                      ),
                                                                    ),
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        '$thumbnailBaseURL/${snapshot.data.homeScreen.flashdealProducts[index].thumbnail}',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              } else {
                                                                return Center(
                                                                  child:
                                                                      Container(
                                                                    // color: Colors.black,
                                                                    // width: 200,
                                                                    child:
                                                                        CircleAvatar(
                                                                      radius:
                                                                          60,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      backgroundImage:
                                                                          AssetImage(
                                                                        "assets/images/no_image.png",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            } else {
                                                              return Center(
                                                                child:
                                                                    CupertinoActivityIndicator(
                                                                  radius: 5,
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        snapshot
                                                                    .data
                                                                    .homeScreen
                                                                    .flashdealProducts[
                                                                        index]
                                                                    .previousPrice !=
                                                                0
                                                            ? Positioned(
                                                                left: 0,
                                                                child:
                                                                    Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 0.0,
                                                                    top: 0.0,
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        4.0,
                                                                    horizontal:
                                                                        8.0,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      // topRight:
                                                                      //     Radius
                                                                      //         .circular(
                                                                      //   16,
                                                                      // ),
                                                                      bottomRight:
                                                                          Radius
                                                                              .circular(
                                                                        16,
                                                                      ),
                                                                      topLeft:
                                                                          Radius
                                                                              .circular(
                                                                        16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                    '${discount.toInt()}% off',
                                                                    style:
                                                                        appTextStyle(
                                                                      FontWeight
                                                                          .bold,
                                                                      10,
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 8.0,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              snapshot
                                                                  .data
                                                                  .homeScreen
                                                                  .flashdealProducts[
                                                                      index]
                                                                  .name,
                                                              style:
                                                                  appTextStyle(
                                                                FontWeight.w500,
                                                                14.0,
                                                                kTextColor,
                                                              ),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  '${AppLocalizations.of(context).translate(
                                                                    'str_rs',
                                                                  )}${snapshot.data.homeScreen.flashdealProducts[index].price}',
                                                                  style:
                                                                      appTextStyle(
                                                                    FontWeight
                                                                        .bold,
                                                                    16.0,
                                                                    kGradientPrimary,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                snapshot
                                                                            .data
                                                                            .homeScreen
                                                                            .flashdealProducts[index]
                                                                            .previousPrice !=
                                                                        0
                                                                    ? '${AppLocalizations.of(context).translate(
                                                                        'str_rs',
                                                                      )} ${snapshot.data.homeScreen.flashdealProducts[index].previousPrice}'
                                                                    : '',
                                                                style:
                                                                    GoogleFonts
                                                                        .mukta(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize:
                                                                      10.0,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 4.0,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
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
