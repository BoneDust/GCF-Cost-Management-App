import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("GCF"),
        ) ,
        body: SafeArea(
          child: AdminHomeScreen(),
        )
    );
  }
}

class _AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      //TODO
    );
  }
}