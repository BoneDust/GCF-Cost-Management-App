import 'dart:math';

import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/screen/foreman/stage/stage.dart';
import 'package:flutter/material.dart';

class ForeManStagesScreen extends StatelessWidget {
  final List<Stage> stages;

  const ForeManStagesScreen({Key key, @required this.stages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stages"),
      ),
      body: _StagesScreen(stages: stages,)
    );
  }
}

class _StagesScreen extends StatelessWidget {
  final List<Stage> stages;

  const _StagesScreen({Key key, @required this.stages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 20.0),),
        Center(
          heightFactor: 1,
          child: Wrap(
            children: stages.map((stage) {
              return _StageSampleCard(stage);
            }).toList() ,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 20.0),),

      ],
    );
  }

}

class _StageSampleCard extends StatelessWidget {
  final Stage stage;
  static var rng = new Random();

  _StageSampleCard(this.stage);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.only(left: 7),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
              ForeManStageScreen(stage)
          ));
        },
        child:  Card(
          child: Center(child: Text(stage.name)),
          color: Color.fromARGB(rng.nextInt(255), rng.nextInt(255),
              rng.nextInt(255), rng.nextInt(255)),
        ),
      ),
    );
  }
}