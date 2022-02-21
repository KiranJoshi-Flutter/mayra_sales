import 'package:flutter/material.dart';
import 'package:mayrasales/constants.dart';
import 'package:mayrasales/controller/app_localisation.dart';
import 'package:mayrasales/funstions.dart';

class AdsWidget extends StatefulWidget {
  AdsWidget({
    Key key,
    this.ad1Url,
    this.onClickAd1,
    this.ad2Url,
    this.onClickAd2,
  }) : super(key: key);

  final String ad1Url;
  final Function onClickAd1;
  final String ad2Url;
  final Function onClickAd2;

  @override
  _AdsWidgetState createState() => _AdsWidgetState();
}

class _AdsWidgetState extends State<AdsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black45,
      padding: EdgeInsets.symmetric(
        vertical: 0.0,
        horizontal: 16.0,
      ),
      child: Row(
        children: [
          widget.ad1Url.isNotEmpty
              ? Expanded(
                  child: GestureDetector(
                    onTap: widget.onClickAd1,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: kDefaultColor2,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8,
                            ),
                          ),
                          image: DecorationImage(
                            image: NetworkImage('$adBaseURL/${widget.ad1Url}'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        // child: Center(
                        //   child: Text(
                        //     'Ad Space',
                        //     style: appTextStyle(
                        //       FontWeight.normal,
                        //       16.0,
                        //       Colors.white,
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                )
              : Container(),
          SizedBox(
            width: 16.0,
          ),
          widget.ad2Url.isNotEmpty
              ? Expanded(
                  child: GestureDetector(
                    onTap: widget.onClickAd2,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: kDefaultColor2,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8,
                            ),
                          ),
                          image: DecorationImage(
                            image: NetworkImage('$adBaseURL/${widget.ad2Url}'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
