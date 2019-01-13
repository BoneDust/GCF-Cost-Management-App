import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/screen/activity/activity_list.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class ActivitiesScreen extends StatelessWidget {
  final List<Activity> activities;

  const ActivitiesScreen({Key key, @required this.activities}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text("activities" + "(" + activities.length.toString() + ")")),
      body: ActivityList(activities: activities),
    );
  }
}
