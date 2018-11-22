import 'package:flutter/material.dart';

abstract class BaseProjectCard extends StatelessWidget {
  Widget child;
  String header;
  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  Widget setChildren();

  BaseProjectCard(this.header) {
    baseTextStyle = const TextStyle(fontFamily: 'Comfortaa');
    headerStyle = baseTextStyle.copyWith(
        fontSize: 18.0,
        fontWeight: FontWeight.bold

    );
    subheadingStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 12.0,
    );
    child = setChildren();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        child: child
    );
  }
}