import 'package:flutter/material.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';
import 'package:mayrasales/model/userpreferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mayrasales/model/vendor_order_screen_model.dart';

class VendorOrderScreen extends StatefulWidget {
  const VendorOrderScreen({Key key}) : super(key: key);

  @override
  _VendorOrderScreenState createState() => _VendorOrderScreenState();
}

class _VendorOrderScreenState extends State<VendorOrderScreen> {
  Future<VendorOrderModel> vendorOrders;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    vendorOrders = _getOrderList();
  }

  Future<VendorOrderModel> _getOrderList() async {
    String token = await UserPreferences.getToken();

    // print('$token');

    var headers = {
      'Authorization': 'Bearer $token',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6InFRbWJCU1ZwYXlGT0ZjeTU5OFNNVWc9PSIsInZhbHVlIjoiVlZIc2JnbjduUE5Oa2ZwWTYxZHA0dTJMajBmOGZNSTdHUzhjYy9ob2JZRzRmcTVjYWo3cjFoVUJ2Ri8wKzZFRm9HQmhPK21LN2hFbHFsYW9ja2c2V0xxR2tPeUdoeW5idy9abUh6MTdrN3BFOGVBaEdZdnVlcDQ2K0xUNWgyQTAiLCJtYWMiOiJjYWMwZmJhYjkyZmQzN2M1MWQ1ODU2ZmJhYWY2NjNhYjZiOWI5MmFmY2E2YWY0NDBkNDA4OTgyMDc1ZjY3MTkyIn0%3D; laravel_session=eyJpdiI6IlhHV0RndG8vSHhoR1JKVlBBajdvMlE9PSIsInZhbHVlIjoiSnovN3VwT3RUSVdOREpFZXRvOXdLdjB4SldLeEFXbFE4TVBNUUNwTDl4TVZqQlJROTBzeVpjeExYQ3pqTmU4ZUQ3VjVlMStjV0FZZStxQjMzcDQzQVdXcnArVHdsYytFemljTDRFcVdBVEZQcEFXWEdubVdPQzcyL0Q2Q1Y0RTUiLCJtYWMiOiJiZjZhNjAzZTYxNGQyYjE3YTA0ZGM0ZDBkNjRmODE4YjIzYmIyNzc1ZTI1Y2Q3YTI1MjhhMDgzNjM3ODM3M2VhIn0%3D'
    };
    var request = http.Request(
        'GET', Uri.parse('https://mayrasales.com/api/vendor/orders'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      // print(responseBody);

      var jsonResponse = json.decode(responseBody);

      if (jsonResponse["status"] == "success") {
        VendorOrderModel vendorOrder = vendorOrderModelFromJson(responseBody);

        print('$vendorOrder');
        return vendorOrder;
      }
    } else {
      print(response.reasonPhrase);
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Vendor Order Screen'),
      // ),
      appBar: AppBar(
        title: Text(
          'Vendor Order Screen',
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
      ),
      body: FutureBuilder(
        future: vendorOrders,
        builder:
            (BuildContext context, AsyncSnapshot<VendorOrderModel> snapshot) {
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
            // default : return Text('');
            default:
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                if (snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data.details.length,
                    // itemCount: 5,
                    itemBuilder: (context, int index) {
                      // return Text('check ${snapshot.data.details.length}');
                      return Container(
                        // color: Colors.red,
                        padding: EdgeInsets.only(
                          left: 12.0,
                          top: 12.0,
                          right: 12.0,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order Number',
                                  style: appTextStyle(
                                    FontWeight.w500,
                                    16.0,
                                    kTextColor,
                                  ),
                                ),
                                Text(
                                  '${snapshot.data.details[index].orderNumber}',
                                  style: appTextStyle(
                                    FontWeight.w500,
                                    16.0,
                                    kTextColor,
                                  ),
                                ),
                                // Text('check'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Quantity',
                                  style: appTextStyle(
                                    FontWeight.w500,
                                    16.0,
                                    kTextColor,
                                  ),
                                ),
                                Text(
                                  '${snapshot.data.details[index].qty}',
                                  style: appTextStyle(
                                    FontWeight.w500,
                                    16.0,
                                    kTextColor,
                                  ),
                                ),
                                // Text('check'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Cost',
                                  style: appTextStyle(
                                    FontWeight.w500,
                                    16.0,
                                    kTextColor,
                                  ),
                                ),
                                Text(
                                  'Rs. ${snapshot.data.details[index].price}',
                                  style: appTextStyle(
                                    FontWeight.w500,
                                    16.0,
                                    kTextColor,
                                  ),
                                ),
                                // Text('check'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Message',
                                  style: appTextStyle(
                                    FontWeight.w500,
                                    16.0,
                                    kTextColor,
                                  ),
                                ),
                                Text(
                                  'Message',
                                  style: appTextStyle(
                                    FontWeight.w500,
                                    16.0,
                                    kTextColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Payment Method',
                                  style: appTextStyle(
                                    FontWeight.w500,
                                    16.0,
                                    kTextColor,
                                  ),
                                ),
                                Text(
                                  'Payment Method',
                                  style: appTextStyle(
                                    FontWeight.w500,
                                    16.0,
                                    kTextColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Actions',
                                  style: appTextStyle(
                                    FontWeight.w500,
                                    16.0,
                                    kTextColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Details',
                                      style: appTextStyle(
                                        FontWeight.w500,
                                        16.0,
                                        kTextColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'Processing',
                                      style: appTextStyle(
                                        FontWeight.w500,
                                        16.0,
                                        kTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              height: 20.0,
                              thickness: 1.5,
                            ),
                          ],
                        ),
                      );
                    },
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
      // ListView(
      //   padding: EdgeInsets.only(
      //     left: 12.0,
      //     right: 12.0,
      //   ),
      //   children: [
      //     SizedBox(
      //       height: 20.0,
      //     ),
      //     Container(
      //       // color: Colors.red,
      //       child: Column(
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text('Order Number'),
      //               Text('ksdfjkdslfjlsdfk'),
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text('Total Quantity'),
      //               Text('1'),
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text('Total Cost'),
      //               Text('Rs. 10000'),
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text('Message'),
      //               Text('Message'),
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text('Payment Method'),
      //               Text('ksdfjkdslfjlsdfk'),
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text('Actions'),
      //               Row(
      //                 children: [
      //                   Text('Details'),
      //                   SizedBox(
      //                     width: 10.0,
      //                   ),
      //                   Text('Processing'),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //     Divider(
      //       height: 20.0,
      //       thickness: 2.0,
      //     ),
      //     Container(
      //       // color: Colors.red,
      //       child: Column(
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text('Order Number'),
      //               Text('ksdfjkdslfjlsdfk'),
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text('Total Quantity'),
      //               Text('1'),
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text('Total Cost'),
      //               Text('Rs. 10000'),
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text('Message'),
      //               Text('Message'),
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text('Payment Method'),
      //               Text('ksdfjkdslfjlsdfk'),
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text('Actions'),
      //               Row(
      //                 children: [
      //                   Text('Details'),
      //                   SizedBox(
      //                     width: 10.0,
      //                   ),
      //                   Text('Processing'),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //     Divider(
      //       height: 20.0,
      //       thickness: 2.0,
      //     ),
      //     Container(
      //       // color: Colors.red,
      //       child: Column(
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text('Order Number'),
      //               Text('ksdfjkdslfjlsdfk'),
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text('Total Quantity'),
      //               Text('1'),
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text('Total Cost'),
      //               Text('Rs. 10000'),
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text('Message'),
      //               Text('Message'),
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text('Payment Method'),
      //               Text('ksdfjkdslfjlsdfk'),
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text('Actions'),
      //               Row(
      //                 children: [
      //                   Text('Details'),
      //                   SizedBox(
      //                     width: 10.0,
      //                   ),
      //                   Text('Processing'),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
