import 'package:cm_mobile/enums/privilege_enum.dart';

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
}
