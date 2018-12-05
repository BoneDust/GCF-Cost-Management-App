import 'dart:collection';

import 'package:cm_mobile/bloc/authentication_bloc.dart';
import 'package:cm_mobile/bloc/base_bloc.dart';
import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/project_bloc.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/screen/foreman/projects/projects_list.dart';
import 'package:cm_mobile/widget/services_provider.dart';
import 'package:flutter/material.dart';

class ForeManProjects extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ForeManProjectsState();
  }
}

class _ForeManProjectsState extends State<ForeManProjects>
    with AutomaticKeepAliveClientMixin<ForeManProjects> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final ServicesContainerState servicesContainerState = ServicesContainer.of(
        context);
    final ProjectsBloc projectBloc = ProjectsBloc(
        servicesContainerState.apiService);
    projectBloc.getAllProjects();

    return BlocProvider<ProjectsBloc>(
      bloc: projectBloc,
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
            stream: projectBloc.outProject,
            initialData: List<Project>(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Project>> snapshot) {
              return ProjectsList(snapshot.data);
            },
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, "/foreman/create_receipt");
              },
              child: ImageIcon(AssetImage("assets/icons/add_receipt.png"))
          )
      ),
    );
  }
}