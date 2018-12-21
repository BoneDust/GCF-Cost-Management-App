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
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ExpansionTile(
            title: Text(
              "activities",
              style: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w600),
            ),
            children: [
              ActivityList(
                activities: activities,
                isScrollable: false,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                child: RaisedButton(
                    color: Colors.blueGrey,
                    elevation: 5,
                    child: Text("show activities", style: TextStyle(color: Colors.white),),
                    onPressed: () =>
                        Navigator.of(context).pushNamed("/activities")),
              )
            ],
          ),
        ],
      ),
    );
  }
}
