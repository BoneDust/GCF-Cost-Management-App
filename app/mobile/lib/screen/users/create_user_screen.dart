import 'package:cm_mobile/screen/users/form_fields.dart';
import 'package:flutter/material.dart';

class CreateUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _CreateUserScreen(),
    );
  }
}

class _CreateUserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateUserScreenState();
  }
}

class _CreateUserScreenState extends State<_CreateUserScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        new SliverAppBar(
          elevation: 5,
          forceElevated: true,
          pinned: true,
          flexibleSpace: new FlexibleSpaceBar(
            title: Text("add new user"),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(5.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([FormFields()]),
          ),
        )
      ],
    );
  }
}
