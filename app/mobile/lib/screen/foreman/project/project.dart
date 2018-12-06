import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/project_bloc.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:cm_mobile/widget/services_provider.dart';
import 'package:flutter/material.dart';
import 'index.dart';

class ForeManProjectScreen extends StatefulWidget {
  Project project;

  ForeManProjectScreen(this.project);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ForeManProjectScreenState(project);
  }

}
class _ForeManProjectScreenState extends State<ForeManProjectScreen>{
  Project project;

  _ForeManProjectScreenState(this.project);

  ProjectBloc projectBloc;

  @override
  void initState() {
    projectBloc  = ProjectBloc(project.id.toString(), ApiService());
    projectBloc.getProject();
    print("it was ran");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: Key("bloc"),
      bloc: projectBloc,
      child: Scaffold(
        body: _ForeManProject(),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.pushNamed(context, "/foreman/create_receipt");
        },
          child: ImageIcon(AssetImage("assets/icons/add_receipt.png")),),
      ),
    );
  }
}

class _ForeManProject extends StatelessWidget {

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
                    Padding(padding: EdgeInsets.only(bottom: 20),),
                    ReceiptsCard(snapshot.data.receipts),
                    Padding(padding: EdgeInsets.only(bottom: 20),),
                    DetailsCard(snapshot.data),
                  ],
                )
            )
        );
      },
    );
  }
}


