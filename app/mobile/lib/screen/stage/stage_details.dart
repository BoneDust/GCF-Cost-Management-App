import 'package:cm_mobile/model/stage.dart';
import 'package:flutter/material.dart';

class StageDetails extends StatelessWidget {
  final Stage stage;

  const StageDetails({Key key, this.stage}) : super(key: key);

  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "overview",
            style: TextStyle(color: themeData.primaryTextTheme.display1.color, fontSize: 30),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            stage.description,
            style: TextStyle( fontSize: 17),
          ),
        ),
        ListTile(
          title: Text(stage.startDate.toIso8601String()),
          subtitle: Text("started Date"),
          leading: Icon(Icons.date_range),
        ),
      ],
    );
  }
}
