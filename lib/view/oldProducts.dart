// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:mayrasales/controller/app_localisation.dart';
// import 'package:mayrasales/model/products_model.dart';
// import 'package:mayrasales/model/userpreferences.dart';
// import 'package:mayrasales/view/cart.dart';
// import 'package:mayrasales/view/login.dart';
// import 'package:mayrasales/view/productdetail.dart';
// import 'package:requests/requests.dart';

// class Products extends StatefulWidget {
//   @override
//   _ProductsState createState() => _ProductsState();
// }

// final productImages = [
//   'assets/images/poco_f2_pro.webp',
//   'assets/images/realmi5i.webp',
//   'assets/images/tv.webp',
//   'assets/images/samsung.webp',
// ];

// class _ProductsState extends State<Products> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
//   Future<List<Detail>> fProducts;

//   void initState() {
//     super.initState();
//     //_fetchProductDetails();

//     fProducts = _getProductList();
//   }

//   Future<List<Detail>> _getProductList() async {
//     //String apiToken = await UserPreferences.getApiToken();
//     String getCartURL = "https://mayrasales.com/api/products";
//     var r = await Requests.get(getCartURL);
//     print(getCartURL);
//     r.raiseForStatus();
//     var responseBody = r.content();

//     ProductsModel products = productsModelFromJson(responseBody);

//     List<Detail> productDtls = List<Detail>();

//     if (products.status == "success") {
//       for (var u = 0; u < products.details.length; u++) {
//         Detail productDtl = products.details[u];

//         productDtls.add(productDtl);
//       }
//     }

//     return productDtls;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: _buildAppBar(context),
//       body: FutureBuilder(
//         future: fProducts,
//         builder: (context, snapshot) {
//           if (snapshot.data == null) {
//             return Container(
//               decoration: BoxDecoration(color: Colors.white),
//               alignment: Alignment.center,
//               child: Image.asset(
//                 'assets/icons/loading.gif',
//                 scale: 2.5,
//               ),
//             );
//           } else {
//             return productItems(snapshot.data);
//           }
//         },
//       ),
//     );
//   }

//   Widget productItems(List<Detail> products) {
//     if (products.length != 0) {
//       return GridView.count(
//         crossAxisCount: 2,
//         crossAxisSpacing: 4.0,
//         mainAxisSpacing: 4.0,
//         shrinkWrap: true,
//         //physics: NeverScrollableScrollPhysics(),
//         childAspectRatio: MediaQuery.of(context).size.height / 1100,
//         children: List.generate(
//           products.length,
//           (index) {
//             return InkWell(
//               onTap: () {
//                 print(products[index].id);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) =>
//                         ProductDetailPage(productId: products[index].id),
//                   ),
//                 );
//               },
//               child: Container(
//                 width: MediaQuery.of(context).size.width / 2,
//                 //height: 260,
//                 padding: const EdgeInsets.only(left: 8, right: 0),
//                 child: Card(
//                   child: new Container(
//                     padding: new EdgeInsets.all(8.0),
//                     child: new Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Container(
//                           padding: new EdgeInsets.all(2.0),
//                           height: 170,
//                           child: Image.network(
//                             "https://mayrasales.com/assets/images/thumbnails/${products[index].thumbnail}",
//                             fit: BoxFit.fitWidth,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Align(
//                           alignment: Alignment
//                               .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
//                           child: Text(
//                             "${products[index].name}",
//                             softWrap: true,
//                             style: new TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14.0,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Align(
//                           alignment: Alignment
//                               .centerLeft, // Align however you like (i.e .centerRight, centerLeft)
//                           child: Text(
//                             AppLocalizations.of(context).translate('str_rs') +
//                                 " ${products[index].price.toString()}",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         //new Text('Rs. 35,000')
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     } else {
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
//         child: Text(
//           AppLocalizations.of(context).translate('str_no_item_found'),
//           style: TextStyle(
//             fontSize: 16.0,
//             fontStyle: FontStyle.italic,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       );
//     }
//   }

//   AppBar _buildAppBar(BuildContext context) {
//     return AppBar(
//       //iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
//       titleSpacing: 0.0,
//       elevation: 0.5,
//       flexibleSpace: Container(
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//             Hexcolor("#ffff85b2"),
//             Hexcolor("#ffa797ff"),
//             Hexcolor("#ff00e5ff")
//           ]))),
//       title: Text(
//         AppLocalizations.of(context).translate('str_products'),
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//         textAlign: TextAlign.center,
//       ),
//       actions: <Widget>[
//         //IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
//         //IconButton(icon: Icon(Icons.message), onPressed: () {}),
//         IconButton(
//           icon: Icon(Icons.shopping_cart),
//           onPressed: () async {
//             bool userLoggedIn = await UserPreferences.getLoginStatus();
//             //Navigator.pop(context);
//             if (userLoggedIn) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Cart(),
//                 ),
//               );
//             } else {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Login(
//                       titlePage: AppLocalizations.of(context)
//                           .translate('str_user_login')),
//                 ),
//               );
//             }
//           },
//         ),
//         //_buildAvatar(context)
//       ],
//     );
//   }
// }
