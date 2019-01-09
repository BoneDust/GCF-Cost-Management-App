import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/client.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/client/client_screen.dart';
import 'package:cm_mobile/screen/users/user_screen.dart';
import 'package:flutter/material.dart';

class ClientTile extends StatelessWidget {
  final Client client;

  final Function function;

  const ClientTile({@required this.client, this.function});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(client.name),
      background: Container(color: Colors.red),
      child: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () {
               function != null ? function(context, client) :  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ClientScreen(client: client)));
              },
              title: Text(client.name),
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
