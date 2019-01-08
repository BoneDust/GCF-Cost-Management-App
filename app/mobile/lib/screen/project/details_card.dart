import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class DetailsCard extends StatelessWidget {
  final Project project;

  DetailsCard(this.project);

  @override
  Widget build(BuildContext context) {
    return project == null ? Column() : _DetailsCardRoot(project);
  }
}

class _DetailsCardRoot extends StatelessWidget {
  final Project project;

  _DetailsCardRoot(this.project);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 10), child: Text("details", style: TextStyle(color: Colors.blueGrey, fontSize: 30),),),
        _DetailsCard(project)
      ],
    );
  }
}

class _DetailsCard extends StatelessWidget {
  final Project project;

  _DetailsCard(this.project);

  @override
  Widget build(BuildContext context) {
    AppDataContainerState userContainerState = AppDataContainer.of(context);
    User user = userContainerState.user;
    List<Widget> detailsList = [];
    if (user.privilege == Privilege.ADMIN)
      detailsList.addAll([
        ListTile(
          title: Text(project.foreman.name + " " + project.foreman.surname),
          subtitle: Text("Foreman"),
          leading: Icon(Icons.date_range),
        ),
        Divider(
          color: Colors.black54,
        )
      ]);

    detailsList.addAll([
      ListTile(
        title: Text(project.name),
        subtitle: Text("Name"),
        leading: Icon(Icons.assignment),
      ),
      Divider(
        color: Colors.black54,
      ),
      ListTile(
        title: Text(project.clientId.toString()),
        subtitle: Text("Company"),
        leading: Icon(Icons.business_center),
      ),
      Divider(
        color: Colors.black54,
      ),
      ListTile(
        title: Text(project.startDate.toString()),
        subtitle: Text("Start Date"),
        leading: Icon(Icons.date_range),
      ),
      Divider(
        color: Colors.black54,
      ),
      ListTile(
        title: Text(project.endDate.toIso8601String()),
        subtitle: Text("End Date"),
        leading: Icon(Icons.date_range),
      ),
      Divider(
        color: Colors.black54,
      ),
      ListTile(
        title: Text(project.name),
        subtitle: Text("Team Size"),
        leading: Icon(Icons.assignment),
      ),
    ]);

    return Column(
      children: detailsList,
    );
  }
}
