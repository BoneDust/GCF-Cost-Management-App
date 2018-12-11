import 'package:cm_mobile/screen/admin/menu/profiles_card.dart';
import 'package:cm_mobile/screen/admin/menu/user_profile.dart';
import 'package:flutter/material.dart';

class AdminMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: _AdminMenu(),
    );
  }
}

class _AdminMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30.0),
        ),
        AdminProfileCard(),
        AdminProfilesCard()
      ],
    );
  }
}
