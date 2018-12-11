import 'dart:collection';

import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/model/user.dart';

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

  List<Stage> stages;
  int teamSize;

  Project({
    this.id = 0,
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
    this.teamSize
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Project && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Project.fromJson(Map json)
      : id = json['id'];

}
