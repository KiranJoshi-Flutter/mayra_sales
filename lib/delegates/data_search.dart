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
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
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
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print(query);

    // var searchLists = [];

    // if (query != "") {
    //   searchLists = _getSearchResult(query);
    // }

    final suggestionList = query.isEmpty
        ? recentCities
        : cities.where((element) => element.startsWith(query)).toList();

    print('suggestionList = $suggestionList');
  }
}
