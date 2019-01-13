import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/client.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class ClientDetailsCard extends StatelessWidget {
  final Client client;

  const ClientDetailsCard({Key key, @required this.client}) : super(key: key);

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
                title: Column(
                  children: <Widget>[
                    Text(client.contactNumber.toString()),
                    Text(client.contactPerson)
                  ],
                ),
                subtitle: Text("phone number"),
                leading: Icon(Typicons.phone_outline),
              ),
              Divider(
                color: Colors.black54,
              ),
            ],
          ),
        )
      ],
    );
  }
}
