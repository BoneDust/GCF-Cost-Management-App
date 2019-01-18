import 'dart:core';

import 'package:cm_mobile/model/model_base.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Client extends ModelBase {
  int id;
  String name;
  String contactPerson;
  String contactNumber;

  Client({this.id, this.name, this.contactPerson, this.contactNumber});

  Client.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        contactPerson = json['contact_person'].toString(),
        contactNumber = json['contact_number'],
        id = json['clientId'];

  Map<String, dynamic> toJson() => {
        'clientId': id,
        'name': name,
        'contact_person': contactPerson,
        'contact_number': contactNumber,
      };
}
