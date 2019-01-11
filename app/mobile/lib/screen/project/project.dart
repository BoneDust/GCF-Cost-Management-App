import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/project_bloc.dart';
import 'package:cm_mobile/bloc/stage_bloc.dart';
import 'package:cm_mobile/bloc/user_bloc.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/api_response.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/stage.dart';
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
    return _ProjectWidgetState(project);
  }
}

class _ProjectWidgetState extends State<ProjectWidget> {
  Project project;

  UserBloc userBloc;
  StagesBloc stagesBloc;

  _ProjectWidgetState(this.project);

  @override
  void initState() {
    userBloc = UserBloc(ApiService());
    stagesBloc = StagesBloc(ApiService());

    userBloc.getUser(project.userId);
    stagesBloc.query.add("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                  project.name,
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
        body: _buildProjectScreen());
  }

  Widget _buildProjectScreen() {
    return ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: _buildProjectWidgets());
  }

  List<Widget> _buildProjectWidgets() {
    AppDataContainerState userContainerState = AppDataContainer.of(context);
    Privilege privilege = userContainerState.user.privilege;

    List<Widget> stage = [
      BlocProvider(
        bloc: stagesBloc,
        child: StreamBuilder(
            stream: stagesBloc.results,
            builder: (BuildContext context, AsyncSnapshot<List<Stage>> snapshot) {
              project.stages = snapshot.data;
              return snapshot.data != null
                  ?  StagesWidget(project.stages)
                  : _LoadingWidget();
            }),
      ),
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
    _projectWidgets.add(BlocProvider(
      bloc: userBloc,
      child: StreamBuilder(
          stream: userBloc.outUser,
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            project.foreman = snapshot.data;
            return snapshot.data != null
                ? ProjectDetailsCard(project)
                : _LoadingWidget();
          }),
    ));

    return _projectWidgets;
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
        _navigateAndDisplaySelection(context);
    }
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddEditProjectScreen(
              project: project,
              isEditing: true,
            )));

    if (result is ApiResponse) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text(result.success), backgroundColor: Colors.green));
    }
  }
}
