import 'package:json_annotation/json_annotation.dart';
part 'stage.g.dart';

@JsonSerializable()
class Stage {
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
      this.beforePicture = "",
      this.afterPicture = "",
      this.endDate,
      this.estimatedDaysDuration = 2});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Stage && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
  factory Stage.fromJson(Map<String, dynamic> json) => _$StageFromJson(json);

  Map<String, dynamic> toJson() => _$StageToJson(this);
}
