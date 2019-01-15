import 'dart:async';

import 'package:cm_mobile/bloc/generic_bloc.dart';
import 'package:cm_mobile/enums/model_status.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/client.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/project/add_edit_project.dart';
import 'package:cm_mobile/screen/project/overview.dart';
import 'package:cm_mobile/screen/receipt/add_edit_receipt.dart';
import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:cm_mobile/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'index.dart';

class ProjectWidget extends StatefulWidget {
  final Project project;

  ProjectWidget({this.project});

  @override
  State<StatefulWidget> createState() {
    return ProjectWidgetState(project);
  }
}

class ProjectWidgetState extends State<ProjectWidget> {
  Project project;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GenericBloc<User> userBloc;
  GenericBloc<Stage> stagesBloc;
  GenericBloc<Client> clientBloc;
  GenericBloc<Project> projectBloc;
  GenericBloc<Receipt> receiptBloc;

  bool _isLoading = false;

  String _loadingText;

  ModelStatusType status = ModelStatusType.UNCHANGED;


  ProjectWidgetState(this.project);
  StreamSubscription outProjectDeletedListener;
  StreamSubscription outUserListener;
  StreamSubscription outClientListener;
  StreamSubscription outStagesListener;
  StreamSubscription outReceiptsListener;

  @override
  void initState() {
    userBloc = GenericBloc<User>();
    stagesBloc = GenericBloc<Stage>();
    clientBloc = GenericBloc<Client>();
    projectBloc = GenericBloc<Project>();
    receiptBloc = GenericBloc<Receipt>();

    outProjectDeletedListener = projectBloc.outDeletedItem.listen((isDeleted) {
      if (isDeleted) status = ModelStatusType.DELETED;
      _exitProjectScreen();
    });
    outProjectDeletedListener.onError(onDeleteError);
    outUserListener = userBloc.outItem.listen((user) {
      setState(() {
        project.foreman = user;
      });
    });

    outClientListener = clientBloc.outItem.listen((client) {
      setState(() {
        project.client = client;
      });
    });

    outStagesListener = stagesBloc.outItemsByProject.listen((stages) {
      setState(() {
        project.stages = stages;
      });
    });

    outReceiptsListener = receiptBloc.outItemsByProject.listen((receipts) {
      setState(() {
        project.receipts = receipts;
      });
    });


    userBloc.get(project.userId);
    clientBloc.get(project.clientId);
    stagesBloc.getByProject(project.id);
    receiptBloc.getByProject(project.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        WillPopScope(
            child: Scaffold(
              key: _scaffoldKey,
              body: buildBodyWithStreamer(),
              floatingActionButton: _buildFloatingActionButton(),
            ),
            onWillPop: _onWillPop),
        _isLoading ? LoadingIndicator(text: _loadingText) : Column()
      ],
    );
  }

  Widget buildBodyWithStreamer() {
    AppDataContainerState userContainerState = AppDataContainer.of(context);
    User user = userContainerState.user;
    ThemeData themeData = Theme.of(context);

    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          List<Widget> appBarActions = [];
          if (user.privilege == Privilege.ADMIN)
            appBarActions.add(_projectPopMenuButton());
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
                        stops: [0.1, 0.3, 0.4, 1],
                        colors: [
                          // Colors are easy thanks to Flutter's Colors class.
                          themeData.primaryColor.withAlpha(100),
                          themeData.primaryColor.withAlpha(60),
                          themeData.primaryColor.withAlpha(23),
                          themeData.primaryColor,
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

    List<Widget> stage = [StagesWidget(project, this)];

    List<Widget> receipt = [
      ReceiptsWidget(receipts: project.receipts),
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
    _projectWidgets.add(ProjectDetailsCard(project));

    return _projectWidgets;
  }

  Widget _projectPopMenuButton() {
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
        _navigateAndDisplayEdit(context);
        break;
      case "Remove":
        _removeProject();
    }
  }

  _navigateAndDisplayEdit(BuildContext context) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddEditProjectScreen(
              project: project,
              isEditing: true,
            )));

    if (result is Project) {
      setState(() {
        project = result;
      });
      status = ModelStatusType.UPDATED;
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("project saved"), backgroundColor: Colors.green));
    }
  }

  void _removeProject([bool prompt = true]) {

    void remove(){
      setState(() {
        _isLoading = true;
        _loadingText = "removing project";
      });
      projectBloc.delete(project.id);
    }

    if (prompt)
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("delete project?"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("no")),
                FlatButton(

                    onPressed: () {
                      Navigator.pop(context);
                      remove();
                    },
                    child: Text("yes"))
              ],
            );
          });
    else
      remove();

  }

  Future<bool> _onWillPop() async {
    _exitProjectScreen();
    return false;
  }

  @override
  void dispose() {
    outProjectDeletedListener.cancel();
    outUserListener.cancel();
    outClientListener.cancel();
    outStagesListener.cancel();
    outReceiptsListener.cancel();
    super.dispose();
  }

  void _exitProjectScreen() {
    ModelStatus modelStatus = ModelStatus(status: status, model: project);

    Navigator.of(context).pop(modelStatus);
  }

  Widget _buildFloatingActionButton() {
    ThemeData themeData = Theme.of(context);

    return Theme(
        data: themeData.copyWith(accentColor: Colors.white),
        child: FloatingActionButton(
          onPressed: () {
            _navigateAndDisplayProject();          },
          child: Icon(
            Typicons.doc_add,
            color: Colors.green,
          ),
        ));
  }


  _navigateAndDisplayProject() async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddEditReceiptScreen(
            isEditing: true,
            project : widget.project
        )));

    if (result is Receipt) {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("receipt created"), backgroundColor: Colors.green));

      setState(() {
        widget.project.receipts.insert(0, result);
      });

    }
  }

  onDeleteError(error) {
    setState(() {
      _isLoading = false;
    });

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("$error"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _removeProject(false);
                  },
                  child: Text("try again")),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("dismiss"))
            ],
          );
        });
  }
}
