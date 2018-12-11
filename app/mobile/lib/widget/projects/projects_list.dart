import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/widget/projects/project_container.dart';
import 'package:flutter/cupertino.dart';

class ProjectsList extends StatelessWidget {
  final List<Project> projects;

  ProjectsList(this.projects);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
              itemCount: projects.length,
              padding: EdgeInsets.only(bottom: 30, top: 30),
              itemBuilder: (BuildContext context, int index) {
                Project project = projects.elementAt(index);
                return ProjectContainer(
                    project: project
                );
              },
            )),
      ],
    );
  }

}
