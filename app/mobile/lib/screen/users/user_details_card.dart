import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
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
        Card(
          elevation: 5,
          child: Column(
            children: [
              ListTile(
                title: Text(PrivilegeType[user.privilege]),
                subtitle: Text("privilege"),
                leading: Icon(Typicons.user_outline),
              ),
              Divider(
                color: Colors.black54,
              ),
              ListTile(
                title: Text(user.contactNo),
                subtitle: Text("phone number"),
                leading: Icon(Typicons.phone_outline),
              ),
              Divider(
                color: Colors.black54,
              ),
              ListTile(
                title: Text(user.username),
                subtitle: Text(
                    "user name                                                               "),
                leading: Icon(Typicons.user),
              )
            ],
          ),
        )
      ],
    );
  }
}
