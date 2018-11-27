import 'package:flutter/material.dart';

class UserProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[_Content()],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("Joe Doe"),
        subtitle: Text("Foreman"),
      ),
    );
  }
}
