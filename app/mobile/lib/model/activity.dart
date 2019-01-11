import 'dart:convert';

import 'package:cm_mobile/enums/activity_type.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()

class Activity {
  String performer;
  int activityId;
  int projectId;
  String description;
  DateTime creationDate;
  String title;
  ActivityType type;

  Activity({ this.performer, this.activityId,
    this.projectId, this.description, this.creationDate, this.title,
    this.type});

  Activity.fromJson(Map<String, dynamic> json)
      : performer = json['performer'],
        activityId = json['activityId'],
        projectId = json['project_id'],
        description = json['description'],
        creationDate = DateTime.fromMillisecondsSinceEpoch(json['creation_date_ms']),
        title = json['title'],
        type = ActivityTypeMap[json['type']];
}
