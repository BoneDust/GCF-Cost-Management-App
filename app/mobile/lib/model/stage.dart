import 'package:cm_mobile/model/model_base.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Stage extends ModelBase {
  int id;
  int projectId;
  String name;
  String description;
  String status;
  String beforePicture;
  String afterPicture;
  DateTime startDate;
  DateTime endDate;
  int estimatedDaysDuration;

  Stage(
      {this.id = 0,
      this.projectId = 0,
      this.name = "",
      this.description = "",
      this.status = "",
      this.beforePicture = " ",
      this.afterPicture = " ",
      this.endDate,
      this.startDate,
      this.estimatedDaysDuration = 2});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Stage && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Stage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        projectId = json['project_id'],
        name = json['stage_name'],
        description = json['description'],
        status = json['status'],
        beforePicture = json['before_pic_url'],
        afterPicture = json['after_pic_url'],
        estimatedDaysDuration = json['estimated_duration'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'stage_name': name,
        'description': description,
        'project_id': projectId,
        'status': status,
        'before_pic_url': beforePicture,
        'after_pic_url': afterPicture,
        'start_date': startDate.millisecondsSinceEpoch,
        'end_date': endDate.millisecondsSinceEpoch,
        'estimated_duration': estimatedDaysDuration,
      };
}
