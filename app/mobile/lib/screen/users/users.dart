import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/users/users_tile.dart';
import 'package:flutter/material.dart';

class ManageUsersScreen extends StatelessWidget {
  final List<User> users = [
    User(name: "Lonwabo", privilege: Privilege.FOREMAN, surname: "Rarane"),
    User(name: "Lonwabo", privilege: Privilege.FOREMAN, surname: "Rarane"),
    User(name: "Lonwabo", privilege: Privilege.FOREMAN, surname: "Rarane"),
    User(name: "Lonwabo", privilege: Privilege.FOREMAN, surname: "Rarane"),
    User(name: "Lonwabo", privilege: Privilege.FOREMAN, surname: "Rarane"),
    User(name: "Lonwabo", privilege: Privilege.FOREMAN, surname: "Rarane"),
    User(name: "Lonwabo", privilege: Privilege.FOREMAN, surname: "Rarane"),
    User(name: "Lonwabo", privilege: Privilege.FOREMAN, surname: "Rarane"),
    User(name: "Lonwabo", privilege: Privilege.FOREMAN, surname: "Rarane"),
    User(name: "Lonwabo", privilege: Privilege.FOREMAN, surname: "Rarane"),
    User(name: "Lonwabo", privilege: Privilege.FOREMAN, surname: "Rarane"),
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
