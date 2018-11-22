import 'dart:math';

import 'package:flutter/material.dart';
import 'base_project_card.dart';

class StagesCard extends BaseProjectCard {
  StagesCard() : super("Stages");

  @override
  Widget setChildren() {
    return _SampleCardRoot();
  }
}

class _StagesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.0,
      padding: EdgeInsetsDirectional.only(bottom: 10.0),

      child: ListView(

        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _StageSampleCard("1"),
          _StageSampleCard("2"),
          _StageSampleCard("3"),
          _StageSampleCard("4"),
          _StageSampleCard("5"),
          _StageSampleCard("6")
        ],
      ),
    );
  }
}

class _SampleCardRoot extends StatelessWidget {
  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  _SampleCardRoot() {
    baseTextStyle = const TextStyle();
    headerStyle =
        baseTextStyle.copyWith(fontSize: 18.0);
    subheadingStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 12.0,
    );
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
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
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
        _StagesCard()
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
      margin: EdgeInsets.only(left: 7),
      child: Card(
        child: Center(child: Text(title)),
        color: Color.fromARGB(rng.nextInt(255), rng.nextInt(255),
            rng.nextInt(255), rng.nextInt(255)),
      ),
    );
  }
}
