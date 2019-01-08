import 'dart:core';

import 'package:cm_mobile/model/project.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Client {

  Client();

  int id;
  String name;
  Project projects;
  String contactPerson;
  String contactNumber;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Client && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
  Client.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
  };
}
