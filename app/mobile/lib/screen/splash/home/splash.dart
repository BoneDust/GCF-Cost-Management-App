import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("GCF"),
        ),
        body: SafeArea(
          child: _SplashScreen(),
        ));
  }
}

class _SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[Text("Admin Home Screen")],
    );
  }
}
