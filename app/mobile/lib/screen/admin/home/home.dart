import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("GCF"),
        ) ,
        body: SafeArea(
          child: _AdminHomeScreen(),
        )
    );
  }
}

class _AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Admin Home Screen")
      ],
    );
  }
}