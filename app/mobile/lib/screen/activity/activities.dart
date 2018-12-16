import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/screen/activity/activity_list.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class ActivitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppDataContainerState userContainerState = AppDataContainer.of(context);
    List<Activity> activities = userContainerState.activities;

    return Scaffold(
      appBar: AppBar(
          title: Text("Activities" + "(" + activities.length.toString() + ")")),
      body: ActivityList(activities: activities),
    );
  }
}
