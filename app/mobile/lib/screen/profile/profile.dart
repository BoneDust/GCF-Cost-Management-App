import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("GCF"),
        ) ,
        body: SafeArea(
          child: _ProfileScreen(),
        )
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      //TODO
    );
  }
}