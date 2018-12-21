import 'package:cm_mobile/model/stage.dart';
import 'package:flutter/material.dart';
import 'index.dart';

class ForeManStageScreen extends StatelessWidget {
  final Stage stage;

  const ForeManStageScreen({Key key, @required this.stage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [_ProjectPopMenuButton()],
          title: Text(stage.name),
        ),
        body: SafeArea(
          child: _StageScreen(
            stage: stage,
          ),
        ));
  }
}

class _StageScreen extends StatelessWidget {
  final Stage stage;

  const _StageScreen({Key key, @required this.stage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          StageDetails(
            stage: stage,
          ),
          SnapShotCard(
            stage: stage,
          ),
          Duration(),
          Padding(
            padding: EdgeInsets.only(top: 30.0),
          ),
        ],
      ),
    );
  }
}

class _ProjectPopMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(child: Text("Edit"), value: "Edit"),
              PopupMenuItem<String>(child: Text("Remove"), value: "Remove"),
            ]);
  }
}
