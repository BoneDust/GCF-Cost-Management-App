import 'package:flutter/material.dart';

class AdminStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("GCF"),
        ),
        body: SafeArea(
          child: _AdminStatistics(),
        ));
  }
}

class _AdminStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      //TODO
      children: <Widget>[
        Center(
          child: Text(
            'this is a statistics page.',
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
