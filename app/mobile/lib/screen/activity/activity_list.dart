import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/screen/activity/activity_tile.dart';
import 'package:flutter/material.dart';

class ActivityList extends StatelessWidget {
  final List<Activity> activities;
  final bool isScrollable;
  const ActivityList({Key key, @required this.activities, this.isScrollable = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: isScrollable?  BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
      children: activities.map((activity) {
        return ActivityTile(activity);
      }).toList(),
    );
  }
}
