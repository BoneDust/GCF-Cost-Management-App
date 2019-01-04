import 'package:cm_mobile/enums/activity_type.dart';

class Activity {
  int id;
  int projectId;
  String title;
  String description;
  ActivityType type;
  DateTime dateCreated = DateTime.now();

  Activity(
    this.type, {
    this.id = 0,
    this.title = "",
    this.projectId = 0,
    this.description = "",
  });
}
