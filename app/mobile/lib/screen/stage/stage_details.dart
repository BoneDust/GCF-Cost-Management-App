import 'package:flutter/material.dart';

class StageDetails extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "overview",
            style: TextStyle(color: Colors.blueGrey, fontSize: 30),
          ),
        ),
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
