import 'package:flutter/material.dart';

class AdminProjectsScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("GCF"),
        ) ,
        body: SafeArea(
          child: _AdminProjectsScreen(),
        )
    );
  }
}

class _AdminProjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      //TODO
    );
  }
}