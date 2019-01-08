import 'dart:math';

import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/screen/stage/stage.dart';
import 'package:cm_mobile/screen/stage/stages.dart';
import 'package:flutter/material.dart';

class StagesWidget extends StatelessWidget {
  final List<Stage> stages;

  StagesWidget(this.stages);

  @override
  Widget build(BuildContext context) {
    return stages == null || stages.isEmpty
        ? Column()
        : _StagesWidgetRoot(stages);
  }
}

class _StagesWidgetRoot extends StatelessWidget {
  final List<Stage> stages;

  _StagesWidgetRoot(this.stages);

  @override
  Widget build(BuildContext context) {
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 10), child: Text("stages", style: TextStyle(color: Colors.blueGrey, fontSize: 30),),),
                FlatButton(
                    child: Text("+ ADD STAGE", style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w400)),
                    onPressed: () => Navigator.of(context).pushNamed("/add_stage"))
              ],
            ),
            Column(
              children: <Widget>[
                _StagesCard(stages),
              ],
            )
          ],
        );
  }
}

class _StagesCard extends StatelessWidget {
  final List<Stage> stages;

  _StagesCard(this.stages);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.0,
      padding: EdgeInsetsDirectional.only(bottom: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stages.length,
        itemBuilder: (BuildContext context, int index) {
          return _StageSampleCard(stages.elementAt(index));
        },
      ),
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
      margin: EdgeInsets.only(left: 7),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _showStage(context, stage),
        child: Card(
          child: Center(child: Text(stage.name, style: TextStyle(color: Colors.white),)),
          color: Colors.indigo,
        ),
      ),
    );
  }

  _showStage(BuildContext context, Stage stage) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ForeManStageScreen(stage: stage,)));
  }
}
