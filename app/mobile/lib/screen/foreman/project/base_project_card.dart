import 'package:flutter/material.dart';

abstract class BaseProjectCard extends StatelessWidget {
  Widget child;
  String header;
  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  Widget setChildren();

  BaseProjectCard(this.header) {
    child = setChildren();
    baseTextStyle = const TextStyle(fontFamily: 'Comfortaa');
    headerStyle = baseTextStyle.copyWith(
        fontSize: 18.0,
        fontWeight: FontWeight.bold
    );
    subheadingStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 12.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child:  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:  <Widget>[
              Text(header, style: headerStyle),
              Column(
                children: <Widget>[
                  child
                ],
              )
            ]
        )
    );
  }
}
