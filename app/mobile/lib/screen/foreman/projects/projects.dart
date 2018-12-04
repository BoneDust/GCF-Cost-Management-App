import 'dart:collection';

import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/screen/foreman/projects/projects_list.dart';
import 'package:flutter/material.dart';

class ForeManProjects extends StatelessWidget{
  HashSet<Project> projects = HashSet < Project

  >

      .

  from

  (

  [

  Project

  (

  id

      :

  12

  )

  ,

  Project

  (

  id

      :

  13

  )

  ,

  Project

  (

  id

      :

  17

  )

  ,

  Project

  (

  id

      :

  10

  )

  ]

  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ProjectStateContainer(
        child: ForeManProjectsView(), projects: projects);
  }

}

class ForeManProjectsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProjectStateContainerState projectStateContainer = ProjectStateContainer.of(
        context);

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/foreman/menu");
                },
                child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/images.jpeg"),
                            fit: BoxFit.cover
                        )
                    )
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 10),),
              Text("Projects")
            ],
          ),

        ) ,
        body: ProjectsList(),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.pushNamed(context, "/foreman/create_receipt");
        },
          child: ImageIcon(AssetImage("assets/icons/add_receipt.png")),)
    );
  }
}


class ProjectStateContainer extends StatefulWidget {
  final Widget child;
  HashSet<Project> projects = HashSet < Project

  >

      .

  from

  (

  [

  Project

  (

  id

      :

  12

  )

  ,

  Project

  (

  id

      :

  13

  )

  ,

  Project

  (

  id

      :

  17

  )

  ,

  Project

  (

  id

      :

  10

  )

  ]

  );

  ProjectStateContainer({
    @required this.child,
    this.projects,
  });

  static ProjectStateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
    as _InheritedStateContainer)
        .data;
  }

  @override
  ProjectStateContainerState createState() => new ProjectStateContainerState();
}

class ProjectStateContainerState extends State<ProjectStateContainer> {
  HashSet<Project> projects = HashSet < Project

  >

      .

  from

  (

  [

  Project

  (

  id

      :

  12

  )

  ,

  Project

  (

  id

      :

  13

  )

  ,

  Project

  (

  id

      :

  17

  )

  ,

  Project

  (

  id

      :

  10

  )

  ]

  );

  void updateUserInfo(HashSet<Project> projects) {
    setState(() {
      this.projects = projects;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final ProjectStateContainerState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}