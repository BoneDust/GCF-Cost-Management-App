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
    return Card(
      elevation: 5,
        child: Column(
          children: <Widget>[
            GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ForeManStagesScreen(
                            stages: stages,
                          )));
                },
                child: Container(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text("stages"),
                         Row(
                          children: <Widget>[
                            Text(stages.length.toString()),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                              size: 25.0,
                            ),
                          ],
                        )
                      ]),
                )),
            _StagesCard(stages),
            RaisedButton(
                child: Text("Add a Stage"),
                onPressed: () => Navigator.of(context).pushNamed("/add_stage"))
          ],
        ));
    ;
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
          child: Center(child: Text(stage.name)),
          color: Color.fromARGB(rng.nextInt(255), rng.nextInt(255),
              rng.nextInt(255), rng.nextInt(255)),
        ),
      ),
    );
  }

  _showStage(BuildContext context, Stage stage) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ForeManStageScreen(stage: stage,)));
  }
}
