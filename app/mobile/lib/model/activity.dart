import 'package:cm_mobile/enums/activity_type.dart';
import 'package:json_annotation/json_annotation.dart';
part 'activity.g.dart';

@JsonSerializable()
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
  factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
