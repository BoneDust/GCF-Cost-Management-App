import 'package:flutter/material.dart';

class AdminProfileCard extends StatelessWidget {
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
        title: Text("Jane Doe"),
        subtitle: Text("Administrator"),
      ),
    );
  }
}
