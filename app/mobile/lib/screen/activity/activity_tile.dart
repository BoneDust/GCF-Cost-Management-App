import 'dart:math';

import 'package:cm_mobile/enums/activity_type.dart';
import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/screen/activity/activity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityTile extends StatelessWidget {
  final Activity activity;

  ActivityTile(this.activity);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.grey),
      )),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ActivityScreen(activity)));
        },
        leading: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: getActivityColor(activity.type)),
        ),
        trailing: Text("2d"),
        title:
            Text(activity.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(activity.description,
            maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
