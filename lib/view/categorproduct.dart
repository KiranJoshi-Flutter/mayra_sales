import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';
import 'package:mayrasales/model/categoryproduct_model.dart';
import 'package:mayrasales/view/productdetails2.dart';
import 'package:mayrasales/widgets/widgets.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CateoryProducts extends StatefulWidget {
  final String categoryName;
  final int categoryId;
  final dynamic subCategoryId;
  const CateoryProducts({
    Key key1,
    this.categoryId,
    Key key,
    this.subCategoryId,
    Key key2,
    this.categoryName,
  }) : super(key: key);
  @override
  _CateoryProductsState createState() => _CateoryProductsState();
}

final productImages = [
  'assets/images/poco_f2_pro.webp',
  'assets/images/realmi5i.webp',
  'assets/images/tv.webp',
  'assets/images/samsung.webp',
];

class _CateoryProductsState extends State<CateoryProducts> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<CategoryProductModel> fCateoryProducts;
  ScrollController _scrollController = ScrollController();

  List<dynamic> productList = [];

  var formatter = NumberFormat('##,##,##,###');

  var lastPage = 0;
  var currentPage = 1;
  var isLastPage = false;

  var totalResults = 0;

  void initState() {
    super.initState();
    //_fetchProductDetails();

    fCateoryProducts = _getProductList();

    //  productList = [];

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  Future<CategoryProductModel> _getProductList() async {
    //String apiToken = await UserPreferences.getApiToken();
    String getURL;
    if (widget.subCategoryId.toString() == "") {
      getURL =
          "https://mayrasales.com/api/category/${widget.categoryId.toString()}";
    } else {
      getURL =
          "https://mayrasales.com/api/product_cat_sub?id=${widget.categoryId.toString()}&sub_id=${widget.subCategoryId.toString()}";
    }

    var request = await http.get(getURL);

    var jsonResponse = json.decode(request.body);

    if (jsonResponse["status"] == "success") {
      CategoryProductModel products =
          categoryProductModelFromJson(request.body);

      setState(() {
        productList = products.details.data;
        currentPage = products.details.currentPage;
        lastPage = products.details.lastPage;
        totalResults = products.details.total;
      });

      print(products);

      return products;
    } else {
      return null;
    }
  }

  _getMoreData() async {
    String getURL;
    if (widget.subCategoryId.toString() == "") {
      getURL =
          "https://mayrasales.com/api/category/${widget.categoryId.toString()}?page=$currentPage";
    } else {
      getURL =
          "https://mayrasales.com/api/product_cat_sub?id=${widget.categoryId.toString()}&sub_id=${widget.subCategoryId.toString()}?page=$currentPage";
    }

    final request = await http.get(
      Uri.parse(
        getURL,
      ),
    );

    var res = json.decode(request.body);

    if (res["status"] == "success") {
      CategoryProductModel products =
          categoryProductModelFromJson(request.body);

      setState(
        () {
          if (currentPage > lastPage) {
            isLastPage = true;
          } else {
            if (res.length != 0) {
              productList.addAll(products.details.data);
              currentPage = currentPage + 1;
            }
          }
          // print(isLastPage);
        },
      );

      print(products);

      return products;
    } else {
      return null;
    }

    // print(
    //     "More Data request.headers['x-wp-totalpages'] ${request.headers['x-wp-totalpages']}");
    // print("Page Numbers = $lastPage");

    // print("newsList.length = ${productList.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      key: _scaffoldKey,
      appBar: buildAppBar(context, widget.categoryName),
      body: FutureBuilder(
        future: fCateoryProducts,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
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
          } else {
            return Container(
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  // vertical: 16.0,
                ),
                // itemExtent: 80,
                itemBuilder: (context, index) {
                  var discount = 0;

                  if (index == productList.length) {
                    if (isLastPage) {
                      return Text(
                        '...',
                        style: appTextStyle(
                          FontWeight.normal,
                          16.0,
                          Colors.black45,
                        ),
                        textAlign: TextAlign.center,
                      );
                    } else {
                      if (productList.length > 10) {
                        var discount = 0;

                        // if (productList[index].previousPrice != 0) {
                        //   var oldPrice = productList[index].previousPrice;

                        //   var newPrice = productList[index].price;

                        //   // discount = int.parse((oldPrice - newPrice) / oldPrice * 100).toString();

                        //   var disAmt = oldPrice - newPrice;
                        //   discount = ((disAmt / oldPrice) * 100).toInt();

                        //   print('Discont Per = $discount');
                        // }
                        return Container(
                          // color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 8.0,
                              ),
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
                              SizedBox(
                                height: 8.0,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }
                  }

                  return GestureDetector(
                    onTap: (() {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => PropertyDetailScreen(
                      //       snapshot.data[index]['id'].toString(),
                      //       snapshot.data[index]['_embedded']['wp:term'][1]
                      //           .last['name'],
                      //     ),
                      //   ),
                      // );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            productId: productList[index].id,
                            productTitle: productList[index].name,
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
                                        '$thumbnailBaseURL/${productList[index].thumbnail}'),
                                    builder: (context, asyncSnapshot) {
                                      if (asyncSnapshot.hasData) {
                                        if (asyncSnapshot.data != null) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 4.0,
                                              vertical: 4.0,
                                            ),
                                            child: Image.network(
                                              '$thumbnailBaseURL/${productList[index].thumbnail}',
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
                                        return Center(
                                          child: CupertinoActivityIndicator(
                                            radius: 8,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  // productList[index].previousPrice != 0
                                  //     ? Positioned(
                                  //         left: 0,
                                  //         child: Container(
                                  //           // margin: EdgeInsets.only(
                                  //           //   left: 4.0,
                                  //           //   top: 4.0,
                                  //           // ),
                                  //           padding: const EdgeInsets.symmetric(
                                  //             vertical: 4.0,
                                  //             horizontal: 8.0,
                                  //           ),
                                  //           decoration: BoxDecoration(
                                  //             color: Colors.red,
                                  //             borderRadius: BorderRadius.only(
                                  //               topRight: Radius.circular(
                                  //                 16,
                                  //               ),
                                  //               bottomRight: Radius.circular(
                                  //                 16,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //           child: Text(
                                  //             '${discount.toInt()}% off',
                                  //             style: appTextStyle(
                                  //               FontWeight.bold,
                                  //               10,
                                  //               Colors.white,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       )
                                  //     : Container(),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Expanded(
                              flex: 6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Text(
                                    '${productList[index].name}',
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
                                            " ${formatter.format(productList[index].price)} /-",
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
                                      productList[index].previousPrice != 0
                                          ? Container(
                                              height: 16.0,
                                              child: Text(
                                                " Rs. ${formatter.format(productList[index].previousPrice)} ",
                                                style: GoogleFonts.mukta(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Colors.red,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationThickness: 4.0,
                                                  decorationColor: Colors.red,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: GestureDetector(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.remove_red_eye,
                                              size: 12.0,
                                              color: kGradientPrimary,
                                            ),
                                            SizedBox(width: 4.0),
                                            Text(
                                              '${productList[index].views.toString()} views',
                                              style: appTextStyle(
                                                FontWeight.w500,
                                                12.0,
                                                kPriceColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () {},
                                      ),
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
                    ),
                  );
                },
                itemCount: productList.length + 1,
              ),
            );
          }
        },
      ),
    );
  }
}
