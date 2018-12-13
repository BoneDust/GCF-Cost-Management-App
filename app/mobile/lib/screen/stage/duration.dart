import 'package:flutter/material.dart';

class Duration extends StatelessWidget {
  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  Duration() {
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
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/foreman/stages");
              },
              child: Container(
                padding: EdgeInsets.only(top: 10.0, left: 10.0),
                child: Text("Details", style: headerStyle),
              )),
          _Duration(),
        ],
      ),
    );
  }
}

class _Duration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text("12 days"),
          subtitle: Text("Estimated time"),
          leading: Icon(Icons.timer),
        ),
        ListTile(
          title: Text("12 days"),
          subtitle: Text("Started Date"),
          leading: Icon(Icons.date_range),
        ),
        ListTile(
          title: Text("12 days"),
          subtitle: Text("End date"),
          leading: Icon(Icons.date_range),
        ),
      ],
    );
  }
}
