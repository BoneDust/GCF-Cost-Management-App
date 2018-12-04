import 'dart:collection';

import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/screen/foreman/projects/projects_list.dart';
import 'package:flutter/material.dart';

class ForeManProjects extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ProjectsInheritedWidget(
        child: Scaffold(
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

          ),
            body: ProjectsList(),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/foreman/create_receipt");
                  },
                child: ImageIcon(AssetImage("assets/icons/add_receipt.png"))
            )
      )
    );
  }
}


//Inherited Widget is used to pass the collection of projects

class ProjectsInherited extends InheritedWidget {
  ProjectsInherited({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  final ProjectsInheritedWidgetState data;

  @override
  bool updateShouldNotify(ProjectsInherited oldWidget) {
    return true;
  }
}

class ProjectsInheritedWidget extends StatefulWidget {
  ProjectsInheritedWidget({
    Key key,
    this.child,
  }): super(key: key);

  final Widget child;

  @override
  ProjectsInheritedWidgetState createState() => new ProjectsInheritedWidgetState();

  static ProjectsInheritedWidgetState of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(ProjectsInherited) as ProjectsInherited).data;
  }
}

class ProjectsInheritedWidgetState extends State<ProjectsInheritedWidget>{

  HashSet<Project> projects = HashSet<Project>.from([Project(id: 12), Project(id: 13)]);

  int get itemsCount => projects.length;

  void setProjects(HashSet<Project> projects){
    setState((){
      this.projects = projects;
    });
  }

  @override
  Widget build(BuildContext context){
    return new ProjectsInherited(
      data: this,
      child: widget.child,
    );
  }
}
