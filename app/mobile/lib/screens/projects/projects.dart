import 'package:flutter/material.dart';

class ProjectsScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("GCF"),
        ) ,
        body: SafeArea(
          child: _ProjectsScreen(),
        )
    );
  }
}

class _ProjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      //TODO
    );
  }
}