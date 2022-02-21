import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/model/ads_model.dart';
import 'package:mayrasales/model/categoryproduct_model.dart';
import 'package:mayrasales/model/model_featured_products.dart';
//import 'package:mayrasales/model/products_model.dart';
// import 'package:mayrasales/model/searchproductmodel.dart';
import 'package:mayrasales/model/slider_model.dart';
import 'package:mayrasales/model/userdetails_model.dart';
//import 'package:mayrasales/model/premium_product_model.dart'
//as premiumProductModel;
import 'package:mayrasales/model/userpreferences.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:mayrasales/view/appaboutus.dart';
import 'package:mayrasales/view/cart.dart';
import 'package:mayrasales/view/cart2.dart';
import 'package:mayrasales/view/categorproduct.dart';
import 'package:mayrasales/view/category.dart';
import 'package:mayrasales/view/login.dart';
import 'package:mayrasales/view/productdetail.dart';
import 'package:mayrasales/view/products.dart';
import 'package:mayrasales/view/profile.dart';
import 'package:mayrasales/view/setting.dart';

import 'package:mayrasales/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mayrasales/wishlist.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'dart:convert';

import 'package:requests/requests.dart';

// class SearchPage extends StatefulWidget {
//   final String searchValue;

//   SearchPage(this.searchValue);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(searchValue),
//       ),
//     );
//   }

//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     throw UnimplementedError();
//   }
// }

class SearchScreen extends StatefulWidget {
  final String query;

  const SearchScreen({Key key, this.query}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  Future<List<Detail>> fProducts;

  void initState() {
    super.initState();
    //_fetchProductDetails();
    print("dgddfdfdddfdddfdf ${widget.query}");

    fProducts = _getProductList();
  }

  Future<List<Detail>> _getProductList() async {
    //String apiToken = await UserPreferences.getApiToken();
    if (widget.query != '') {
      String getCartURL = "https://mayrasales.com/api/search/${widget.query}";
      try {
        var r = await Requests.get(getCartURL);
        print(getCartURL);
        //r.raiseForStatus();
        var responseBody = r.content();

        print(responseBody);

        CategoryProductModel products =
            categoryProductModelFromJson(responseBody);

        if (products.status != "failure") {
          List<Detail> productDtls = List<Detail>();

          // if (products.status == "success") {
          //   if (products.details.length != 0) {
          //     for (var u = 0; u < products.details.length; u++) {
          //       Detail productDtl = products.details[u];

          //       productDtls.add(productDtl);
          //     }
          //   }
          // }

          return productDtls;
        }
      } on HttpException catch (error) {
        print(error.toString());
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      body: FutureBuilder(
        future: fProducts,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              decoration: BoxDecoration(color: Colors.white),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/icons/loading.gif',
                scale: 2.5,
              ),
            );
          } else {
            return productItems(snapshot.data);
          }
        },
      ),
    );
  }

  Widget productItems(List<Detail> products) {
    if (products.length != 0) {
      return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        shrinkWrap: true,
        //physics: NeverScrollableScrollPhysics(),
        childAspectRatio: MediaQuery.of(context).size.height / 1100,
        children: List.generate(
          products.length,
          (index) {
            return InkWell(
              onTap: () {
                // print(products[index].id);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         ProductDetailPage(productId: products[index].id),
                //   ),
                // );
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                //height: 260,
                padding: const EdgeInsets.only(left: 8, right: 0),
                child: Card(
                  child: new Container(
                    padding: new EdgeInsets.all(8.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: new EdgeInsets.all(2.0),
                          height: 150,
                          child: Image.network(
                            "https://mayrasales.com/assets/images/thumbnails/${products[index].thumbnail}",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Align(
                          alignment: Alignment
                              .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                          child: Text(
                            "${products[index].name}",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Align(
                          alignment: Alignment
                              .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                          child: Text(
                            AppLocalizations.of(context).translate('str_rs') +
                                " ${products[index].price.toString()}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        //new Text('Rs. 35,000')
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
        child: Text(
          AppLocalizations.of(context).translate('str_no_item_found'),
          style: TextStyle(
            fontSize: 16.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      //iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      titleSpacing: 0.0,
      elevation: 0.5,
      flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
            Color(0xffff85b2),
            Color(0xffa797ff),
            Color(0xff00e5ff)
          ]))),
      title: Text(
        'Searched Products',
        // AppLocalizations.of(context).translate('str_products'),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        //IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        //IconButton(icon: Icon(Icons.message), onPressed: () {}),
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () async {
            bool userLoggedIn = await UserPreferences.getLoginStatus();
            //Navigator.pop(context);
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
        //_buildAvatar(context)
      ],
    );
  }
}
