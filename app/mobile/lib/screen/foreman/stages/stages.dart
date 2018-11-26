import 'dart:math';

import 'package:flutter/material.dart';

class ForeManStagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stages"),
      ),
      body: _StagesScreen(),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushNamed(context, "/foreman/create_receipt");
      },
        child: ImageIcon(AssetImage("assets/icons/add_receipt.png")),),
    );
  }
}

class _StagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 20.0),),
        Center(
          heightFactor: 1,
          child: Wrap(
            children: <Widget>[
              _StageSampleCard("1"),
              _StageSampleCard("1"),
              _StageSampleCard("1"),
              _StageSampleCard("1"),
              _StageSampleCard("1"),
              _StageSampleCard("1"),
              _StageSampleCard("1"),
              _StageSampleCard("1"),
              _StageSampleCard("1"),
              _StageSampleCard("1"),
              _StageSampleCard("1"),
              _StageSampleCard("1"),
              _StageSampleCard("1"),
              _StageSampleCard("1"),
              _StageSampleCard("1"),
              _StageSampleCard("1"),
              _StageSampleCard("1"),
              _StageSampleCard("1"),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 20.0),),

      ],
    );
  }
}

class _StageSampleCard extends StatelessWidget {
  String title;
  static var rng = new Random();

  _StageSampleCard(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.only(left: 7),
      child: InkWell(
        onTap: () {Navigator.pushNamed(context, "/foreman/stage"); },
        child:  Card(
          child: Center(child: Text(title)),
          color: Color.fromARGB(rng.nextInt(255), rng.nextInt(255),
              rng.nextInt(255), rng.nextInt(255)),
        ),
      ),
    );
  }
}