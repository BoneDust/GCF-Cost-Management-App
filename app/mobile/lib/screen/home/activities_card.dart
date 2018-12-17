import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/screen/activity/activity_list.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class ActivitiesCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ActivitiesCardState();
  }
}

class _ActivitiesCardState extends State<ActivitiesCard> {
  @override
  Widget build(BuildContext context) {
    AppDataContainerState userContainerState = AppDataContainer.of(context);
    List<Activity> activities = userContainerState.activities.take(3).toList();

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ExpansionTile(
            title: Text("Activity"),
            children: [
              ActivityList(
                activities: activities,
                isScrollable: false,
              ),
              RaisedButton(
                  child: Text("Show activities"),
                  onPressed: () =>
                      Navigator.of(context).pushNamed("/activities")),
            ],
          ),
        ],
      ),
    );
  }
}
