import 'dart:core';

import 'package:cm_mobile/model/project.dart';

class Client {
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
}
