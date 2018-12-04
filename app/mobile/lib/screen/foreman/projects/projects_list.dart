import 'dart:collection';

import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/screen/foreman/projects/project_container.dart';
import 'package:cm_mobile/screen/foreman/projects/projects.dart';
import 'package:flutter/cupertino.dart';

class ProjectsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProjectStateContainerState projectStateContainer =
        ProjectStateContainer.of(context);

    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
          padding: EdgeInsets.only(bottom: 30, top: 30),
          itemBuilder: (BuildContext context, int index) {
            return ProjectContainer(
              project: projectStateContainer.projects.elementAt(index),
            );
          },
        )),
      ],
    );
  }
}
