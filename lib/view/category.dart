import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';
import 'package:mayrasales/model/cateories_model.dart';
import 'package:mayrasales/view/categorproduct.dart';
import 'package:mayrasales/widgets/rounded_bordered_container.dart';
import 'package:mayrasales/widgets/widgets.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:requests/requests.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isExpanded = false;
  Future<List<CategoriesModel>> fCategories;
  @override
  void initState() {
    fCategories = _getCategoryList();
    super.initState();
  }

  Future<List<CategoriesModel>> _getCategoryList() async {
    try {
      String getCartURL = "https://mayrasales.com/api/categories_with_sub";
      var r = await Requests.get(getCartURL);
      print(getCartURL);
      r.raiseForStatus();
      var responseBody = r.content();

      List<CategoriesModel> categories = categoriesModelFromJson(responseBody);

      print(
          "*******************************************************************");
      print(categories.length);
      print(categories[1]);

      return categories;
    } on HttpException catch (error) {
      print(error.toString());
    } catch (error) {
      print(error);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(
        context,
        AppLocalizations.of(context).translate('str_category'),
      ),

      body: FutureBuilder(
        future: fCategories,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: PKCardListSkeleton(
                isCircularImage: true,
                isBottomLinesActive: false,
                // isBottomLinesActive: true,
                length: 4,
              ),
            );
          } else {
            return Container(
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, int index) {
                        return ListTile(
                          title: Text(
                            snapshot.data[index].name,
                            style: appTextStyle(
                              FontWeight.w500,
                              16.0,
                              kTextColor,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_forward,
                                  size: 20.0,
                                ),
                                onPressed: () {
                                  //print('aaaa');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CateoryProducts(
                                        categoryId: snapshot.data[index].id,
                                        subCategoryId: '',
                                        categoryName: snapshot.data[index].name,
                                      ),
                                    ),
                                  );

                                  //   _onDeleteItemPressed(index);
                                },
                              ),
                            ],
                          ),
                          onTap: () async {
                            if (snapshot.data[index].subcategories != null) {
                              //print(snapshot.data[index].subcategories.length);

                              // for (var a = 0;
                              //     a < snapshot.data[index].subcategories.length;
                              //     a++) {
                              //   print(
                              //       snapshot.data[index].subcategories[a].name);
                              // }
                              showBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                  //     color: Colors.red,
                                  child: ListView.builder(
                                    itemCount: snapshot
                                        .data[index].subcategories.length,
                                    itemBuilder: (context, a) {
                                      return ListTile(
                                        title: Text(
                                          '${snapshot.data[index].subcategories[a].name}',
                                          style: appTextStyle(
                                            FontWeight.w500,
                                            16.0,
                                            kTextColor,
                                          ),
                                        ),
                                        onTap: () {
                                          if (snapshot.data[index]
                                                  .childcategories !=
                                              null) {
                                            print(snapshot.data[index]
                                                .childcategories.length);

                                            for (var a = 0;
                                                a <
                                                    snapshot.data[index]
                                                        .childcategories.length;
                                                a++) {
                                              print(snapshot.data[index]
                                                  .childcategories[a].name);
                                            }
                                          }
                                        },
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                Icons.arrow_forward,
                                                size: 20.0,
                                              ),
                                              onPressed: () {
                                                print('bbbbbbbbbb');
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CateoryProducts(
                                                      categoryId: snapshot
                                                          .data[index]
                                                          .subcategories[a]
                                                          .categoryId,
                                                      subCategoryId: snapshot
                                                          .data[index]
                                                          .subcategories[a]
                                                          .id,
                                                      categoryName: snapshot
                                                          .data[index]
                                                          .subcategories[a]
                                                          .name,
                                                    ),
                                                  ),
                                                );
                                                //   _onDeleteItemPressed(index);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }
                          },
                        );
                        //print(snapshot.data[index].name);
                        //return cartItems(
                        // snapshot.data, index, scaffoldKey.currentContext);
                      },
                      shrinkWrap: true,
                    ),
                  ),
                  //_checkoutSection(snapshot.data)
                ],
              ),
            );
          }
        },
      ),
      //backgroundColor: Colors.grey.shade500,
    );
  }

  // Widget cartItems(
  //     List<CategoriesModel> categories, int index, BuildContext context) {
  //   //var qty = categories[index].name;

  //   return ListTile(
  //     title: Text(categories[index].name),
  //     onTap: () async {
  //       if (categories[index].subcategories != null) {
  //         showBottomSheet(
  //           context: context,
  //           builder: (context) => Container(
  //             color: Colors.red,
  //             child: ListView.builder(
  //               itemCount: categories[index].subcategories.length,
  //               itemBuilder: (context, index) {
  //                 return ListTile(
  //                   title: Text('${categories[index].subcategories[index]}'),
  //                   // onTap: () {
  //                   //   if (categories[index].childcategories != null) {
  //                   //     showBottomSheet(
  //                   //       context: context,
  //                   //       builder: (context) => Container(
  //                   //         color: Colors.red,
  //                   //         child: ListView.builder(
  //                   //           itemCount: items.length,
  //                   //           itemBuilder: (context, index) {
  //                   //             return ListTile(
  //                   //               title: Text('${items[index]}'),
  //                   //             );
  //                   //           },
  //                   //         ),
  //                   //       ),
  //                   //     );
  //                   //   }
  //                   // },
  //                 );
  //               },
  //             ),
  //           ),
  //         );
  //       }
  //     },
  //   );

  //   //if (categories[index].childcategories == null) {
  //   // if (categories[index].subcategories == null) {
  //   //   return ListTile(
  //   //     title: Text(categories[index].name),
  //   //   );
  //   // } else {
  //   //   return ExpansionTile(
  //   //     title: Text(
  //   //       categories[index].name,
  //   //       style: TextStyle(
  //   //         fontSize: 16.0,
  //   //         fontWeight: FontWeight.w500,
  //   //         color: Hexcolor('#ffa797ff'),
  //   //       ),
  //   //     ),
  //   //     children: <Widget>[
  //   //       ListView.builder(
  //   //         itemCount: categories[index].subcategories.length,
  //   //         itemBuilder: (context, int subC) {
  //   //           ListTile(
  //   //             title: Text(categories[index].subcategories[subC].name),
  //   //           );
  //   //         },
  //   //         shrinkWrap: true,
  //   //       ),
  //   //     ],
  //   //     onExpansionChanged: (bool expanding) =>
  //   //         setState(() => this.isExpanded = expanding),
  //   //   );
  //   //}
  //   //}

  //   //if (categories[index].price != null) {
  //   // return Container(
  //   //   padding: const EdgeInsets.all(0),
  //   //   margin: EdgeInsets.all(10),
  //   //   child: Row(
  //   //     children: <Widget>[
  //   //       // Container(
  //   //       //   width: 130,
  //   //       //   decoration: BoxDecoration(
  //   //       //     image: DecorationImage(
  //   //       //       image: NetworkImage(
  //   //       //           'https://mayrasales.com/assets/images/thumbnails/${categories[index].thumbnail}'),
  //   //       //       fit: BoxFit.cover,
  //   //       //     ),
  //   //       //   ),
  //   //       // ),
  //   //       Flexible(
  //   //         child: Padding(
  //   //           padding: const EdgeInsets.symmetric(horizontal: 10),
  //   //           child: Column(
  //   //             children: <Widget>[
  //   //               Row(
  //   //                 mainAxisSize: MainAxisSize.max,
  //   //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   //                 children: <Widget>[
  //   //                   Flexible(
  //   //                     // child: ListTile(
  //   //                     //     //leading: Icon(Icons.home),
  //   //                     //     title: Text(categories[index].name),
  //   //                     //     style: TextStyle(fontSize: 16.0),
  //   //                     // onTap: () {
  //   //                     //   Navigator.pop(context);
  //   //                     //   //   Navigator.push(
  //   //                     //   //       context, MaterialPageRoute(builder: (context) => Profile()));
  //   //                     // },

  //   //                     // Text(
  //   //                     //   categories[index].name,
  //   //                     //   overflow: TextOverflow.fade,
  //   //                     //   softWrap: true,
  //   //                     //   style: TextStyle(
  //   //                     //       fontWeight: FontWeight.w600, fontSize: 15),
  //   //                     // ),

  //   //                     child: ListTile(
  //   //                       //leading: Icon(Icons.home),
  //   //                       trailing: Icon(Icons.arrow_right),
  //   //                       title: Text(categories[index].name,
  //   //                           style: TextStyle(fontSize: 16.0)),
  //   //                       onTap: () {
  //   //                         //Navigator.pop(context);
  //   //                         //   Navigator.push(
  //   //                         //       context, MaterialPageRoute(builder: (context) => Profile()));
  //   //                       },
  //   //                     ),
  //   //                   ),
  //   //                 ],
  //   //               ),
  //   //             ],
  //   //           ),
  //   //         ),
  //   //       )
  //   //     ],
  //   //   ),
  //   // );
  //   // } else {
  //   //   return Container();
  //   // }
  // }
}
