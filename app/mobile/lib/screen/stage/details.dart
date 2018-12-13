import 'package:flutter/material.dart';

class StageDetails extends StatelessWidget {
  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  StageDetails() {
    baseTextStyle = const TextStyle();
    headerStyle = baseTextStyle.copyWith(fontSize: 18.0);
    subheadingStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 12.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          _Details(),
        ],
      ),
    );
  }
}

class _Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        Text("This is the description of the stage"),
        Text("Stage status: Currently in progress"),
        Padding(
          padding: EdgeInsets.only(top: 20.0),
        ),
      ],
    );
  }
}
