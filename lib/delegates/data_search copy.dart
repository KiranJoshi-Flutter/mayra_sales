import 'package:flutter/material.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/view/search.dart';

class DataSearch extends SearchDelegate<String> {
  final cities = [
    "Gent Wear".toLowerCase(),
    "Shoes".toLowerCase(),
    "Tshirts".toLowerCase(),
    "Vests".toLowerCase(),
    "Jackets".toLowerCase(),
    "Pants".toLowerCase(),
    "Jeans".toLowerCase(),
    "Hardware".toLowerCase(),
    "Laptops".toLowerCase(),
    "Computers".toLowerCase(),
    "Mobiles".toLowerCase(),
    "Smart phones".toLowerCase(),
  ];

  final recentCities = [
    "Smartphones".toLowerCase(),
    "Tshirts".toLowerCase(),
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar

    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          //close(context, null);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of app bar
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    // Navigator.push(
    //   context,
    //   new MaterialPageRoute(
    //     builder: (context) => SearchPage(query),
    //   ),
    // );

    //return null;

    // return Container(
    //   child: Center(
    //     child: Text(query),
    //   ),
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for somethin

    print(query);

    // var searchLists = [];

    // if (query != "") {
    //   searchLists = _getSearchResult(query);
    // }

    final suggestionList = query.isEmpty
        ? recentCities
        : cities.where((element) => element.startsWith(query)).toList();

    print('suggestionList = $suggestionList');

    return suggestionList.isEmpty
        ? Padding(
            padding: EdgeInsets.all(16.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => SearchScreen(query: query),
                  ),
                );
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xffff85b2),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate('str_search'),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ))
        : ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: (context, index) => ListTile(
              title: RichText(
                text: TextSpan(
                  text: suggestionList[index].substring(0, query.length),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: suggestionList[index].substring(query.length),
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              onTap: () {
                //showResults(context);

                print(suggestionList[index]);

                print(query);

                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) =>
                        SearchScreen(query: suggestionList[index]),
                  ),
                );
              },
            ),
          );
  }

  // List<String> _getSearchResult(String query) async {
  //   //if()
  // String getSearchURL = "https://mayrasales.com/api/search/$query";
  // var r = http.get(getSearchURL);
  // print(getSearchURL);
  // //r.raiseForStatus();
  // var responseBody = r.body;

  // search.SearchProductModel searchProducts =
  //     search.searchProductModelFromJson(responseBody);

  // var names = [];

  // if (searchProducts.status == 'success') {
  //   if (searchProducts.details.length != 0) {
  //     for (var a = 0; a < searchProducts.details.length; a++) {
  //       names.add(searchProducts.details[a].name);
  //     }
  //     print(names);
  //   }
  // }

  //return names;
}
