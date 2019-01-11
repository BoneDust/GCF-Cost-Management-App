import 'dart:collection';

import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Project {
  int id;
  int userId;
  int teamSize;
  int clientId;
  String name;
  double estimatedCost;
  String status;
  double expenditure;
  DateTime startDate;
  DateTime endDate;

  User foreman;
  List<Receipt> receipts;
  List<Activity> activities;
  List<Stage> stages;

  Project(
      {this.id = 0,
      this.clientId = 0,
      this.name = "",
      this.estimatedCost = 0.0,
      this.status = "",
      this.expenditure = 0.0,
      this.foreman,
      this.startDate,
      this.endDate,
      this.receipts,
      this.stages,
      this.teamSize,
      this.userId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Project && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Project.fromJson(Map<String, dynamic> json)
      : id = json['projectId'],
        userId = json['user_id'],
        teamSize = json['team_size'],
        clientId = json['client_id'],
        name = json['name'],
        estimatedCost = getDouble(json["estimated_cost"]),
        status = json['status'],
        expenditure = getDouble(json['expenditure']),
        startDate = DateTime.fromMillisecondsSinceEpoch(json['start_date']),
        endDate = DateTime.fromMillisecondsSinceEpoch(json['end_date'])
  ;

  Map<String, dynamic> toJson() => {
        "projectId": id,
        "user_id": userId,
        "estimated_cost": estimatedCost,
        "end_date": endDate.millisecondsSinceEpoch,
        "client_id": clientId,
        "start_date": startDate.millisecondsSinceEpoch,
        "status": status,
        "team_size": teamSize,
        "name": name,
        "expenditure": expenditure
      };

  static double getDouble(var number) {
    if (number is double) return number;
    if (number is int) {
      return number.toDouble();
    }
    if (number is String) return double.parse(number);
    return 0.0;
  }
}
