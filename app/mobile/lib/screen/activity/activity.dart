import 'package:cm_mobile/enums/activity_type.dart';
import 'package:cm_mobile/model/activity.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  final Activity activity;

  ActivityScreen(this.activity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity", style: TextStyle(color: Colors.white),),
        backgroundColor: getActivityColor(activity.type),

      ),
      body: _ActivityScreen(activity),
    );
  }
}

class _ActivityScreen extends StatelessWidget {
  final Activity activity;

  _ActivityScreen(this.activity);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10, top: 20),
          child: Text(
            activity.title,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 30,
                color: Colors.blueGrey),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Card(
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  title: Text(activity.description),
                  subtitle: Text("description"),
                ),
                ListTile(
                  title: Text(activity.dateCreated.toIso8601String()),
                  subtitle: Text("date created"),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

Color getActivityColor(ActivityType type) {
  switch (type) {
    case ActivityType.CLIENT:
      return Colors.blue;
    case ActivityType.PROJECT:
      return Colors.pink  ;
    case ActivityType.RECEIPT:
      return Colors.amber;
    case ActivityType.STAGE:
      return Colors.red;
    case ActivityType.USER:
      return Colors.purple;
  }
  return null;
}