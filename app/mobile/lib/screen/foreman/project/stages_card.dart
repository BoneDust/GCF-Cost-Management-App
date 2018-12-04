import 'dart:collection';
import 'dart:math';

import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/screen/foreman/project/project.dart';
import 'package:flutter/material.dart';

class StagesCard  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final ProjectInheritedWidgetState state = ProjectInheritedWidget.of(context);
    HashSet<Stage> stages = state.project.stages;

    return stages == null || stages.isEmpty ? Column() : _StagesCardRoot();
  }
}
class _StagesCardRoot extends StatelessWidget {

  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  _StagesCardRoot() {
    baseTextStyle = const TextStyle();
    headerStyle =
        baseTextStyle.copyWith(fontSize: 18.0);
    subheadingStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 12.0,);
  }

  @override
  Widget build(BuildContext context) {
    final ProjectInheritedWidgetState state = ProjectInheritedWidget.of(context);
    HashSet<Stage> stages = state.project.stages;
    return  Card(
        shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        child: Column(
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/foreman/stages");
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
                )),
            _StagesCard(),
          ],
        )
    );;
  }
}


class _StagesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProjectInheritedWidgetState state = ProjectInheritedWidget.of(context);
    HashSet<Stage> stages = state.project.stages;

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
  Stage stage;
  static var rng = new Random();

  _StageSampleCard(this.stage);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(left: 7),
      child: Card(
        child: Center(child: Text(stage.name)),
        color: Color.fromARGB(rng.nextInt(255), rng.nextInt(255),
            rng.nextInt(255), rng.nextInt(255)),
      ),
    );
  }
}
