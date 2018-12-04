import 'dart:collection';
import 'dart:math';

import 'package:cm_mobile/model/stage.dart';
import 'package:flutter/material.dart';
import 'base_project_card.dart';

class StagesCard  extends BaseProjectCard{
  HashSet<Stage> stages;

  StagesCard(this.stages) : super("Uploaded Receipts");

  @override
  Widget setChildren() {
    return _ReceiptsCardRoot();
  }
}
class _ReceiptsCardRoot extends StatelessWidget {
  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  _ReceiptsCardRoot() {
    baseTextStyle = const TextStyle();
    headerStyle =
        baseTextStyle.copyWith(fontSize: 18.0);
    subheadingStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 12.0,);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        Text("4", style: headerStyle.copyWith(color: Colors.grey)),
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
    );
  }
}


class _StagesCard extends StatelessWidget {
  HashSet<Stage> stages;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.0,
      padding: EdgeInsetsDirectional.only(bottom: 10.0),

      child: ListView.builder(
        itemCount: stages.length,
        padding: EdgeInsets.only(bottom: 30, top: 30),
        itemBuilder: (BuildContext context, int index) {
          return _StageSampleCard(stages.elementAt(index),);
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
