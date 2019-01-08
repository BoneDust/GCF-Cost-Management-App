import 'dart:core';

import 'package:cm_mobile/model/project.dart';
import 'package:json_annotation/json_annotation.dart';
part 'client.g.dart';

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
  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}
