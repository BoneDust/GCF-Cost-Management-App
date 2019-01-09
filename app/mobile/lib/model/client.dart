import 'dart:core';

import 'package:cm_mobile/model/project.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Client {

  int id;
  String name;
  Project projects;
  String contactPerson;
  String contactNumber;

  Client(
      {this.id,
      this.name,
      this.projects,
      this.contactPerson,
      this.contactNumber});

  Client.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
      };
}
