import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/project_bloc.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:flutter/material.dart';
import 'index.dart';

class ForeManProjectScreen extends StatelessWidget{
  Project project;

  ForeManProjectScreen(this.project);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: ProjectBloc(project.id.toString()),
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
    ProjectBloc projectBloc = BlocProvider.of<ProjectBloc>(context);

    return StreamBuilder<Project>(
      stream: projectBloc.outProject,
      initialData: Project(),
      builder: (BuildContext context, AsyncSnapshot<Project> snapshot) {
        return NestedScrollView(headerSliverBuilder: (BuildContext context,
            bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(snapshot.data.name),
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
                    StagesCard(snapshot.data.stages),
                    //   Padding(padding: EdgeInsets.only(bottom: 20),),
                    //   ReceiptsCard(),
                    //    Padding(padding: EdgeInsets.only(bottom: 20),),
                    //   DetailsCard(),
                  ],
                )
            )
        );
      },
    );
  }
}


