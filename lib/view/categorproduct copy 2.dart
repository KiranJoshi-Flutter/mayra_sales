// import 'package:flutter/material.dart';
// // import 'package:hexcolor/hexcolor.dart';
// // import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:mayrasales/controller/app_localisation.dart';
// import 'package:mayrasales/funstions.dart';
// import 'package:mayrasales/model/categoryproduct_model.dart';
// import 'package:mayrasales/model/userpreferences.dart';
// import 'package:mayrasales/view/productdetail.dart';
// import 'package:mayrasales/widgets/widgets.dart';
// import 'package:pk_skeleton/pk_skeleton.dart';
// import 'package:requests/requests.dart';

// class CateoryProducts extends StatefulWidget {
//   final String categoryName;
//   final int categoryId;
//   final dynamic subCategoryId;
//   const CateoryProducts({
//     Key key1,
//     this.categoryId,
//     Key key,
//     this.subCategoryId,
//     Key key2,
//     this.categoryName,
//   }) : super(key: key);
//   @override
//   _CateoryProductsState createState() => _CateoryProductsState();
// }

// final productImages = [
//   'assets/images/poco_f2_pro.webp',
//   'assets/images/realmi5i.webp',
//   'assets/images/tv.webp',
//   'assets/images/samsung.webp',
// ];

// class _CateoryProductsState extends State<CateoryProducts> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
//   Future<List<Detail>> fCateoryProducts;

//   void initState() {
//     super.initState();
//     //_fetchProductDetails();

//     fCateoryProducts = _getProductList();
//   }

//   Future<List<Detail>> _getProductList() async {
//     //String apiToken = await UserPreferences.getApiToken();
//     String getURL;
//     if (widget.subCategoryId.toString() == "") {
//       getURL =
//           "https://mayrasales.com/api/category/${widget.categoryId.toString()}";
//     } else {
//       getURL =
//           "https://mayrasales.com/api/product_cat_sub?id=${widget.categoryId.toString()}&sub_id=${widget.subCategoryId.toString()}";
//     }
//     var r = await Requests.get(getURL);
//     print(getURL);
//     r.raiseForStatus();
//     var responseBody = r.content();

//     CategoryProductModel products = categoryProductModelFromJson(responseBody);

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
//       appBar: buildAppBar(context, widget.categoryName),
//       body: FutureBuilder(
//         future: fCateoryProducts,
//         builder: (context, snapshot) {
//           if (snapshot.data == null) {
//             return Container(
//               child: PKCardPageSkeleton(
//                 // isCircularImage: false,
//                 // isBottomLinesActive: true,
//                 // length: 4,
//                 totalLines: 4,
//               ),
//             );
//           } else {
//             // return Column(
//             //   children: <Widget>[
//             return productItems(snapshot.data);
//             // child: ListView.builder(
//             //   itemCount: snapshot.data.length,
//             //   itemBuilder: (context, int index) {

//             //   },
//             // ),

//             //_checkoutSection(snapshot.data)
//             //   ],
//             // );
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
//         childAspectRatio: 0.75,
//         children: List.generate(
//           products.length,
//           (index) {
//             return InkWell(
//               onTap: () {
//                 print(products[index].id);
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(
//                 //     builder: (context) =>
//                 //         ProductDetailPage(productId: products[index].id),
//                 //   ),
//                 // );
//               },
//               child: Container(
//                 width: MediaQuery.of(context).size.width / 2,
//                 height: 260,
//                 padding: const EdgeInsets.only(left: 8, right: 0),
//                 child: Card(
//                   child: new Container(
//                     padding: new EdgeInsets.all(8.0),
//                     child: new Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Container(
//                           padding: new EdgeInsets.all(2.0),
//                           height: 150,
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
//                             overflow: TextOverflow.ellipsis,
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
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xffff85b2), Color(0xffa797ff), Color(0xff00e5ff)],
//           ),
//         ),
//       ),
//       title: Text(
//         widget.categoryName,
//         style: appTextStyle(
//           FontWeight.w500,
//           20.0,
//           Colors.white,
//         ),
//         textAlign: TextAlign.center,
//       ),
//       actions: <Widget>[
//         //IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
//         IconButton(icon: Icon(Icons.message), onPressed: () {}),
//         IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
//         //_buildAvatar(context)
//       ],
//     );
//   }
// }
