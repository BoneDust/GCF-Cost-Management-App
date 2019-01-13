import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/screen/activity/activity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ActivityTile extends StatelessWidget {
  final Activity activity;

  ActivityTile(this.activity);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ActivityScreen(activity)));
            },
            trailing: Text(timeago.format(activity.creationDate, locale: 'en_short')),
            title: Text(activity.title),
            subtitle: Text(activity.description, overflow: TextOverflow.ellipsis, maxLines: 1,),
            leading: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: getActivityColor(activity.type)),
            ),
          )
          ,
          Divider(
            indent: 82,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
