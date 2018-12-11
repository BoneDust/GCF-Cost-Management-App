import 'package:cm_mobile/enums/privilege_enum.dart';

class User {
  int id;
  String name;
  String surname;
  String username;
  String password;
  String pictureUrl;
  String contactNo;
  Privilege privileges;


  User({this.id, this.name, this.surname, this.username, this.password,
      this.pictureUrl, this.contactNo, this.privileges});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
