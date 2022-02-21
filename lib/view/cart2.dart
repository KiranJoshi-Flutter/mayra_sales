import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mayrasales/model/cart_model.dart';
import 'dart:async';
import 'dart:convert';

import 'package:mayrasales/model/userpreferences.dart';
import 'package:requests/requests.dart';

class Cart2 extends StatefulWidget {
  @override
  _Cart2State createState() => new _Cart2State();
}

class _Cart2State extends State<Cart2> {
  StreamController _cartController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int count = 1;

  Future _getCartList() async {
    String apiToken = await UserPreferences.getApiToken();
    String getCartURL =
        "https://mayrasales.com/api/user/cart?api_token=$apiToken";
    var r = await Requests.get(getCartURL);
    print(getCartURL);
    r.raiseForStatus();
    var responseBody = r.content();

    CartModel products = cartModelFromJson(responseBody);

    List<Detail> productDtls = List<Detail>();

    if (products.status == "success") {
      for (var u = 0; u < products.details.length; u++) {
        Detail productDtl = products.details[u];

        productDtls.add(productDtl);
      }
    }

    print(
        "Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart");
    print(r.statusCode);
    // print(responseBody);
    // print(r.headers);
    print(
        "Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart Cart");

    return productDtls;
  }

  Future fetchPost([howMany = 5]) async {
    final response = await http.get(
        'https://blog.khophi.co/wp-json/wp/v2/posts/?per_page=$howMany&context=embed');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  loadPosts() async {
    _getCartList().then((res) async {
      _cartController.add(res);
      return res;
    });
  }

  showSnack() {
    return scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('New content loaded'),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    count++;
    print(count);
    _getCartList().then((res) async {
      _cartController.add(res);
      showSnack();
      return null;
    });
  }

  @override
  void initState() {
    _cartController = new StreamController();
    loadPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text('StreamBuilder'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Refresh',
            icon: Icon(Icons.refresh),
            onPressed: _handleRefresh,
          )
        ],
      ),
      body: StreamBuilder(
        stream: _cartController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print('Has error: ${snapshot.hasError}');
          print('Has data: ${snapshot.hasData}');
          print('Snapshot Data ${snapshot.data}');

          if (snapshot.hasError) {
            return Text(snapshot.error);
          }

          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: Scrollbar(
                    child: RefreshIndicator(
                      onRefresh: _handleRefresh,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          var post = snapshot.data[index];
                          return ListTile(
                            title: Text(post['name']),
                            //subtitle: Text(post['date']),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Text('No Posts');
          }
        },
      ),
    );
  }
}
