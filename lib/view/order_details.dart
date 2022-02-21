import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/main.dart';
import 'package:mayrasales/model/orders_model.dart';
import 'package:mayrasales/view/changepassword.dart';
import 'package:mayrasales/widgets/rounded_bordered_container.dart';
import 'package:mayrasales/widgets/widgets.dart';
// import 'package:smart_select/smart_select.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatefulWidget {
  // final Detail order;

  const OrderDetails({
    Key key,
    //  this.order
  }) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  //bool _dark;
  String formatDate(DateTime date) =>
      new DateFormat("MMM d, yyyy  hh:mm:ss").format(date);

  final numberFormatter = new NumberFormat("##,##,###");

  int shippingCost = 0;
  @override
  void initState() {
    super.initState();
    //_dark = false;
  }

  @override
  Widget build(BuildContext context) {
    // print("widget.order.customerEmail" + widget.order.customerEmail);
    return Scaffold(
      //backgroundColor: _dark ? null : Colors.grey.shade200,
      appBar: buildAppBar(
          context, AppLocalizations.of(context).translate('str_order_details')),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            //padding: const EdgeInsets.only(bottom: 4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.loose,
                  child: ConstrainedBox(
                    constraints: new BoxConstraints(
                      minHeight: 50.0,
                    ),
                    child: Container(
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
                                AppLocalizations.of(context)
                                    .translate('str_ship_to'),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                // widget.order.customerName,
                                'customer name',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                // widget.order.shippingAddress,
                                'shipping address',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                // "${AppLocalizations.of(context).translate('str_contact_number')}: ${widget.order.shippingPhone}",
                                'phone no',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: ConstrainedBox(
                    constraints: new BoxConstraints(
                      minHeight: 100.0,
                    ),
                    child: Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    // "${AppLocalizations.of(context).translate('str_item')}: ${widget.order.totalQty}",
                                    'qty',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    // widget.order.status.toUpperCase(),
                                    'status',
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
                                // widget.order.cart[0].vendorDetails.name,
                                'vendor name',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13.0,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                // "${AppLocalizations.of(context).translate('str_ordered_date')}: ${formatDate(widget.order.createdAt)}",
                                'ordered date',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13.0,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                // itemCount: widget.order.cart.length,
                                itemBuilder: (context, int ind) {
                                  //shippingCost = widget.order.cart[ind].productDetails.s
                                  return RoundedContainer(
                                    padding: const EdgeInsets.all(0),
                                    margin: EdgeInsets.all(10),
                                    //height: 70,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              // image: DecorationImage(
                                              //   image: NetworkImage(
                                              //       'https://mayrasales.com/assets/images/thumbnails/${widget.order.cart[ind].productDetails.thumbnail}'),
                                              //   fit: BoxFit.cover,
                                              // ),
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    // Flexible(
                                                    //   child:
                                                    // Text(
                                                    //   widget
                                                    //           .order
                                                    //           .cart[ind]
                                                    //           .productDetails
                                                    //           .name +
                                                    //       widget
                                                    //           .order
                                                    //           .cart[ind]
                                                    //           .productDetails
                                                    //           .name,
                                                    //   overflow:
                                                    //       TextOverflow.fade,
                                                    //   softWrap: true,
                                                    //   //maxLines: 2,
                                                    //   style: TextStyle(
                                                    //     fontWeight:
                                                    //         FontWeight.w400,
                                                    //     fontSize: 14,
                                                    //   ),
                                                    //   textAlign:
                                                    //       TextAlign.start,
                                                    // ),
                                                    // Text(
                                                    //   "${AppLocalizations.of(context).translate('str_rs')}. " +
                                                    //       numberFormatter
                                                    //           .format(widget
                                                    //               .order
                                                    //               .cart[ind]
                                                    //               .productDetails
                                                    //               .price)
                                                    //           .toString(),
                                                    //   overflow:
                                                    //       TextOverflow.fade,
                                                    //   softWrap: true,
                                                    //   style: TextStyle(
                                                    //       fontWeight:
                                                    //           FontWeight.w600,
                                                    //       fontSize: 16),
                                                    // ),

                                                    // Text(
                                                    //   "x ${widget.order.cart[ind].qty}",
                                                    //   style: TextStyle(
                                                    //       fontStyle:
                                                    //           FontStyle.italic,
                                                    //       color: Colors.grey,
                                                    //       fontSize: 14.0,
                                                    //       fontWeight:
                                                    //           FontWeight.w500),
                                                    //   textAlign: TextAlign.end,
                                                    // ),
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
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: ConstrainedBox(
                    constraints: new BoxConstraints(
                      minHeight: 50.0,
                    ),
                    child: Container(
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
                              Text(
                                // "${AppLocalizations.of(context).translate('str_order')} # ${widget.order.orderNumber}",
                                'oreder no',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                "${AppLocalizations.of(context).translate('str_placed_on')}",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.0,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                "${AppLocalizations.of(context).translate('str_paid_on')}",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: ConstrainedBox(
                    constraints: new BoxConstraints(
                      minHeight: 50.0,
                    ),
                    child: Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate('str_sub_total'),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  SizedBox(height: 16.0),
                                  Text(
                                    // "${AppLocalizations.of(context).translate('str_rs')}. ${numberFormatter.format(widget.order.payAmount).toString()}",
                                    'payment amount',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate('str_shipping_fee'),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    // "${AppLocalizations.of(context).translate('str_rs')}. ${numberFormatter.format(widget.order.shippingCost).toString()}",
                                    'shipping cost',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: ConstrainedBox(
                    constraints: new BoxConstraints(
                      minHeight: 50.0,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: 4.0),
                      child: Card(
                        elevation: 0.0,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(height: 2.0),
                              Text(
                                "3 ${AppLocalizations.of(context).translate('str_items')}",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.0,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                // "${AppLocalizations.of(context).translate('str_total')}: ${AppLocalizations.of(context).translate('str_rs')}. ${numberFormatter.format(widget.order.payAmount).toString()}",
                                'total rs ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              // Text(
                              //   "Paid By: Rs. 121212",
                              //   style: TextStyle(
                              //     color: Colors.grey,
                              //     fontWeight: FontWeight.w400,
                              //     fontSize: 13.0,
                              //   ),
                              // ),
                              // _paymentView(widget.order.paymentStatus),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton(
                        onPressed: () async {},
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xffff85b2),
                                Color(0xffa797ff),
                                Color(0xff00e5ff)
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .translate('str_message_us'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                              const SizedBox(width: 4.0),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.message,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _paymentView(String ps) {
    if (ps == "Pending") {
      return Text(
        "Cash On Delivery",
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w400,
          fontSize: 13.0,
        ),
      );
    }
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
