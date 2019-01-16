import 'package:cached_network_image/cached_network_image.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/users/user_screen.dart';
import 'package:cm_mobile/screen/users/users_screen.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final User user;
  final UsersScreenState parent;
  final Function function;

  const UserTile({@required this.user, this.function, this.parent});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Dismissible(
      key: Key(user.name),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart) {
          print('End to start');
        } else if (direction == DismissDirection.startToEnd) {
          print('start to End');
        } else {
          print('unknown');
        }
      },
      background: Container(color: Colors.red),
      child: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () {
                function != null
                    ? function(context, user)
                    : parent.navigateAndDisplayProject(context, user);
              },
              title: Text(user.name + " " + user.surname),
              subtitle: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(PrivilegeType[user.privilege]),
                  ],
                ),
              ),
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,),
                child: CachedNetworkImage(
                  imageUrl: user.image,
                  placeholder:  Text("loading picture...", style: TextStyle(color: themeData.primaryTextTheme.display1.color)),
                  errorWidget:  Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
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
