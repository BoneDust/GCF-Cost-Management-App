import 'package:cm_mobile/model/stage.dart';
import 'package:flutter/material.dart';
import 'index.dart';

class ForeManStageScreen extends StatelessWidget {
  Stage stage;

  ForeManStageScreen(this.stage)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(stage.name),
        ) ,
        body: SafeArea(
          child: _StageScreen(),
        )
    );
  }
}

class _StageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey ,
      child: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 20.0),),
          StageDetails(),
          SnapShotCard(),
          Duration(),
          Padding(padding: EdgeInsets.only(top: 30.0),),

        ],
      ),
    );
  }
}

