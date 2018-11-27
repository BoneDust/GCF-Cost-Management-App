import 'package:flutter/material.dart';
import 'index.dart';

class ForeManMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: _ForemanMenu(),
    );
  }
}

class _ForemanMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30.0),
        ),
        UserProfileCard()
      ],
    );
  }
}
