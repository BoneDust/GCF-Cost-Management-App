import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:flutter/material.dart';

class UserDetailsCard extends StatelessWidget {
  final User user;

  const UserDetailsCard({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "details",
            style: TextStyle(color: Colors.blueGrey, fontSize: 30),
          ),
        ),
        ListTile(
          title: Text(PrivilegeType[user.privilege]),
          subtitle: Text("privilege"),
          leading: Icon(Typicons.user_outline),
        ),
        Divider(
          color: Colors.black54,
        ),
        ListTile(
          title: Text(user.email),
          subtitle: Text("email"),
          leading: Icon(Typicons.user),
        )
      ],
    );
  }
}
