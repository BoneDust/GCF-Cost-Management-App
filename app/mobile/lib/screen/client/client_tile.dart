import 'package:cm_mobile/model/client.dart';
import 'package:cm_mobile/screen/client/client_screen.dart';
import 'package:cm_mobile/screen/client/clients_screen.dart';
import 'package:flutter/material.dart';

class ClientTile extends StatelessWidget {
  final Client client;
  final ClientsScreenState parent;
  final Function function;

  const ClientTile({@required this.client, this.function, this.parent});

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
                function != null
                    ? function(context, client)
                    : parent.navigateAndDisplayClient(context, client);
              },
              title: Text(client.name),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
            ),
            Divider(
              height: 1.0,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}
