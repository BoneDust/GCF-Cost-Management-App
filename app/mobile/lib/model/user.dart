import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/model_base.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User extends ModelBase {
  int id;
  String name;
  String surname;
  String email;
  String password;
  String image;
  Privilege privilege;

  User(
      {this.id,
      this.name,
      this.surname,
      this.email,
      this.image,
      this.password,
      this.privilege});

  String get fullName => name + " " + surname;

  User.fromJson(Map<String, dynamic> json)
      : id = json['userId'],
        name = json['name'],
        surname = json['surname'],
        email = json['email'],
        image = json['image'],
        privilege = PrivilegeTypeString[json['privilege']];

  Map<String, dynamic> toJson() => {
        'userId': id,
        'name': name,
        'surname': surname,
        'email': email,
        'image': image,
        'password': "dfgsdfsd",
        'privilege': PrivilegeType[privilege],
      };
}
