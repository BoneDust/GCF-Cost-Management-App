import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/users/users_tile.dart';
import 'package:flutter/material.dart';

class ManageUsersScreen extends StatelessWidget {
  final List<User> users = [
    User(name: "Lonwabo", privilege: Privilege.FOREMAN, surname: "Rarane"),
    User(name: "Mandlakayise", privilege: Privilege.FOREMAN, surname: "Khumba"),
    User(name: "Rolihlahla", privilege: Privilege.FOREMAN, surname: "Mandela"),
    User(name: "Lerapo", privilege: Privilege.FOREMAN, surname: "Lerole"),
    User(name: "Ntando", privilege: Privilege.FOREMAN, surname: "Duma"),
    User(name: "Dingilesizwe", privilege: Privilege.FOREMAN, surname: "Radebe"),
    User(name: "Palesa", privilege: Privilege.FOREMAN, surname: "Modiselle"),
    User(
        name: "Reitumetse",
        privilege: Privilege.FOREMAN,
        surname: "Letsholonyane"),
    User(name: "Chris", privilege: Privilege.FOREMAN, surname: "Kyle"),
    User(name: "Njabulo", privilege: Privilege.FOREMAN, surname: "Hiyashe"),
    User(
        name: "Bonganiokuhlekwamandlane",
        privilege: Privilege.FOREMAN,
        surname: "Doesitevenmatter"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Users'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return UserTile(user: users[index]);
        },
        itemCount: users.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed("/create_users");
        },
      ),
    );
  }
}
