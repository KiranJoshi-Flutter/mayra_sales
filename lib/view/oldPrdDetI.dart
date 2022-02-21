// import 'package:chips_choice/chips_choice.dart';
// import 'package:flushbar/flushbar.dart';
// import 'package:mayrasales/controller/app_localisation.dart';
// import 'package:mayrasales/controller/session.dart';
// import 'package:mayrasales/model/product.dart';
// import 'package:mayrasales/model/product_details.dart';
// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:http/http.dart' as http;
// import 'package:mayrasales/model/userpreferences.dart';
// import 'package:mayrasales/view/cart.dart';
// import 'package:mayrasales/view/login.dart';
// import 'package:mayrasales/wishlist.dart';
// import 'package:requests/requests.dart';

// //import 'package:flutter_html/flutter_html.dart';
// //import 'package:cached_network_image/cached_network_image.dart';

// class OldProductDetailPage extends StatefulWidget {
//   final int productId;
//   const OldProductDetailPage({Key key, this.productId}) : super(key: key);
//   @override
//   _OldProductDetailPage createState() => _OldProductDetailPage();
// }

// int _current = 0;
// List<String> imgList = [
//   // 'https://www.gizmochina.com/wp-content/uploads/2020/01/Xiaomi-Mi-10-Pro-5G-1-500x500.jpg',
//   // 'https://i01.appmifile.com/webfile/globalimg/in/cms/D1301D76-E04D-EF09-6195-53229DE6D543.jpg',
//   // 'https://img.gkbcdn.com/p/2020-04-28/Xiaomi-Mi-10-Lite-6-57-Inch-5G-Smartphone-6GB-128GB-Gray-903190-._w500_.jpg'
// ];

// var screenSize = 0;

// class _OldProductDetailPage extends State<OldProductDetailPage> {
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   int _n = 0;

//   Widget appBarTitle = new Text("Product Details");
//   bool isExpanded = false;

//   var tag;
//   var _selectedColor;
//   var _selectedSize;

//   var sizeList;
//   var colorList;

//   bool isWishlisted = false;

//   List<Detail> fProductDtls = List<Detail>();
//   Future<List<Detail>> fProductsDetails;
//   List<Widget> imageSliders = List<Widget>();

//   List<CartProduct> _cartList = List<CartProduct>();

//   String requestCookies;

//   Requests requests = Requests();

//   Session a = Session();

//   String apiToken;

//   final categoryBgColor = [
//     '#fff0b8d1',
//     '#ffcabbf0',
//     '#ffa4e4fb',
//     '#fff0b8d1',
//     '#ffcabbf0',
//   ];

//   final titles = [
//     'Fashion',
//     'Smartphones',
//     'Electronics',
//     'Grocery',
//     'Fast Food'
//   ];

//   //List<Widget> imageSliders;

//   void initState() {
//     super.initState();
//     //_fetchProductDetails();

//     fProductsDetails = _getProductDetails();
//   }

//   _fetchProductDetails() async {
//     var data = await http
//         .get("https://mayrasales.com/api/product/${widget.productId}");

//     var responseBody = data.body;

//     List<Detail> prdts = List<Detail>();

//     //print(jsonData);

//     ProductDetails productModel = productDetailsFromJson(responseBody);

//     if (productModel.status == "success") {
//       print(productModel.details.length);

//       for (var u = 0; u < productModel.details.length; u++) {
//         Detail product = productModel.details[u];

//         prdts.add(product);
//       }
//     }

//     fProductDtls = prdts;

//     //_loadImgList();
//     print(prdts);

//     return prdts;
//   }

//   Future<List<Detail>> _getProductDetails() async {
//     var data = await http
//         .get("https://mayrasales.com/api/product/${widget.productId}");

//     var responseBody = data.body;

//     //Session a = Session();
//     var n = a.get("https://mayrasales.com/api/product/${widget.productId}");

//     print(await n);

//     ProductDetails productModel = productDetailsFromJson(responseBody);

//     List<Detail> productDtls = List<Detail>();

//     if (productModel.status == "success") {
//       UserPreferences.setCookies(data.headers['set-cookie']);
//       requestCookies = await UserPreferences.getCookies();
//       print("**************************************************" +
//           requestCookies);

//       for (var u = 0; u < productModel.details.length; u++) {
//         Detail productDtl = productModel.details[u];

//         productDtls.add(productDtl);
//       }
//     }

//     imgList = [];

//     for (var u = 0; u < productDtls.length; u++) {
//       print(productDtls[u].photo);
//       imgList.add(
//           "https://mayrasales.com/assets/images/thumbnails/${productDtls[u].thumbnail}");
//     }

//     imageSliders = imgList
//         .map(
//           (item) => Container(
//             child: Container(
//               padding: EdgeInsets.symmetric(vertical: 8),
//               //color: Hexcolor("#ffa797ff"),
//               margin: EdgeInsets.all(0.0),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 child: Stack(
//                   children: <Widget>[
//                     // CachedNetworkImage(
//                     //   imageUrl: item,
//                     //   fit: BoxFit.fitHeight,
//                     //   progressIndicatorBuilder: (context, url, progress) =>
//                     //       CircularProgressIndicator(
//                     //     value: progress.progress,
//                     //   ),
//                     // ),
//                     Image.network(item, fit: BoxFit.fitHeight, width: 1000.0),
//                     // Positioned(
//                     //   bottom: 0.0,
//                     //   left: 0.0,
//                     //   right: 0.0,
//                     //   child: Container(
//                     //     padding: EdgeInsets.symmetric(
//                     //         vertical: 10.0, horizontal: 16.0),
//                     //     child: Text(
//                     //       'image',
//                     //       style: TextStyle(
//                     //         color: Colors.white,
//                     //         fontSize: 20.0,
//                     //         fontWeight: FontWeight.bold,
//                     //       ),
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         )
//         .toList();

//     print(imgList);

//     print("FPD");

//     //_loadImgList();

//     fProductDtls = productDtls;

//     return productDtls;
//   }

//   // _loadImgList() {
//   //   for (var u = 0; u < fProductDtls.length; u++) {
//   //     print(fProductDtls[u].photo);
//   //     imgList.add(
//   //         "https://mayrasales.com/assets/images/products/${fProductDtls[u].photo}");
//   //   }
//   //}

//   // List<DropdownMenuItem<String>> buildDropDownMenuItems(List listItems) {
//   //   List<DropdownMenuItem<String>> items = List();
//   //   for (String listItem in listItems) {
//   //     items.add(
//   //       DropdownMenuItem(
//   //         child: Text(listItem.name),
//   //         value: listItem,
//   //       ),
//   //     );
//   //   }
//   //   return items;
//   // }
//   void add() {
//     setState(() {
//       _n++;
//     });
//   }

//   void minus() {
//     setState(() {
//       if (_n != 0) _n--;
//     });
//   }

//   bool _isLoading = true;

//   Widget build(BuildContext context) {
//     //print("ImList = ${imgList}");

//     print('*************************************${this.isWishlisted}');

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       key: scaffoldKey,
//       appBar: AppBar(
//         title:
//             Text(AppLocalizations.of(context).translate('str_product_details')),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Hexcolor("#ffff85b2"),
//                 Hexcolor("#ffa797ff"),
//                 Hexcolor("#ff00e5ff")
//               ],
//             ),
//           ),
//         ),
//         actions: [
//           Builder(
//             builder: (BuildContext context) {
//               return IconButton(
//                 icon: isWishlisted
//                     ? Icon(Icons.favorite, color: Colors.redAccent)
//                     : Icon(Icons.favorite_border),
//                 onPressed: () async {
//                   // final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
//                   // Scaffold.of(context).showSnackBar(snackBar);
//                   //isWishlisted = !isWishlisted;

//                   setState(
//                     () {
//                       this.isWishlisted = !isWishlisted;

//                       print(this.isWishlisted);
//                     },
//                   );

//                   apiToken = await UserPreferences.getApiToken();

//                   //     print(wishlistURL);

//                   if (isWishlisted) {
//                     String wishlistURL =
//                         "https://mayrasales.com/api/user/wishlist/add/${widget.productId}?api_token=$apiToken";
//                     var r = await Requests.get(wishlistURL);
//                     r.raiseForStatus();
//                     String responseBody = r.content();
//                     print(r.headers);
//                     print(r.statusCode);
//                     print(responseBody);

//                     if (r.statusCode == 200) {
//                       Flushbar(
//                         forwardAnimationCurve: Curves.decelerate,
//                         reverseAnimationCurve: Curves.easeOut,
//                         message: AppLocalizations.of(context)
//                             .translate('str_add_item_wishlist_msg'),
//                         duration: Duration(seconds: 3),
//                         margin: EdgeInsets.all(8),
//                         borderRadius: 8,
//                         flushbarStyle: FlushbarStyle.FLOATING,
//                         flushbarPosition: FlushbarPosition.TOP,
//                         backgroundColor: Hexcolor("#ff228B22"),
//                         mainButton: FlatButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => Wishlist(),
//                               ),
//                             );
//                           },
//                           child: Text(
//                             AppLocalizations.of(context)
//                                 .translate('str_go_to_wishlist'),
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       )..show(context);
//                     }
//                   } else {
//                     String wishlistURL =
//                         "https://mayrasales.com/api/user/wishlist/remove/${widget.productId}?api_token=$apiToken";
//                     var r = await Requests.get(wishlistURL);
//                     r.raiseForStatus();
//                     String responseBody = r.content();
//                     // print(r.headers);
//                     // print(r.statusCode);
//                     // print(responseBody);
//                     if (r.statusCode == 200) {
//                       Flushbar(
//                         forwardAnimationCurve: Curves.decelerate,
//                         reverseAnimationCurve: Curves.easeOut,
//                         message: AppLocalizations.of(context)
//                             .translate('str_delete_item_wishlist_msg'),
//                         duration: Duration(seconds: 3),
//                         margin: EdgeInsets.all(8),
//                         borderRadius: 8,
//                         flushbarStyle: FlushbarStyle.FLOATING,
//                         flushbarPosition: FlushbarPosition.TOP,
//                         backgroundColor: Colors.red,
//                       )..show(context);
//                     }
//                   }
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder(
//         future: fProductsDetails,
//         builder: (context, snapshot) {
//           if (snapshot.data == null) {
//             // return LoadingOverlay(
//             //   child: SingleChildScrollView(
//             //     child: Container(
//             //       padding: const EdgeInsets.all(16.0),
//             //       //child: buildLoginForm(context),
//             //     ),
//             //   ),
//             //   isLoading: _isLoading,
//             //   // demo of some additional parameters
//             //   opacity: 0.5,
//             //   progressIndicator: CircularProgressIndicator(),
//             // );
//             return Container(
//               decoration: BoxDecoration(color: Colors.white),
//               alignment: Alignment.center,
//               child: Image.asset(
//                 'assets/icons/loading.gif',
//                 scale: 2.5,
//               ),
//             );
//           } else {
//             //print({snapshot.data[0].color),

//             // setState(() {
//             //   _isLoading = false;
//             // });
//             return SafeArea(
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: <Widget>[
//                   SingleChildScrollView(
//                     padding: EdgeInsets.symmetric(vertical: 0),
//                     child: Container(
//                       //decoration: BoxDecoration(
//                       padding: EdgeInsets.only(top: 16),
//                       color: Hexcolor("#ffffffff"),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           CarouselSlider(
//                             items: imageSliders,
//                             options: CarouselOptions(
//                               autoPlay: false,
//                               enlargeCenterPage: true,
//                               aspectRatio: 1.8,
//                               autoPlayCurve: Curves.fastOutSlowIn,
//                               onPageChanged: (index, reason) {
//                                 setState(
//                                   () {
//                                     _current = index;
//                                   },
//                                 );
//                               },
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: imgList.map(
//                               (url) {
//                                 int index = imgList.indexOf(url);
//                                 return Container(
//                                   width: 8.0,
//                                   height: 8.0,
//                                   margin: EdgeInsets.symmetric(
//                                       vertical: 10.0, horizontal: 2.0),
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: _current == index
//                                         ? Color.fromRGBO(0, 0, 0, 0.9)
//                                         : Color.fromRGBO(0, 0, 0, 0.4),
//                                   ),
//                                 );
//                               },
//                             ).toList(),
//                           ),
//                           Container(
//                             margin:
//                                 const EdgeInsets.only(top: 4.0, bottom: 4.0),
//                             height: 0.5,
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                                 colors: [
//                                   Hexcolor("#ffff85b2"),
//                                   Hexcolor("#ffa797ff"),
//                                   Hexcolor("#ff00e5ff")
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Flexible(
//                                 child: Container(
//                                   padding: EdgeInsets.all(16),
//                                   child: Text(
//                                     snapshot.data[0].name,
//                                     softWrap: true,
//                                     style: new TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 18.0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Flexible(
//                                 child: Container(
//                                   padding: EdgeInsets.fromLTRB(16, 0, 16, 4),
//                                   child: Text(
//                                     AppLocalizations.of(context)
//                                             .translate('str_rs') +
//                                         " ${snapshot.data[0].price}",
//                                     softWrap: true,
//                                     style: new TextStyle(
//                                       fontWeight: FontWeight.w800,
//                                       fontSize: 24.0,
//                                       color: Hexcolor("#ffa797ff"),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Flexible(
//                                 child: Container(
//                                   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                                   child: IconButton(
//                                     padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                                     icon: Icon(Icons.share),
//                                     iconSize: 24.0,
//                                     onPressed: () {
//                                       /*...*/
//                                       // Toast.show("Forgot Password ..........", context,
//                                       //     duration: Toast.LENGTH_SHORT,
//                                       //     gravity: Toast.BOTTOM);
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),

//                           Container(
//                             padding: EdgeInsets.fromLTRB(8, 0, 16, 4),
//                             child: RatingBar(
//                               initialRating: 3.5,
//                               minRating: 1,
//                               direction: Axis.horizontal,
//                               allowHalfRating: true,
//                               itemCount: 5,
//                               itemPadding:
//                                   EdgeInsets.symmetric(horizontal: 4.0),
//                               ignoreGestures: true,
//                               itemSize: 20,
//                               itemBuilder: (context, _) => Icon(
//                                 Icons.star,
//                                 color: Colors.amber,
//                                 size: 9,
//                               ),
//                               onRatingUpdate: (rating) {
//                                 print(rating);
//                               },
//                             ),
//                           ),

//                           Container(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: <Widget>[
//                                 Container(
//                                   child: new Center(
//                                     child: new Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: <Widget>[
//                                         Text(
//                                             AppLocalizations.of(context)
//                                                 .translate('str_quantity'),
//                                             style:
//                                                 new TextStyle(fontSize: 14.0)),
//                                         new IconButton(
//                                           onPressed: add,
//                                           icon: new Icon(
//                                             Icons.add,
//                                             color: Colors.black,
//                                           ),
//                                           //backgroundColor: Colors.white,
//                                         ),
//                                         new Text('$_n',
//                                             style:
//                                                 new TextStyle(fontSize: 16.0)),
//                                         new IconButton(
//                                           onPressed: minus,
//                                           icon: new Icon(
//                                               const IconData(0xe15b,
//                                                   fontFamily: 'MaterialIcons'),
//                                               color: Colors.black),
//                                           //backgroundColor: Colors.white,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Spacer(),
//                                 //const SizedBox(width: 20.0),

//                                 RaisedButton(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 8.0,
//                                     horizontal: 16.0,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10.0),
//                                   ),
//                                   onPressed: () async {
//                                     // print(snapshot.data[0].color);
//                                     // print(snapshot.data[0].size);

//                                     // if (snapshot.data[0].color != "") {
//                                     //   print("Color Variation");
//                                     // } else {
//                                     //   print("No Variation");
//                                     // }
//                                     apiToken =
//                                         await UserPreferences.getApiToken();
//                                     if ((snapshot.data[0].color != null) ||
//                                         (snapshot.data[0].size != null)) {
//                                       //if (snapshot.data[0].size != null) {}
//                                       if ((snapshot.data[0].color != "") ||
//                                           (snapshot.data[0].size != "")) {
//                                         showModalBottomSheet(
//                                           context: context,
//                                           builder: (context) {
//                                             return StatefulBuilder(
//                                               builder: (BuildContext context,
//                                                   StateSetter setState) {
//                                                 return Container(
//                                                   padding: EdgeInsets.symmetric(
//                                                       vertical: 4.0,
//                                                       horizontal: 16.0),
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     mainAxisSize:
//                                                         MainAxisSize.min,
//                                                     children: [
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .start,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         mainAxisSize:
//                                                             MainAxisSize.min,
//                                                         children: <Widget>[
//                                                           Card(
//                                                             shape:
//                                                                 RoundedRectangleBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           8.0),
//                                                             ),
//                                                             child: Container(
//                                                               //width: 100,
//                                                               padding:
//                                                                   EdgeInsets
//                                                                       .all(4.0),
//                                                               child:
//                                                                   Image.network(
//                                                                 'https://mayrasales.com/assets/images/thumbnails/${snapshot.data[0].thumbnail}',
//                                                                 fit: BoxFit
//                                                                     .fitHeight,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Flexible(
//                                                             child: Padding(
//                                                               padding: const EdgeInsets
//                                                                       .symmetric(
//                                                                   horizontal:
//                                                                       10,
//                                                                   vertical: 16),
//                                                               child: Column(
//                                                                 children: <
//                                                                     Widget>[
//                                                                   Row(
//                                                                     children: <
//                                                                         Widget>[
//                                                                       Flexible(
//                                                                         child:
//                                                                             Text(
//                                                                           AppLocalizations.of(context).translate('str_rs') +
//                                                                               snapshot.data[0].price.toString(),
//                                                                           overflow:
//                                                                               TextOverflow.fade,
//                                                                           softWrap:
//                                                                               true,
//                                                                           style: TextStyle(
//                                                                               fontWeight: FontWeight.w600,
//                                                                               fontSize: 16),
//                                                                         ),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                   //Spacer(),
//                                                                   SizedBox(
//                                                                       height:
//                                                                           8),
//                                                                   Row(
//                                                                     children: <
//                                                                         Widget>[
//                                                                       Text(
//                                                                         snapshot
//                                                                             .data[0]
//                                                                             .name,
//                                                                         style: TextStyle(
//                                                                             fontSize:
//                                                                                 16,
//                                                                             fontWeight:
//                                                                                 FontWeight.w400),
//                                                                       )
//                                                                     ],
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           )
//                                                         ],
//                                                       ),
//                                                       Divider(),
//                                                       _colorChooser(snapshot
//                                                           .data[0].color),
//                                                       Divider(),
//                                                       _sizeChooser(snapshot
//                                                           .data[0].size),
//                                                       Flexible(
//                                                         fit: FlexFit.loose,
//                                                         child: Align(
//                                                           alignment: Alignment
//                                                               .bottomCenter,
//                                                           child: RaisedButton(
//                                                             onPressed:
//                                                                 () async {
//                                                               if (_n != 0) {
//                                                                 var userLoggedIn =
//                                                                     await UserPreferences
//                                                                         .getLoginStatus();
//                                                                 if (userLoggedIn) {
//                                                                   apiToken =
//                                                                       await UserPreferences
//                                                                           .getApiToken();
//                                                                   String
//                                                                       cartURL =
//                                                                       "https://mayrasales.com/api/user/cart/add?api_token=$apiToken&price=${snapshot.data[0].price.toString()}&product_id=${widget.productId}&qty=$_n&size=$_selectedSize&color=$_selectedColor";
//                                                                   print(
//                                                                       cartURL);

//                                                                   var r = await Requests
//                                                                       .get(
//                                                                           cartURL);
//                                                                   r.raiseForStatus();
//                                                                   String
//                                                                       responseBody =
//                                                                       r.content();
//                                                                   print(r
//                                                                       .headers);
//                                                                   print(r
//                                                                       .statusCode);
//                                                                   print(
//                                                                       responseBody);

//                                                                   if (r.statusCode ==
//                                                                       200) {
//                                                                     Flushbar(
//                                                                       forwardAnimationCurve:
//                                                                           Curves
//                                                                               .decelerate,
//                                                                       reverseAnimationCurve:
//                                                                           Curves
//                                                                               .easeOut,
//                                                                       message: AppLocalizations.of(
//                                                                               context)
//                                                                           .translate(
//                                                                               'str_add_item_cart_msg'),
//                                                                       duration: Duration(
//                                                                           seconds:
//                                                                               3),
//                                                                       margin: EdgeInsets
//                                                                           .all(
//                                                                               8),
//                                                                       borderRadius:
//                                                                           8,
//                                                                       flushbarStyle:
//                                                                           FlushbarStyle
//                                                                               .FLOATING,
//                                                                       flushbarPosition:
//                                                                           FlushbarPosition
//                                                                               .TOP,
//                                                                       backgroundColor:
//                                                                           Hexcolor(
//                                                                               "#ff228B22"),
//                                                                       mainButton:
//                                                                           FlatButton(
//                                                                         onPressed:
//                                                                             () {
//                                                                           Navigator.pop(
//                                                                               context);
//                                                                           Navigator
//                                                                               .push(
//                                                                             context,
//                                                                             MaterialPageRoute(
//                                                                               builder: (context) => Cart(),
//                                                                             ),
//                                                                           );
//                                                                         },
//                                                                         child:
//                                                                             Text(
//                                                                           AppLocalizations.of(context)
//                                                                               .translate('str_go_to_cart'),
//                                                                           style:
//                                                                               TextStyle(color: Colors.white),
//                                                                         ),
//                                                                       ),
//                                                                     )..show(
//                                                                         context);
//                                                                   }
//                                                                 } else {
//                                                                   Navigator.pop(
//                                                                       context);
//                                                                   Navigator
//                                                                       .push(
//                                                                     context,
//                                                                     MaterialPageRoute(
//                                                                       builder:
//                                                                           (context) =>
//                                                                               Login(
//                                                                         titlePage:
//                                                                             AppLocalizations.of(context).translate('str_user_login'),
//                                                                       ),
//                                                                     ),
//                                                                   );
//                                                                 }
//                                                               } else {
//                                                                 _quantityAlert(
//                                                                     context);
//                                                               }
//                                                             },
//                                                             textColor:
//                                                                 Colors.white,
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .all(0.0),
//                                                             shape: RoundedRectangleBorder(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             10.0)),
//                                                             child: Container(
//                                                               width: double
//                                                                   .infinity,
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             10.0),
//                                                                 gradient:
//                                                                     LinearGradient(
//                                                                   begin: Alignment
//                                                                       .topLeft,
//                                                                   end: Alignment
//                                                                       .bottomRight,
//                                                                   colors: [
//                                                                     Hexcolor(
//                                                                         "#ffff85b2"),
//                                                                     Hexcolor(
//                                                                         "#ffa797ff"),
//                                                                     Hexcolor(
//                                                                         "#ff00e5ff")
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               padding: const EdgeInsets
//                                                                       .symmetric(
//                                                                   vertical: 8.0,
//                                                                   horizontal:
//                                                                       16.0),
//                                                               child: Row(
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .center,
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .center,
//                                                                 mainAxisSize:
//                                                                     MainAxisSize
//                                                                         .min,
//                                                                 children: <
//                                                                     Widget>[
//                                                                   Text(
//                                                                     AppLocalizations.of(
//                                                                             context)
//                                                                         .translate(
//                                                                             'str_add_to_cart'),
//                                                                     style: TextStyle(
//                                                                         color: Colors
//                                                                             .white,
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .bold,
//                                                                         fontSize:
//                                                                             16.0),
//                                                                   ),
//                                                                   const SizedBox(
//                                                                       width:
//                                                                           4.0),
//                                                                   Container(
//                                                                     padding:
//                                                                         const EdgeInsets.all(
//                                                                             8.0),
//                                                                     child: Icon(
//                                                                       Icons
//                                                                           .shopping_cart,
//                                                                       color: Colors
//                                                                           .white,
//                                                                       size:
//                                                                           20.0,
//                                                                     ),
//                                                                     decoration:
//                                                                         BoxDecoration(
//                                                                       color: Colors
//                                                                           .transparent,
//                                                                       borderRadius:
//                                                                           BorderRadius.circular(
//                                                                               10.0),
//                                                                     ),
//                                                                   )
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 );
//                                               },
//                                             );
//                                           },
//                                         );
//                                       } else {
//                                         print("API Request");

//                                         if (_n != 0) {
//                                           apiToken = await UserPreferences
//                                               .getApiToken();
//                                           String cartURL =
//                                               "https://mayrasales.com/api/user/cart/add?api_token=$apiToken&qty=$_n&size_key&size_qty&size_price&size&color&stock&price=${snapshot.data[0].price.toString()}&product_id=${widget.productId}&license&dp";
//                                           print(cartURL);

//                                           var r = await Requests.get(cartURL);
//                                           r.raiseForStatus();
//                                           String responseBody = r.content();
//                                           print(r.headers);
//                                           print(r.statusCode);
//                                           print(responseBody);

//                                           if (r.statusCode == 200) {
//                                             Flushbar(
//                                               forwardAnimationCurve:
//                                                   Curves.decelerate,
//                                               reverseAnimationCurve:
//                                                   Curves.easeOut,
//                                               message: AppLocalizations.of(
//                                                       context)
//                                                   .translate(
//                                                       'str_add_item_cart_msg'),
//                                               duration: Duration(seconds: 3),
//                                               margin: EdgeInsets.all(8),
//                                               borderRadius: 8,
//                                               flushbarStyle:
//                                                   FlushbarStyle.FLOATING,
//                                               flushbarPosition:
//                                                   FlushbarPosition.TOP,
//                                               backgroundColor:
//                                                   Hexcolor("#ff228B22"),
//                                               mainButton: FlatButton(
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                   Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           Cart(),
//                                                     ),
//                                                   );
//                                                 },
//                                                 child: Text(
//                                                   AppLocalizations.of(context)
//                                                       .translate(
//                                                           'str_go_to_cart'),
//                                                   style: TextStyle(
//                                                       color: Colors.white),
//                                                 ),
//                                               ),
//                                             )..show(context);
//                                           }
//                                         } else {
//                                           _quantityAlert(context);
//                                         }
//                                       }
//                                     }
//                                   },
//                                   color: Hexcolor("#ffff85b2"),
//                                   textColor: Colors.white,
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: <Widget>[
//                                       Text(
//                                         AppLocalizations.of(context)
//                                             .translate('str_add_to_cart'),
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16.0,
//                                         ),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                       // Container(
//                                       //   padding: const EdgeInsets.all(8.0),
//                                       //   child: Icon(
//                                       //     Icons.shopping_cart,
//                                       //     color: Hexcolor("#ffff85b2"),
//                                       //     size: 16.0,
//                                       //   ),
//                                       //   decoration: BoxDecoration(
//                                       //       color: Colors.white,
//                                       //       borderRadius:
//                                       //           BorderRadius.circular(10.0)),
//                                       // )
//                                     ],
//                                   ),
//                                 ),

//                                 // RaisedButton(
//                                 //   onPressed: () async {
//                                 //     // print(snapshot.data[0].color);
//                                 //     // print(snapshot.data[0].size);

//                                 //     // if (snapshot.data[0].color != "") {
//                                 //     //   print("Color Variation");
//                                 //     // } else {
//                                 //     //   print("No Variation");
//                                 //     // }
//                                 //     apiToken =
//                                 //         await UserPreferences.getApiToken();
//                                 //     if ((snapshot.data[0].color != null) ||
//                                 //         (snapshot.data[0].size != null)) {
//                                 //       //if (snapshot.data[0].size != null) {}
//                                 //       if ((snapshot.data[0].color != "") ||
//                                 //           (snapshot.data[0].size != "")) {
//                                 //         showModalBottomSheet(
//                                 //           context: context,
//                                 //           builder: (context) {
//                                 //             return StatefulBuilder(
//                                 //               builder: (BuildContext context,
//                                 //                   StateSetter setState) {
//                                 //                 return Container(
//                                 //                   padding: EdgeInsets.symmetric(
//                                 //                       vertical: 4.0,
//                                 //                       horizontal: 16.0),
//                                 //                   child: Column(
//                                 //                     crossAxisAlignment:
//                                 //                         CrossAxisAlignment
//                                 //                             .start,
//                                 //                     mainAxisSize:
//                                 //                         MainAxisSize.min,
//                                 //                     children: [
//                                 //                       Row(
//                                 //                         mainAxisAlignment:
//                                 //                             MainAxisAlignment
//                                 //                                 .start,
//                                 //                         crossAxisAlignment:
//                                 //                             CrossAxisAlignment
//                                 //                                 .start,
//                                 //                         mainAxisSize:
//                                 //                             MainAxisSize.min,
//                                 //                         children: <Widget>[
//                                 //                           Card(
//                                 //                             shape:
//                                 //                                 RoundedRectangleBorder(
//                                 //                               borderRadius:
//                                 //                                   BorderRadius
//                                 //                                       .circular(
//                                 //                                           8.0),
//                                 //                             ),
//                                 //                             child: Container(
//                                 //                               //width: 100,
//                                 //                               padding:
//                                 //                                   EdgeInsets
//                                 //                                       .all(4.0),
//                                 //                               child:
//                                 //                                   Image.network(
//                                 //                                 'https://mayrasales.com/assets/images/thumbnails/${snapshot.data[0].thumbnail}',
//                                 //                                 fit: BoxFit
//                                 //                                     .fitHeight,
//                                 //                               ),
//                                 //                             ),
//                                 //                           ),
//                                 //                           Flexible(
//                                 //                             child: Padding(
//                                 //                               padding: const EdgeInsets
//                                 //                                       .symmetric(
//                                 //                                   horizontal:
//                                 //                                       10,
//                                 //                                   vertical: 16),
//                                 //                               child: Column(
//                                 //                                 children: <
//                                 //                                     Widget>[
//                                 //                                   Row(
//                                 //                                     children: <
//                                 //                                         Widget>[
//                                 //                                       Flexible(
//                                 //                                         child:
//                                 //                                             Text(
//                                 //                                           AppLocalizations.of(context).translate('str_rs') +
//                                 //                                               snapshot.data[0].price.toString(),
//                                 //                                           overflow:
//                                 //                                               TextOverflow.fade,
//                                 //                                           softWrap:
//                                 //                                               true,
//                                 //                                           style: TextStyle(
//                                 //                                               fontWeight: FontWeight.w600,
//                                 //                                               fontSize: 16),
//                                 //                                         ),
//                                 //                                       ),
//                                 //                                     ],
//                                 //                                   ),
//                                 //                                   //Spacer(),
//                                 //                                   SizedBox(
//                                 //                                       height:
//                                 //                                           8),
//                                 //                                   Row(
//                                 //                                     children: <
//                                 //                                         Widget>[
//                                 //                                       Text(
//                                 //                                         snapshot
//                                 //                                             .data[0]
//                                 //                                             .name,
//                                 //                                         style: TextStyle(
//                                 //                                             fontSize:
//                                 //                                                 16,
//                                 //                                             fontWeight:
//                                 //                                                 FontWeight.w400),
//                                 //                                       )
//                                 //                                     ],
//                                 //                                   ),
//                                 //                                   // Row(
//                                 //                                   //   children: <Widget>[
//                                 //                                   //     Text(
//                                 //                                   //         "Sub Total: "),
//                                 //                                   //     SizedBox(
//                                 //                                   //       width: 5,
//                                 //                                   //     ),
//                                 //                                   //     Text('\$400',
//                                 //                                   //         style:
//                                 //                                   //             TextStyle(
//                                 //                                   //           fontSize:
//                                 //                                   //               16,
//                                 //                                   //           fontWeight:
//                                 //                                   //               FontWeight
//                                 //                                   //                   .w300,
//                                 //                                   //           color: Colors
//                                 //                                   //               .orange,
//                                 //                                   //         ))
//                                 //                                   //   ],
//                                 //                                   // ),
//                                 //                                 ],
//                                 //                               ),
//                                 //                             ),
//                                 //                           )
//                                 //                         ],
//                                 //                       ),
//                                 //                       Divider(),
//                                 //                       _colorChooser(snapshot
//                                 //                           .data[0].color),
//                                 //                       Divider(),
//                                 //                       _sizeChooser(snapshot
//                                 //                           .data[0].size),
//                                 //                       // Text(
//                                 //                       //   "Size Family",
//                                 //                       //   overflow:
//                                 //                       //       TextOverflow.fade,
//                                 //                       //   softWrap: true,
//                                 //                       //   style: TextStyle(
//                                 //                       //     fontWeight:
//                                 //                       //         FontWeight.w400,
//                                 //                       //     fontSize: 14,
//                                 //                       //   ),
//                                 //                       // ),
//                                 //                       // ChipsChoice<int>.single(
//                                 //                       //   value: tag,
//                                 //                       //   options:
//                                 //                       //       ChipsChoiceOption
//                                 //                       //           .listFrom<int,
//                                 //                       //               String>(
//                                 //                       //     source: sizeList,
//                                 //                       //     value: (i, v) => i,
//                                 //                       //     label: (i, v) => v,
//                                 //                       //   ),
//                                 //                       //   onChanged: (val) =>
//                                 //                       //       setState(
//                                 //                       //     () => tag = val,
//                                 //                       //   ),
//                                 //                       // ),
//                                 //                       Flexible(
//                                 //                         fit: FlexFit.loose,
//                                 //                         child: Align(
//                                 //                           alignment: Alignment
//                                 //                               .bottomCenter,
//                                 //                           child: RaisedButton(
//                                 //                             onPressed:
//                                 //                                 () async {
//                                 //                               if (_n != 0) {
//                                 //                                 var userLoggedIn =
//                                 //                                     await UserPreferences
//                                 //                                         .getLoginStatus();
//                                 //                                 if (userLoggedIn) {
//                                 //                                   apiToken =
//                                 //                                       await UserPreferences
//                                 //                                           .getApiToken();
//                                 //                                   // String
//                                 //                                   //     cartURL =
//                                 //                                   //     "https://mayrasales.com/api/user/cart/add?api_token=$apiToken&qty=$_n&size_key="
//                                 //                                   //     "&size_qty="
//                                 //                                   //     "&size_price="
//                                 //                                   //     "&size=$_selectedSize&color=$https://mayrasales.com/api/user/cart/add?api_token=owuqbsczNLufXS86vAxIJkyLPhpCZv5k6yBjoZSxjxMdUWdJ7BSkHDCGaHd2&price=100.0&product_id=8&qty=1&size=M&color=#d32626&stock="
//                                 //                                   //     "&price=${snapshot.data[0].price.toString()}&product_id=${widget.productId}&license&dp";

//                                 //                                   String
//                                 //                                       cartURL =
//                                 //                                       "https://mayrasales.com/api/user/cart/add?api_token=$apiToken&price=${snapshot.data[0].price.toString()}&product_id=${widget.productId}&qty=$_n&size=$_selectedSize&color=$_selectedColor";
//                                 //                                   print(
//                                 //                                       cartURL);

//                                 //                                   var r = await Requests
//                                 //                                       .get(
//                                 //                                           cartURL);
//                                 //                                   r.raiseForStatus();
//                                 //                                   String
//                                 //                                       responseBody =
//                                 //                                       r.content();
//                                 //                                   print(r
//                                 //                                       .headers);
//                                 //                                   print(r
//                                 //                                       .statusCode);
//                                 //                                   print(
//                                 //                                       responseBody);

//                                 //                                   if (r.statusCode ==
//                                 //                                       200) {
//                                 //                                     Flushbar(
//                                 //                                       forwardAnimationCurve:
//                                 //                                           Curves
//                                 //                                               .decelerate,
//                                 //                                       reverseAnimationCurve:
//                                 //                                           Curves
//                                 //                                               .easeOut,
//                                 //                                       message: AppLocalizations.of(
//                                 //                                               context)
//                                 //                                           .translate(
//                                 //                                               'str_add_item_cart_msg'),
//                                 //                                       duration: Duration(
//                                 //                                           seconds:
//                                 //                                               3),
//                                 //                                       margin: EdgeInsets
//                                 //                                           .all(
//                                 //                                               8),
//                                 //                                       borderRadius:
//                                 //                                           8,
//                                 //                                       flushbarStyle:
//                                 //                                           FlushbarStyle
//                                 //                                               .FLOATING,
//                                 //                                       flushbarPosition:
//                                 //                                           FlushbarPosition
//                                 //                                               .TOP,
//                                 //                                       backgroundColor:
//                                 //                                           Hexcolor(
//                                 //                                               "#ff228B22"),
//                                 //                                       mainButton:
//                                 //                                           FlatButton(
//                                 //                                         onPressed:
//                                 //                                             () {
//                                 //                                           Navigator.pop(
//                                 //                                               context);
//                                 //                                           Navigator
//                                 //                                               .push(
//                                 //                                             context,
//                                 //                                             MaterialPageRoute(
//                                 //                                               builder: (context) => Cart(),
//                                 //                                             ),
//                                 //                                           );
//                                 //                                         },
//                                 //                                         child:
//                                 //                                             Text(
//                                 //                                           AppLocalizations.of(context)
//                                 //                                               .translate('str_go_to_cart'),
//                                 //                                           style:
//                                 //                                               TextStyle(color: Colors.white),
//                                 //                                         ),
//                                 //                                       ),
//                                 //                                     )..show(
//                                 //                                         context);
//                                 //                                   }
//                                 //                                 } else {
//                                 //                                   Navigator.pop(
//                                 //                                       context);
//                                 //                                   Navigator
//                                 //                                       .push(
//                                 //                                     context,
//                                 //                                     MaterialPageRoute(
//                                 //                                       builder:
//                                 //                                           (context) =>
//                                 //                                               Login(
//                                 //                                         titlePage:
//                                 //                                             AppLocalizations.of(context).translate('str_user_login'),
//                                 //                                       ),
//                                 //                                     ),
//                                 //                                   );
//                                 //                                 }
//                                 //                               } else {
//                                 //                                 _quantityAlert(
//                                 //                                     context);
//                                 //                               }
//                                 //                             },
//                                 //                             textColor:
//                                 //                                 Colors.white,
//                                 //                             padding:
//                                 //                                 const EdgeInsets
//                                 //                                     .all(0.0),
//                                 //                             shape: RoundedRectangleBorder(
//                                 //                                 borderRadius:
//                                 //                                     BorderRadius
//                                 //                                         .circular(
//                                 //                                             10.0)),
//                                 //                             child: Container(
//                                 //                               width: double
//                                 //                                   .infinity,
//                                 //                               decoration:
//                                 //                                   BoxDecoration(
//                                 //                                 borderRadius:
//                                 //                                     BorderRadius
//                                 //                                         .circular(
//                                 //                                             10.0),
//                                 //                                 gradient:
//                                 //                                     LinearGradient(
//                                 //                                   begin: Alignment
//                                 //                                       .topLeft,
//                                 //                                   end: Alignment
//                                 //                                       .bottomRight,
//                                 //                                   colors: [
//                                 //                                     Hexcolor(
//                                 //                                         "#ffff85b2"),
//                                 //                                     Hexcolor(
//                                 //                                         "#ffa797ff"),
//                                 //                                     Hexcolor(
//                                 //                                         "#ff00e5ff")
//                                 //                                   ],
//                                 //                                 ),
//                                 //                               ),
//                                 //                               padding: const EdgeInsets
//                                 //                                       .symmetric(
//                                 //                                   vertical: 8.0,
//                                 //                                   horizontal:
//                                 //                                       16.0),
//                                 //                               child: Row(
//                                 //                                 mainAxisAlignment:
//                                 //                                     MainAxisAlignment
//                                 //                                         .center,
//                                 //                                 crossAxisAlignment:
//                                 //                                     CrossAxisAlignment
//                                 //                                         .center,
//                                 //                                 mainAxisSize:
//                                 //                                     MainAxisSize
//                                 //                                         .min,
//                                 //                                 children: <
//                                 //                                     Widget>[
//                                 //                                   Text(
//                                 //                                     AppLocalizations.of(
//                                 //                                             context)
//                                 //                                         .translate(
//                                 //                                             'str_add_to_cart'),
//                                 //                                     style: TextStyle(
//                                 //                                         color: Colors
//                                 //                                             .white,
//                                 //                                         fontWeight:
//                                 //                                             FontWeight
//                                 //                                                 .bold,
//                                 //                                         fontSize:
//                                 //                                             16.0),
//                                 //                                   ),
//                                 //                                   const SizedBox(
//                                 //                                       width:
//                                 //                                           4.0),
//                                 //                                   Container(
//                                 //                                     padding:
//                                 //                                         const EdgeInsets.all(
//                                 //                                             8.0),
//                                 //                                     child: Icon(
//                                 //                                       Icons
//                                 //                                           .shopping_cart,
//                                 //                                       color: Colors
//                                 //                                           .white,
//                                 //                                       size:
//                                 //                                           20.0,
//                                 //                                     ),
//                                 //                                     decoration:
//                                 //                                         BoxDecoration(
//                                 //                                       color: Colors
//                                 //                                           .transparent,
//                                 //                                       borderRadius:
//                                 //                                           BorderRadius.circular(
//                                 //                                               10.0),
//                                 //                                     ),
//                                 //                                   )
//                                 //                                 ],
//                                 //                               ),
//                                 //                             ),
//                                 //                           ),
//                                 //                         ),
//                                 //                       ),
//                                 //                     ],
//                                 //                   ),
//                                 //                 );
//                                 //               },
//                                 //             );
//                                 //           },
//                                 //         );
//                                 //       } else {
//                                 //         print("API Request");

//                                 //         if (_n != 0) {
//                                 //           apiToken = await UserPreferences
//                                 //               .getApiToken();
//                                 //           String cartURL =
//                                 //               "https://mayrasales.com/api/user/cart/add?api_token=$apiToken&qty=$_n&size_key&size_qty&size_price&size&color&stock&price=${snapshot.data[0].price.toString()}&product_id=${widget.productId}&license&dp";
//                                 //           print(cartURL);

//                                 //           var r = await Requests.get(cartURL);
//                                 //           r.raiseForStatus();
//                                 //           String responseBody = r.content();
//                                 //           print(r.headers);
//                                 //           print(r.statusCode);
//                                 //           print(responseBody);

//                                 //           if (r.statusCode == 200) {
//                                 //             Flushbar(
//                                 //               forwardAnimationCurve:
//                                 //                   Curves.decelerate,
//                                 //               reverseAnimationCurve:
//                                 //                   Curves.easeOut,
//                                 //               message: AppLocalizations.of(
//                                 //                       context)
//                                 //                   .translate(
//                                 //                       'str_add_item_cart_msg'),
//                                 //               duration: Duration(seconds: 3),
//                                 //               margin: EdgeInsets.all(8),
//                                 //               borderRadius: 8,
//                                 //               flushbarStyle:
//                                 //                   FlushbarStyle.FLOATING,
//                                 //               flushbarPosition:
//                                 //                   FlushbarPosition.TOP,
//                                 //               backgroundColor:
//                                 //                   Hexcolor("#ff228B22"),
//                                 //               mainButton: FlatButton(
//                                 //                 onPressed: () {
//                                 //                   Navigator.pop(context);
//                                 //                   Navigator.push(
//                                 //                     context,
//                                 //                     MaterialPageRoute(
//                                 //                       builder: (context) =>
//                                 //                           Cart(),
//                                 //                     ),
//                                 //                   );
//                                 //                 },
//                                 //                 child: Text(
//                                 //                   AppLocalizations.of(context)
//                                 //                       .translate(
//                                 //                           'str_go_to_cart'),
//                                 //                   style: TextStyle(
//                                 //                       color: Colors.white),
//                                 //                 ),
//                                 //               ),
//                                 //             )..show(context);
//                                 //           }
//                                 //         } else {
//                                 //           _quantityAlert(context);
//                                 //         }
//                                 //       }
//                                 //     }
//                                 //   },
//                                 //   textColor: Colors.white,
//                                 //   padding: const EdgeInsets.all(0.0),
//                                 //   shape: RoundedRectangleBorder(
//                                 //       borderRadius:
//                                 //           BorderRadius.circular(10.0)),
//                                 //   child: Container(
//                                 //     decoration: BoxDecoration(
//                                 //       borderRadius: BorderRadius.circular(10.0),
//                                 //       gradient: LinearGradient(
//                                 //         begin: Alignment.topLeft,
//                                 //         end: Alignment.bottomRight,
//                                 //         colors: [
//                                 //           Hexcolor("#ffff85b2"),
//                                 //           Hexcolor("#ffa797ff"),
//                                 //           Hexcolor("#ff00e5ff")
//                                 //         ],
//                                 //       ),
//                                 //     ),
//                                 //     padding: const EdgeInsets.symmetric(
//                                 //         vertical: 8.0, horizontal: 16.0),
//                                 //     child: Row(
//                                 //       mainAxisSize: MainAxisSize.min,
//                                 //       children: <Widget>[
//                                 //         Text(
//                                 //           AppLocalizations.of(context)
//                                 //               .translate('str_add_to_cart'),
//                                 //           style: TextStyle(
//                                 //               fontWeight: FontWeight.bold,
//                                 //               fontSize: 16.0),
//                                 //         ),
//                                 //         const SizedBox(width: 4.0),
//                                 //         Container(
//                                 //           padding: const EdgeInsets.all(8.0),
//                                 //           child: Icon(
//                                 //             Icons.shopping_cart,
//                                 //             color: Colors.white,
//                                 //             size: 20.0,
//                                 //           ),
//                                 //           decoration: BoxDecoration(
//                                 //             color: Colors.transparent,
//                                 //             borderRadius:
//                                 //                 BorderRadius.circular(10.0),
//                                 //           ),
//                                 //         )
//                                 //       ],
//                                 //     ),
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                           ),

//                           // Container(
//                           //   padding: EdgeInsets.all(16),
//                           //   child: Table(
//                           //     children: [
//                           //       TableRow(children: [
//                           //         TableCell(
//                           //           child: Row(
//                           //             mainAxisAlignment: MainAxisAlignment.start,
//                           //             children: <Widget>[
//                           //               Text(
//                           //                 "Brand",
//                           //                 style: TextStyle(),
//                           //               ),
//                           //               Flexible(
//                           //                 child: Container(
//                           //                   padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
//                           //                   child: Text(
//                           //                     "MI",
//                           //                     softWrap: true,
//                           //                   ),
//                           //                 ),
//                           //               ),
//                           //             ],
//                           //           ),
//                           //         ),
//                           //       ]),
//                           //     ],
//                           //   ),
//                           // ),

//                           Container(
//                             margin:
//                                 const EdgeInsets.only(top: 4.0, bottom: 0.0),
//                             height: 0.5,
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                                 colors: [
//                                   Hexcolor("#ffff85b2"),
//                                   Hexcolor("#ffa797ff"),
//                                   Hexcolor("#ff00e5ff")
//                                 ],
//                               ),
//                             ),
//                           ),
//                           _colorVariant(),

//                           _sizeVariant(),
//                           ExpansionTile(
//                             title: Text(
//                               AppLocalizations.of(context)
//                                   .translate('str_color_variant'),
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 fontWeight: FontWeight.w500,
//                                 color: Hexcolor('#ffa797ff'),
//                               ),
//                             ),
//                             children: <Widget>[
//                               ListTile(
//                                 title: Text('data'),
//                               )
//                             ],
//                             onExpansionChanged: (bool expanding) =>
//                                 setState(() => this.isExpanded = expanding),
//                           ),

//                           ExpansionTile(
//                             title: Text(
//                               AppLocalizations.of(context)
//                                   .translate('str_size_variant'),
//                               style: TextStyle(
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.w500,
//                                   color: Hexcolor('#ffa797ff')),
//                             ),
//                             children: <Widget>[
//                               ListTile(
//                                 title: Text('data'),
//                               )
//                             ],
//                           ),
//                           ExpansionTile(
//                             title: Text(
//                               AppLocalizations.of(context)
//                                   .translate('str_product_specification'),
//                               style: TextStyle(
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.w500,
//                                   color: Hexcolor('#ffa797ff')),
//                             ),
//                             children: <Widget>[
//                               new Container(
//                                 padding: EdgeInsets.fromLTRB(16, 0, 16, 4),
//                                 child: Text(
//                                   "Mi 10 [8GB RAM // 256GB ROM] - 108MP Quad Camera with OIS",
//                                   softWrap: true,
//                                   style: new TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 14.0,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),

//                           ExpansionTile(
//                             title: Text(
//                               AppLocalizations.of(context)
//                                   .translate('str_product_description'),
//                               style: TextStyle(
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.w500,
//                                   color: Hexcolor('#ffa797ff')),
//                             ),
//                             children: <Widget>[
//                               Container(
//                                 padding: EdgeInsets.only(
//                                     bottom: 8, left: 16, right: 8),
//                                 child: Align(
//                                   alignment: Alignment.topLeft,
//                                   // child: RichText(
//                                   //   text: TextSpan(
//                                   //     text: "${snapshot.data[0].details}",
//                                   //     style: TextStyle(
//                                   //       color: Colors.black,
//                                   //       //fontWeight: FontWeight.bold,
//                                   //     ),
//                                   //   ),
//                                   // ),
//                                   // child: Html(
//                                   //   data: snapshot.data[0].details,
//                                   // ),
//                                 ),
//                               ),
//                             ],
//                           ),

//                           ExpansionTile(
//                             title: Text(
//                               AppLocalizations.of(context)
//                                   .translate('str_seller_info'),
//                               style: TextStyle(
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.w500,
//                                   color: Hexcolor('#ffa797ff')),
//                             ),
//                             children: <Widget>[
//                               // ListTile(
//                               //   title: Text('data'),
//                               // ),
//                               _sellerInfo(context, snapshot.data[0]),
//                             ],
//                           ),

//                           ExpansionTile(
//                             title: Text(
//                               AppLocalizations.of(context)
//                                   .translate('str_contact_details'),
//                               style: TextStyle(
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.w500,
//                                   color: Hexcolor('#ffa797ff')),
//                             ),
//                             children: <Widget>[
//                               // ListTile(
//                               //   title: Text('Contact Number'),
//                               //   subtitle: Text(snapshot.data[0].phone),
//                               // )
//                               _contactDetails(context, snapshot.data[0]),

//                               _addDetails(context, snapshot.data[0]),
//                             ],
//                           ),

//                         ],
//                       ),
//                     ),
//                   ),

//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   _colorVariant(){
//     if ((snapshot.data[0].color != null) ||
//                                         (snapshot.data[0].size != null)) {
//                                       //if (snapshot.data[0].size != null) {}
//                                       if ((snapshot.data[0].color != "") ||
//                                           (snapshot.data[0].size != "")) {
//   }

//   _quantityAlert(BuildContext context) {
//     return Flushbar(
//         title: AppLocalizations.of(context).translate('str_invalid_quantity'),
//         forwardAnimationCurve: Curves.decelerate,
//         reverseAnimationCurve: Curves.easeOut,
//         message:
//             AppLocalizations.of(context).translate('str_select_quantity_msg'),
//         duration: Duration(seconds: 2),
//         margin: EdgeInsets.all(8),
//         borderRadius: 8,
//         flushbarStyle: FlushbarStyle.FLOATING,
//         flushbarPosition: FlushbarPosition.TOP,
//         backgroundColor: Colors.redAccent)
//       ..show(context);
//   }

//   _colorChooser(List<dynamic> colors) {
//     if (colors != null) {
//       var sL = colors;
//       colorList = List<String>.from(sL);
//       return StatefulBuilder(
//         builder: (BuildContext context, StateSetter setState) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(
//                 AppLocalizations.of(context).translate('str_color_family'),
//                 overflow: TextOverflow.fade,
//                 softWrap: true,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14,
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.only(left: 12.0, right: 0.0),
//                 height: 50,
//                 child: new ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: colorList.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       padding: EdgeInsets.only(right: 8),
//                       child: FilterChip(
//                         backgroundColor: Hexcolor(
//                             "#ff${colorList[index].replaceAll("#", "")}"),
//                         selectedColor: Hexcolor(
//                             "#ff${colorList[index].replaceAll("#", "")}"),
//                         checkmarkColor: Colors.white,
//                         label: Text(
//                           "C",
//                           style: TextStyle(
//                               color: Hexcolor(
//                                   "#ff${colorList[index].replaceAll("#", "")}")),
//                         ),
//                         selected: _selectedColor == colorList[index],
//                         onSelected: (selected) {
//                           setState(
//                             () {
//                               _selectedColor = colorList[index];

//                               print(_selectedColor);
//                             },
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   _sizeChooser(List<dynamic> options) {
//     if (options != null) {
//       //var tag;
//       var sL = options;
//       sizeList = List<String>.from(sL);
//       return StatefulBuilder(
//         builder: (BuildContext context, StateSetter setState) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(
//                 AppLocalizations.of(context).translate('str_size_family'),
//                 overflow: TextOverflow.fade,
//                 softWrap: true,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14,
//                 ),
//               ),
//               ChipsChoice<int>.single(
//                 //itemConfig: Chips,
//                 value: tag,
//                 options: ChipsChoiceOption.listFrom<int, String>(
//                   source: sizeList,
//                   value: (i, v) => i,
//                   label: (i, v) => v,
//                 ),
//                 onChanged: (val) => setState(() {
//                   tag = val;
//                   _selectedSize = sizeList[tag];
//                   print("Tag ================= ${_selectedSize}");
//                 }),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   _sellerInfo(BuildContext context, Detail details) {
//     // if (details.phone != null) {
//     //   return ListTile(
//     //     title: Text('Contact Number'),
//     //     subtitle: Text(details.phone),
//     //   );
//     // } else {
//     //   return ListTile(
//     //     title: Text('Contact Number'),
//     //     subtitle: Text('-'),
//     //   );
//     // }

//     return Column(
//       children: [
//         ListTile(
//           title: Text(AppLocalizations.of(context).translate('str_shop_name')),
//           subtitle: Text(details.shopName),
//         ),
//         ListTile(
//           title: Text(AppLocalizations.of(context).translate('str_owner_name')),
//           subtitle: Text(details.ownerName),
//         ),
//         ListTile(
//           title:
//               Text(AppLocalizations.of(context).translate('str_shop_number')),
//           subtitle: Text(details.shopNumber),
//         ),
//       ],
//     );
//   }

//   _contactDetails(BuildContext context, Detail details) {
//     if (details.phone != null) {
//       return ListTile(
//         title:
//             Text(AppLocalizations.of(context).translate('str_contact_number')),
//         subtitle: Text(details.phone),
//       );
//     } else {
//       return ListTile(
//         title:
//             Text(AppLocalizations.of(context).translate('str_contact_number')),
//         subtitle: Text('-'),
//       );
//     }
//   }

//   _addDetails(BuildContext context, Detail details) {
//     if (details.shopAddress != null) {
//       return ListTile(
//         title: Text(AppLocalizations.of(context).translate('str_address')),
//         subtitle: Text(details.shopAddress),
//       );
//     } else {
//       return ListTile(
//         title: Text(AppLocalizations.of(context).translate('str_address')),
//         subtitle: Text('-'),
//       );
//     }
//   }

//   Size screenSize(BuildContext context) {
//     return MediaQuery.of(context).size;
//   }

//   Widget _buildAddToCartButton() {
//     return Row(
//       children: <Widget>[
//         Expanded(
//           child: Container(
//             color: Colors.transparent,
//             padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//             child: RaisedButton(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(40.0)),
//               onPressed: () {},
//               child: Text("Add to Cart"),
//               color: Colors.orange,
//               textColor: Colors.white,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
