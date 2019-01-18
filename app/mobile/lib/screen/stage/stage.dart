import 'package:cm_mobile/model/stage.dart';
import 'package:flutter/material.dart';
import 'index.dart';

class StageScreen extends StatelessWidget {
  final Stage stage;

  const StageScreen({Key key, @required this.stage}) : super(key: key);

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
    return  ListView(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        children: <Widget>[
          SnapShotCard(
            stage: stage,
          ),
          Padding(padding: EdgeInsets.only(bottom: 20),),
          StageDetails(stage: stage,),
        ],
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
