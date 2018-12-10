import 'dart:collection';
import 'dart:math';

import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/screen/foreman/project/project.dart';
import 'package:cm_mobile/screen/foreman/stage/stage.dart';
import 'package:cm_mobile/screen/foreman/stage/stages.dart';
import 'package:flutter/material.dart';

class StagesCard  extends StatelessWidget{
  final List<Stage> stages;

  StagesCard(this.stages);

  @override
  Widget build(BuildContext context) {
    return stages == null || stages.isEmpty ? Column() : _StagesCardRoot(stages);
  }
}

class _StagesCardRoot extends StatelessWidget {
  final List<Stage> stages;

  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  _StagesCardRoot(this.stages) {
    baseTextStyle = const TextStyle();
    headerStyle =
        baseTextStyle.copyWith(fontSize: 18.0);
    subheadingStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 12.0,);
  }

  @override
  Widget build(BuildContext context) {
    return  Card(
        shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        child: Column(
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                      ForeManStagesScreen(stages: stages,)
                  ));
                },
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new Text("Stages", style: headerStyle),
                        new Row(
                          children: <Widget>[
                            Text(stages.length.toString(), style: headerStyle.copyWith(color: Colors.grey)),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                              size: 25.0,
                            ),
                          ],
                        )
                      ]),
                )
            ),
            _StagesCard(stages),
          ],
        )
    );;
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

      child:ListView.builder(
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
        onTap: () =>  _showStage(context, stage),
        child: Card(
          child: Center(child: Text(stage.name)),
          color: Color.fromARGB(rng.nextInt(255), rng.nextInt(255),
              rng.nextInt(255), rng.nextInt(255)),
        ),
      ),
    );
  }
  _showStage(BuildContext context, Stage stage) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
        ForeManStageScreen(stage)
    ));
  }

}
