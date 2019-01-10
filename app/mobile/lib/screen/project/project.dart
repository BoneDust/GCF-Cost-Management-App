import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/project_bloc.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/project/add_edit_project.dart';
import 'package:cm_mobile/screen/project/overview.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
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
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: buildBodyWithStreamer(),
      floatingActionButton: Theme(
          data: themeData.copyWith(accentColor: Colors.white),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, "/add_receipt");
            },
            child: Icon(
              Typicons.doc_add,
              color: Colors.green,
            ),
          )),
    );
  }

  Widget buildBodyWithStreamer() {
    AppDataContainerState userContainerState = AppDataContainer.of(context);
    User user = userContainerState.user;

    return StreamBuilder<Project>(
      stream: projectBloc.outProject,
      builder: (BuildContext context, AsyncSnapshot<Project> snapshot) {
        return NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              List<Widget> appBarActions = [];
              if (user.privilege == Privilege.ADMIN)
                appBarActions.add(_ProjectPopMenuButton(
                  project: project,
                ));
              return <Widget>[
                SliverAppBar(
                  actions: appBarActions,
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    title: Text(
                      snapshot != null && snapshot.data != null
                          ? snapshot.data.name
                          : "",
                      overflow: TextOverflow.fade,
                    ),
                    background: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          color: Colors.grey,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            // Where the linear gradient begins and ends
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            // Add one stop for each color. Stops should increase from 0 to 1
                            stops: [0.1, 0.4, 0.5, 1],
                            colors: [
                              // Colors are easy thanks to Flutter's Colors class.
                              Colors.white10,
                              Colors.white24,
                              Colors.white30,
                              Colors.white,
                            ],
                          )),
                        )
                      ],
                    ),
                  ),
                )
              ];
            },
            body: (snapshot != null && snapshot.data != null
                ? _ProjectScreen(snapshot.data)
                : _LoadingWidget()));
      },
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.green,
      ),
    );
  }
}

class _ProjectScreen extends StatelessWidget {
  final Project project;

  const _ProjectScreen(this.project);

  @override
  Widget build(BuildContext context) {
    List<Widget> _projectWidgets = _buildProjectWidgets(context);

    return ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: _projectWidgets);
  }

  List<Widget> _buildProjectWidgets(BuildContext context) {
    AppDataContainerState userContainerState = AppDataContainer.of(context);
    Privilege privilege = userContainerState.user.privilege;

    List<Widget> stage = [
      StagesWidget(project.stages),
      Padding(
        padding: EdgeInsets.only(bottom: 20),
      ),
    ];

    List<Widget> receipt = [
      ReceiptsWidget(project.receipts),
      Padding(
        padding: EdgeInsets.only(bottom: 20),
      ),
    ];

    List<Widget> _projectWidgets = [];

    if (privilege == Privilege.ADMIN) {
      _projectWidgets.addAll([
        FinancialOverviewCard(project),
        Padding(
          padding: EdgeInsets.only(bottom: 20),
        ),
      ]);
      _projectWidgets.addAll(receipt);
      _projectWidgets.addAll(stage);
    } else {
      _projectWidgets.addAll(stage);
      _projectWidgets.addAll(receipt);
    }
    _projectWidgets.add(
      DetailsCard(project),
    );

    return _projectWidgets;
  }
}

class _ProjectPopMenuButton extends StatelessWidget {
  final Project project;

  const _ProjectPopMenuButton({Key key, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        onSelected: (value) {
          onItemClicked(value, context);
        },
        itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                child: Text("Edit"),
                value: "Edit",
              ),
              PopupMenuItem<String>(child: Text("Remove"), value: "Remove"),
            ]);
  }

  void onItemClicked(String value, BuildContext context) {
    switch (value) {
      case "Edit":
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddEditProjectScreen(
                  project: project,
                  isEditing: true,
                )));
    }
  }
}
