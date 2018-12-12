import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/users/manage_user_screen.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ManagerUserScreen(user: user)));
        },
        title: Text(user.name + " " + user.surname),
        subtitle: Text(user.privileges.toString()),
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage("assets/images.jpeg"), fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
