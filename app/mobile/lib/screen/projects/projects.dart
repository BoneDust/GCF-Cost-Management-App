import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/project_bloc.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/screen/projects/projects_list.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:flutter/material.dart';

class ProjectsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectsScreenState();
  }
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with AutomaticKeepAliveClientMixin<ProjectsScreen> {

  ProjectsBloc projectsBloc;

  @override
  void initState() {
    projectsBloc  = ProjectsBloc(ApiService());
    projectsBloc.getAllProjects();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<ProjectsBloc>(
      bloc: projectsBloc,
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/foreman/menu");
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
          body: StreamBuilder<List<Project>>(
            key:  PageStorageKey("projects"),
            stream: projectsBloc.outProject,
            builder: (BuildContext context,
                AsyncSnapshot<List<Project>> snapshot) {
              return snapshot.data != null
                  ? ProjectsList(snapshot.data)
                  : Column();
            },
          )
      ),
    );
  }
}