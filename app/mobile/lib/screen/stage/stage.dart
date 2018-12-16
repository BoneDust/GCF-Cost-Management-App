import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';
import 'index.dart';

class ForeManStageScreen extends StatelessWidget {
  Stage stage;

  ForeManStageScreen(this.stage);

  @override
  Widget build(BuildContext context) {
    AppDataContainerState userContainerState = AppDataContainer.of(context);
    User user = userContainerState.user;
    List<Widget> appBarActions = [];

    if (user.privilege == Privilege.ADMIN)
      appBarActions.add(_ProjectPopMenuButton());
    return Scaffold(
        appBar: AppBar(
          actions: appBarActions,
          title: Text(stage.name),
        ),
        body: SafeArea(
          child: _StageScreen(),
        ));
  }
}

class _StageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          StageDetails(),
          SnapShotCard(),
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
