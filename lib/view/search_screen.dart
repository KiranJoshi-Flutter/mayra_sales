import 'dart:convert';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';
import 'package:mayrasales/model/cartlist_model.dart';
import 'package:mayrasales/model/userpreferences.dart';
import 'package:mayrasales/view/home_screen.dart';
import 'package:mayrasales/view/productdetails2.dart';
import 'package:mayrasales/view/search_result_screen.dart';
import 'package:mayrasales/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class NewSearchScreen extends StatefulWidget {
  final List<Product> productList;
  const NewSearchScreen({
    Key key,
    this.productList,
  }) : super(key: key);
  @override
  _NewSearchScreenState createState() => _NewSearchScreenState();
}

class _NewSearchScreenState extends State<NewSearchScreen> {
  _NewSearchScreenState();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var formatter = NumberFormat('##,##,##,###');

  TextEditingController searchController = TextEditingController();

  List<Product> searchedList = [];
  List<String> productListName = [];

  void initState() {
    super.initState();

    init();
  }

  init() {
    print(widget.productList[0].title);

    for (int a = 0; a < widget.productList.length; a++) {
      productListName.add(widget.productList[a].title);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        title: TextField(
          controller: searchController,
          cursorColor: kLightColor,
          style: appTextStyle(
            FontWeight.w500,
            16.0,
            Colors.white,
          ),
          // autofillHints: productListName,
          onChanged: (value) {
            print('$value = ${value.length}');

            List<Product> tmpList = [];

            if (value.length >= 2) {
              for (int a = 0; a < productList.length; a++) {
                if (productList[a]
                    .title
                    .toLowerCase()
                    .contains(value.toLowerCase())) {
                  print(productList[a].title);
                  tmpList.add(productList[a]);
                }
              }
              setState(() {
                searchedList = tmpList;
              });
              print(searchedList);
            } else {
              setState(() {
                searchedList = [];
              });
            }
          },
          decoration: new InputDecoration(
            hintText: 'Search...',
            labelStyle: appTextStyle(
              FontWeight.w500,
              16.0,
              Colors.white,
            ),
            hintStyle: appTextStyle(
              FontWeight.w500,
              16.0,
              Colors.white,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: kGradientPrimary,
                width: 0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: kGradientPrimary,
                width: 0.0,
              ),
            ),
          ),
        ),

        actions: [
          IconButton(
            icon: Icon(
              AntDesign.search1,
            ),
            onPressed: () {
              // SearchResultScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchResultScreen(
                    productList: searchedList,
                    query: searchController.text.trim(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: searchedList.length != 0
          ? Container(
              // color: kGradientPrimary,
              child: ListView.builder(
                // shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: searchedList.length,

                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  // vertical: 16.0,
                ),
                // itemExtent: 80,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            productId: searchedList[index].id,
                            productTitle: searchedList[index].title,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  searchedList[index].title,
                                  style: appTextStyle(
                                    FontWeight.w500,
                                    16.0,
                                    kTextColor,
                                  ),
                                ),
                                Text(
                                  'Rs.${searchedList[index].price} /-',
                                  style: appTextStyle(
                                    FontWeight.w500,
                                    14.0,
                                    Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FutureBuilder(
                            future: imageURLCheck(
                                "$thumbnailBaseURL/${searchedList[index].img}"),
                            builder: (context, asyncSnapshot) {
                              if (asyncSnapshot.hasData) {
                                if (asyncSnapshot.data != null) {
                                  return Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          16,
                                        ),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          '$thumbnailBaseURL/${searchedList[index].img}',
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    child: Container(
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: AssetImage(
                                          "assets/images/no_image.png",
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                return Container(
                                  height: 60,
                                  width: 60,
                                  child: Center(
                                    child: CupertinoActivityIndicator(
                                      radius: 5,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : Center(
              child: Text(
                'Search Product',
              ),
            ),
    );
  }
}
