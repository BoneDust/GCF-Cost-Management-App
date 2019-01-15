import 'dart:async';

import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/generic_bloc.dart';
import 'package:cm_mobile/data/app_data.dart';
import 'package:cm_mobile/data/mode_cache.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/activity/activities.dart';
import 'package:cm_mobile/screen/activity/activity_list.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class ActivitiesCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ActivitiesCardState();
  }
}

class _ActivitiesCardState extends State<ActivitiesCard> {

  @override
  void initState() {



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppDataContainerState userContainerState = AppDataContainer.of(context);
    List<Activity> activities = userContainerState.activities;
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
                activities: activities.take(3).toList(),
                isScrollable: false,
              ),
              Center(child: FlatButton(onPressed:(){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            ActivitiesScreen(activities: activities)));
              } , child:  Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.keyboard_arrow_down),
                  Text("all activites")
                ],)),)
            ],
          ),
        ],
      ),
    );
  }
}