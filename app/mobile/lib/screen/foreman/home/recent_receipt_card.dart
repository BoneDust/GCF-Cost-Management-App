import 'dart:math';

import 'package:flutter/material.dart';

class RecentReceiptCard extends StatelessWidget {
  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  RecentReceiptCard() {
    baseTextStyle = const TextStyle();
    headerStyle =
        baseTextStyle.copyWith(fontSize: 18.0);
    subheadingStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 12.0,);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/foreman/stages");
            },
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Text("Recent Receipts", style: headerStyle),
                    new Row(
                      children: <Widget>[
                        Text("4", style: headerStyle.copyWith(color: Colors.grey)),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                          size: 25.0,
                        ),
                      ],
                    )
                  ]),
            )),
        _Receipts(),
      ],
    );
  }
}


class _Receipts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(bottom: 10.0),

      child: Column(
        children: <Widget>[
          _ReceiptsCard(),
          _ReceiptsCard(),
          _ReceiptsCard(),

        ],
      ),
    );
  }
}

class _ReceiptsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Payment made to "),
      subtitle: Text("This content was made to that guy"),
      leading: Image(
        image: AssetImage("assets/images.jpeg"),
        width: 60,
        height: 60,
      ),
    );
  }
}