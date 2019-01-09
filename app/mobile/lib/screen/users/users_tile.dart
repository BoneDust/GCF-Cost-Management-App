import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/users/user_screen.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final User user;

  final Function function;

  const UserTile({@required this.user, this.function});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(user.name),
      background: Container(color: Colors.red),
      child: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () {
               function != null ? function(context, user) :  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserScreen(user: user)));
              },
              title: Text(user.name + " " + user.surname),
              subtitle: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(PrivilegeType[user.privilege]),
                    // SizedBox(
                    //   height: 20.0,
                    // ),
                    // Divider(
                    //   color: Colors.grey[300],
                    // ),
                  ],
                ),
              ),
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("assets/images.jpeg"),
                        fit: BoxFit.cover)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
            ),
            Divider(
              height: 1.0,
              indent: 82,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}
