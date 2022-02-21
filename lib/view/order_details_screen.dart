import 'package:flutter/material.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/widgets/rounded_bordered_container.dart';
// import 'package:mayrasales/view/order_details.dart';
import 'package:mayrasales/widgets/widgets.dart';
import 'package:mayrasales/model/orders_model.dart';
// import 'package:car_rental/constants.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;
  final Detail orderDetails;

  OrderDetailScreen({
    @required this.orderId,
    @required this.orderDetails,
  });

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  // int _currentImage = 0;

  String formatDate(DateTime date) =>
      new DateFormat("MMM d, yyyy  hh:mm a").format(date);

  final numberFormatter = new NumberFormat("##,##,###");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: buildAppBar(
        context,
        widget.orderId,
      ),
      body: SingleChildScrollView(
        // width: double.infinity,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 4.0),
              child: Card(
                elevation: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).translate('str_ship_to'),
                        style: TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        widget.orderDetails.customerName,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        widget.orderDetails.shippingAddress,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        "${AppLocalizations.of(context).translate('str_contact_number')}: ${widget.orderDetails.shippingPhone}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 4.0),
              child: Card(
                elevation: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            // "${AppLocalizations.of(context).translate('str_item')}: ${widget.orderDetails.totalQty}",
                            '',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            widget.orderDetails.status.toUpperCase(),
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        widget.orderDetails.cart[0].vendorDetails.name,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.0,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        "${AppLocalizations.of(context).translate('str_ordered_date')}: ${formatDate(widget.orderDetails.createdAt)}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.orderDetails.cart.length,
                        itemBuilder: (context, int ind) {
                          //shippingCost = widget.orderDetails.cart[ind].productDetails.s
                          return RoundedContainer(
                            padding: const EdgeInsets.all(0),
                            margin: EdgeInsets.all(10),
                            //height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://mayrasales.com/assets/images/thumbnails/${widget.orderDetails.cart[ind].productDetails.thumbnail}'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            // Flexible(
                                            //   child:
                                            Text(
                                              widget.orderDetails.cart[ind]
                                                      .productDetails.name +
                                                  widget.orderDetails.cart[ind]
                                                      .productDetails.name,
                                              overflow: TextOverflow.fade,
                                              softWrap: true,
                                              //maxLines: 2,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              "${AppLocalizations.of(context).translate('str_rs')} " +
                                                  numberFormatter
                                                      .format(widget
                                                          .orderDetails
                                                          .cart[ind]
                                                          .productDetails
                                                          .price)
                                                      .toString(),
                                              overflow: TextOverflow.fade,
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16),
                                            ),

                                            Text(
                                              "x ${widget.orderDetails.cart[ind].qty}",
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.black54,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.end,
                                            ),
                                            //),
                                          ],
                                        ),
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
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   padding: EdgeInsets.only(bottom: 8.0),
            //   child: Card(
            //     elevation: 0.0,
            //     child: Padding(
            //       padding: EdgeInsets.all(8.0),
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           Text(
            //             "${AppLocalizations.of(context).translate('str_order')} # ${widget.orderDetails.orderNumber}",
            //             style: TextStyle(
            //               color: Colors.black87,
            //               fontWeight: FontWeight.w500,
            //               fontSize: 18.0,
            //             ),
            //           ),
            //           SizedBox(height: 2.0),
            //           Text(
            //             "${AppLocalizations.of(context).translate('str_placed_on')}",
            //             style: TextStyle(
            //               color: Colors.black54,
            //               fontWeight: FontWeight.w400,
            //               fontSize: 13.0,
            //             ),
            //           ),
            //           SizedBox(height: 2.0),
            //           Text(
            //             "${AppLocalizations.of(context).translate('str_paid_on')}",
            //             style: TextStyle(
            //               color: Colors.black54,
            //               fontSize: 13.0,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 8.0),
              child: Card(
                elevation: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate('str_sub_total'),
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            "${AppLocalizations.of(context).translate('str_rs')} ${numberFormatter.format(widget.orderDetails.payAmount).toString()}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate('str_shipping_fee'),
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "${AppLocalizations.of(context).translate('str_rs')}. ${numberFormatter.format(widget.orderDetails.shippingCost).toString()}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      customDivider(0.5),
                      SizedBox(height: 4.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .translate('str_total'),
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              "${AppLocalizations.of(context).translate('str_rs')} ${numberFormatter.format(widget.orderDetails.payAmount).toString()}",
                              style: TextStyle(
                                color: kPriceColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.0),
                      customDivider(0.5),
                      SizedBox(height: 4.0),
                      _paymentView(widget.orderDetails.paymentStatus),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Align(
                      //     alignment: Alignment.bottomCenter,
                      //     child: RaisedButton(
                      //       onPressed: () async {},
                      //       textColor: Colors.white,
                      //       padding: const EdgeInsets.all(0.0),
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10.0)),
                      //       child: Container(
                      //         width: double.infinity,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(10.0),
                      //           gradient: LinearGradient(
                      //             begin: Alignment.topLeft,
                      //             end: Alignment.bottomRight,
                      //             colors: [
                      //               kGradientPrimary,
                      //               kGradientSecondary,
                      //               kGradientTertiary,
                      //             ],
                      //           ),
                      //         ),
                      //         padding: const EdgeInsets.symmetric(
                      //             vertical: 8.0, horizontal: 16.0),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           crossAxisAlignment: CrossAxisAlignment.center,
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: <Widget>[
                      //             Text(
                      //               AppLocalizations.of(context)
                      //                   .translate('str_message_us'),
                      //               style: TextStyle(
                      //                   color: Colors.white,
                      //                   fontWeight: FontWeight.bold,
                      //                   fontSize: 16.0),
                      //             ),
                      //             const SizedBox(width: 4.0),
                      //             Container(
                      //               padding: const EdgeInsets.all(8.0),
                      //               child: Icon(
                      //                 Icons.message,
                      //                 color: Colors.white,
                      //                 size: 20.0,
                      //               ),
                      //               decoration: BoxDecoration(
                      //                 color: Colors.transparent,
                      //                 borderRadius: BorderRadius.circular(10.0),
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _paymentView(String ps) {
    if (ps == "Pending") {
      return Text(
        "Cash On Delivery",
        style: TextStyle(
          color: kLogoPurple,
          fontWeight: FontWeight.w600,
          fontSize: 14.0,
        ),
      );
    }
  }
}
