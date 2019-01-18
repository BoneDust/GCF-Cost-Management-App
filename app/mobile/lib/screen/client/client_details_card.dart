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
    ThemeData themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "details",
            style: TextStyle(color: themeData.primaryTextTheme.display1.color, fontSize: 30),
          ),
        ),
        ListTile(
          title:  Text(client.contactNumber.toString()) ,
          subtitle: Text(client.contactPerson),
          leading: Icon(Typicons.phone_outline),
        ),

      ],
    );
  }
}
