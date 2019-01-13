import 'dart:math';

import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/screen/project/project.dart';
import 'package:cm_mobile/screen/stage/add_edit_stage.dart';
import 'package:cm_mobile/screen/stage/stage.dart';
import 'package:flutter/material.dart';

class StagesWidget extends StatefulWidget {
  final Project project;
  ProjectWidgetState parent;

  StagesWidget(this.project, this.parent);

  @override
  State<StatefulWidget> createState() {
    return _StagesWidget();
  }
}

class _StagesWidget extends State<StagesWidget> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "stages",
                style: TextStyle(color: Colors.blueGrey, fontSize: 30),
              ),
            ),
            widget.project.stages != null && widget.project.stages.isNotEmpty
                ? _buildAddButton(context)
                : Column(),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child:       Center(
            child: widget.project.stages != null
                ? widget.project.stages.isNotEmpty
                ? _StagesCard(widget.project.stages)
                : _buildAddButton(context, true)
                : Column(),
          ),
        )
      ],
    );
  }

  Widget _buildAddButton(BuildContext context, [bool isLargeText = false]) {
    return FlatButton(
        child: Text("+ ADD STAGE",
            style:
                TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w400, fontSize: isLargeText ? 20 : 14)),
        onPressed: () => _navigateAndDisplaySelection(context));
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddEditStageScreen(
          isEditing: true,
          projectId : widget.project.id
        )));

    if (result is Stage) {
      widget.parent.setState(() {
        widget.project.stages.insert(0, result);
      });
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text("stage created"), backgroundColor: Colors.green));
    }
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
          child: Center(
              child: Text(
            stage.name,
            style: TextStyle(color: Colors.white),
          )),
          color: Colors.indigo,
        ),
      ),
    );
  }


  _showStage(BuildContext context, Stage stage) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => StageScreen(
              stage: stage,
            )));
  }
}
