import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  int id;
  String name;
  String surname;
  String username;
  String password;
  String pictureUrl;
  String contactNo;
  Privilege privilege;

  User(
      {this.id,
      this.name,
      this.surname,
      this.username,
      this.password,
      this.pictureUrl,
      this.contactNo,
      this.privilege});

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        surname = json['surname'];

  String get fullName => name + " " + surname;

  Map<String, dynamic> toJson() => {
    'name': name,
    'surname': surname,
  };

}
