import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/model/orders_model.dart';
import 'package:mayrasales/model/userpreferences.dart';
import 'package:mayrasales/view/order_details.dart';
import 'package:mayrasales/view/order_details_screen.dart';
import 'package:mayrasales/widgets/rounded_bordered_container.dart';
import 'package:mayrasales/widgets/widgets.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:requests/requests.dart';
import 'package:intl/intl.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<OrdersModel> fOrderLists;

  String formatDate(DateTime date) =>
      new DateFormat("MMM d, yyyy  hh:mm a").format(date);

  final numberFormatter = new NumberFormat("##,##,###");

  int totalQuantity = 0;

  // get http => null;

  void initState() {
    super.initState();
    // _fetchProductDetails();

    fOrderLists = _getOrderList();
  }

  // Future<OrdersModel> _getOrderList() async {
  //   String apiToken = await UserPreferences.getApiToken();
  //   try {
  //     String getOrdersURL =
  //         "https://mayrasales.com/api/user/user_orders?api_token=$apiToken";
  //     print(getOrdersURL);
  //     var r = await Requests.get(getOrdersURL);
  //     r.raiseForStatus();
  //     var responseBody = r.content();

  //     OrdersModel orders = ordersModelFromJson(responseBody);

  //     //if (orders.status == "success") {
  //     print(orders);

  //     return orders;
  //   } on HttpException catch (error) {
  //     print(error.toString());
  //   } catch (error) {
  //     print(error);
  //   }
  // }
  Future<OrdersModel> _getOrderList() async {
    String token = await UserPreferences.getToken();

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://mayrasales.com/api/user/user_orders'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());

      var responseBody = await response.stream.bytesToString();

      // print(responseBody);

      var jsonResponse = json.decode(responseBody);

      if (jsonResponse["status"] == "success") {
        OrdersModel userOrder = ordersModelFromJson(responseBody);
        // print('Data featched');
        // print('success');

        var tQty = 0;

        for (int a = 0; a < userOrder.details.length; a++) {
          for (int b = 0; b < userOrder.details[a].cart.length; b++) {
            tQty = tQty + userOrder.details[a].cart[b].qty;
          }
        }
        setState(() {
          totalQuantity = tQty;
        });

        print('$userOrder');

        return userOrder;
      } else {
        return null;
      }
    } else {
      print(response.reasonPhrase);
    }
    return null;
  }

  Widget build(BuildContext context) {
    //print(_cart);
    return Scaffold(
      // debugShowCheckedModeBanner: false,
      // home: Home(),
      key: _scaffoldKey,
      appBar: buildAppBar(
          context, AppLocalizations.of(context).translate('str_my_orders')),
      body: FutureBuilder(
        future: fOrderLists,
        builder: (BuildContext context, AsyncSnapshot<OrdersModel> snapshot) {
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
                return Text(snapshot.error.toString());
              } else {
                if (snapshot.data != null) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    child: ListView.builder(
                      itemCount: snapshot.data.details.length,
                      itemBuilder: (context, int index) {
                        return GestureDetector(
                          onTap: () {
                            print('order details');
                            // var orderDetail = snapshot.data.details[index];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetailScreen(
                                  orderId:
                                      snapshot.data.details[index].orderNumber,
                                  orderDetails: snapshot.data.details[index],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.only(
                              bottom: 16.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 8.0,
                                    left: 16.0,
                                    right: 16.0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot
                                            .data.details[index].orderNumber,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17.0),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            formatDate(snapshot
                                                .data.details[index].createdAt
                                                .toLocal()),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15.0),
                                          ),
                                          Text(
                                            snapshot.data.details[index].status
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: kGradientPrimary,
                                ),
                                // SizedBox(
                                //   height: 8.0,
                                // ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    // right: 16.0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Ordered Products",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: snapshot
                                            .data.details[index].cart.length,
                                        itemBuilder: (context, int ind) {
                                          return RoundedContainer(
                                            padding: const EdgeInsets.all(0),
                                            // margin: EdgeInsets.all(10),
                                            // height: 70,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  width: 70,
                                                  height: 70,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          'https://mayrasales.com/assets/images/thumbnails/${snapshot.data.details[index].cart[ind].productDetails.thumbnail}'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    // color: kGradientPrimary,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16.0,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        // Flexible(
                                                        //   child:
                                                        Text(
                                                          '${snapshot.data.details[index].cart[ind].productDetails.name}',
                                                          overflow:
                                                              TextOverflow.fade,
                                                          softWrap: true,
                                                          // maxLines: 2,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                        Text(
                                                          "Rs. " +
                                                              numberFormatter
                                                                  .format(snapshot
                                                                      .data
                                                                      .details[
                                                                          index]
                                                                      .cart[ind]
                                                                      .productDetails
                                                                      .price)
                                                                  .toString(),
                                                          overflow:
                                                              TextOverflow.fade,
                                                          softWrap: true,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16),
                                                        ),

                                                        Text(
                                                          "x ${snapshot.data.details[index].cart[ind].qty}",
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          textAlign:
                                                              TextAlign.end,
                                                        ),
                                                        //),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: kGradientPrimary,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    // right: 16.0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // TextButton(
                                          //   onPressed: () {
                                          //     print('a');
                                          //     Navigator.push(
                                          //       context,
                                          //       MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             OrderDetailScreen(
                                          //           orderId: snapshot
                                          //               .data
                                          //               .details[index]
                                          //               .orderNumber,
                                          //         ),
                                          //       ),
                                          //     );
                                          //   },
                                          //   child: Text(
                                          //     'View Details',
                                          //     style: TextStyle(
                                          //       color: Colors.grey,
                                          //       fontSize: 15.0,
                                          //     ),
                                          //   ),
                                          // ),
                                          Text(
                                            "Total Price: Rs." +
                                                numberFormatter
                                                    .format(snapshot
                                                        .data
                                                        .details[index]
                                                        .payAmount)
                                                    .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: kTextColor,
                                                fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),

                                // customDivider(1),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Text(
                      'No order found.',
                      style: notFoundTextStyle,
                      //textAlign: TextAlign.center,
                    ),
                  );
                }
              }
          }
        },
      ),
    );
  }

  _updateQty(int qty) {
    setState(() {
      totalQuantity = totalQuantity + qty;
    });
  }
}
