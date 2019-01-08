import 'dart:collection';

import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Project {
  int id;
  String description;
  int clientId;
  String name;
  double estimatedCost;
  String status;
  double expenditure;
  User foreman;
  DateTime startDate;
  DateTime endDate;
  List<Receipt> receipts;
  List<Activity> activities;

  List<Stage> stages;
  int   teamSize;

  var userId;

  Project(
      {this.id = 0,
      this.description = "",
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
      : id = json['id'],
        description = json['description'],
        clientId = json['client_id'],
        name = json['name'],
        status = json['status'],
        expenditure = json['expenditure'],
        foreman = json['foreman'],
        startDate = json['start_date'],
        endDate = json['end_date'],
        receipts = json['receipts'],
        stages = json['stages'],
        userId = json['user_id']

  ;

  Map<String, dynamic> toJson() => {
    'description': "DSfsdfdsfsdf",
    'client_id': 2,
    'name': "Whatever",
    'status': "Incomplete",
    'expenditure': 0.0,
    'start_date': 1546710781000,
    'end_date': 1546710781000 ,
    'user_id' : 1,
    'team_size': 3,
    'estimated_cost' : 1
  };
}
