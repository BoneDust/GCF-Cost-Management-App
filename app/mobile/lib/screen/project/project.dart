import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/project_bloc.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:cm_mobile/widget/services_provider.dart';
import 'package:cm_mobile/widget/user_provider.dart';
import 'package:flutter/material.dart';
import 'index.dart';

class ProjectWidget extends StatefulWidget {
  final Project project;

  ProjectWidget(this.project);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProjectWidgetState(project);
  }
}

class _ProjectWidgetState extends State<ProjectWidget> {
  Project project;
  _ProjectWidgetState(this.project);
  ProjectBloc projectBloc;


  @override
  void initState() {
    projectBloc = ProjectBloc(project.id.toString(), ApiService());
    projectBloc.getProject();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: Key("bloc"),
      bloc: projectBloc,
      child: buildBody(),
    );
  }

  Widget buildBody() {
    return Scaffold(
      body: buildBodyWithStreamer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/create_receipt");
        },
        child: ImageIcon(AssetImage("assets/icons/add_receipt.png")),
      ),
    );
  }

  Widget buildBodyWithStreamer() {
    UserContainerState userContainerState = UserContainer.of(context);
    User user = userContainerState.user;

    return StreamBuilder<Project>(
      stream: projectBloc.outProject,
      builder: (BuildContext context, AsyncSnapshot<Project> snapshot) {
        return NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              List<Widget> appBarActions = [];
              if (user.privileges == Privilege.ADMIN)
                appBarActions.add( _ProjectPopMenuButton());
              return <Widget>[
                SliverAppBar(
                  actions: appBarActions,
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(snapshot != null && snapshot.data != null
                        ? snapshot.data.name
                        : ""),
                    background: Image(
                      image: AssetImage("assets/images.jpeg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              ];
            },
            body: (snapshot != null && snapshot.data != null
                ? _ProjectScreen(snapshot.data)
                : Column()));
      },
    );

  }
}

class _ProjectScreen extends StatelessWidget {
  final Project project;

  const _ProjectScreen(this.project);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
        color: Colors.black12,
        child: ListView(
          padding: EdgeInsets.only(left: 3, right: 3),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20),
            ),
            StagesWidget(project.stages),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
            ),
            ReceiptsWidget(project.receipts),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
            ),
            DetailsCard(project),
          ],
        ));
  }
}

class _ProjectPopMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(child: Text("Edit"), value: "Edit"),
              PopupMenuItem<String>(child: Text("Remove"), value: "Remove"),
            ]);
  }
}
