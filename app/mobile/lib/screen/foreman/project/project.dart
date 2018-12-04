import 'package:cm_mobile/model/project.dart';
import 'package:flutter/material.dart';
import 'index.dart';

class ForeManProjectScreen extends StatelessWidget{
  Project project;

  ForeManProjectScreen(this.project);

  @override
  Widget build(BuildContext context) {
    return ProjectInheritedWidget(
      child: Scaffold(
        body: _ForeManProject(project),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.pushNamed(context, "/foreman/create_receipt");
        },
          child: ImageIcon(AssetImage("assets/icons/add_receipt.png")),),
      ),
    );
  }
}

class _ForeManProject extends StatelessWidget {
  Project project;

  _ForeManProject(this.project);


  @override
  Widget build(BuildContext context) {
    return NestedScrollView(headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverAppBar(
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(project.name),
            background: Image(
              image: AssetImage("assets/images.jpeg"),
              fit: BoxFit.fill,
            ),
          ),
        )
      ];
    },
        body: Material(
            color: Colors.black12,
            child: ListView(
              padding: EdgeInsets.only(left: 3, right: 3),
              children: <Widget>[
                Padding(padding: EdgeInsets.only(bottom: 20),),
                StagesCard(),
                Padding(padding: EdgeInsets.only(bottom: 20),),
                ReceiptsCard(),
                Padding(padding: EdgeInsets.only(bottom: 20),),
                DetailsCard(),
              ],
            )
        )
    );
  }
}

//Inherited Widget is used to pass the collection of projects

class ProjectInherited extends InheritedWidget {
  ProjectInherited({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  final ProjectInheritedWidgetState data;

  @override
  bool updateShouldNotify(ProjectInherited oldWidget) {
    return true;
  }
}

class ProjectInheritedWidget extends StatefulWidget {
  ProjectInheritedWidget({
    Key key,
    this.child,
  }): super(key: key);

  final Widget child;

  @override
  ProjectInheritedWidgetState createState() => new ProjectInheritedWidgetState();

  static ProjectInheritedWidgetState of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(ProjectInherited) as ProjectInherited).data;
  }
}

class ProjectInheritedWidgetState extends State<ProjectInheritedWidget>{

  Project project = Project();


  void setProject(Project project){
    setState((){
      this.project = project;
    });
  }

  @override
  Widget build(BuildContext context){
    return new ProjectInherited(
      data: this,
      child: widget.child,
    );
  }
}


