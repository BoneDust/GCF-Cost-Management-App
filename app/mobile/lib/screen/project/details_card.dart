import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class ProjectDetailsCard extends StatelessWidget {
  final Project project;

  ProjectDetailsCard(this.project);

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
    ThemeData themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 10), child: Text("details", style: TextStyle(color: themeData.primaryTextTheme.display1.color, fontSize: 30),),),
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
    if (project.foreman != null){
      if (user.privilege == Privilege.ADMIN)
        detailsList.addAll([
          ListTile(
            title: Text(project.foreman.name + " " + project.foreman.surname),
            subtitle: Text("Foreman"),
            leading: Icon(Typicons.user_outline),
          ),
          Divider(
            color: Colors.black54,
          )
        ]);
    }

    if (project.client != null){
      detailsList.addAll([
        ListTile(
          title: Text(project.client.name),
          subtitle: Text("company"),
          leading: Icon(Typicons.vcard),
        ),
        Divider(
          color: Colors.black54,
        ),
      ]);
    }

    detailsList.addAll([
      ListTile(
        title: Text(project.teamSize.toString()),
        subtitle: Text("team size"),
        leading: Icon(Typicons.users_outline),
      ),
      SizedBox(height: 20,)
    ]);

    return Column(
      children: detailsList,
    );
  }
}
