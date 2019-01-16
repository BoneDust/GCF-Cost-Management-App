import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cm_mobile/bloc/generic_bloc.dart';
import 'package:cm_mobile/enums/model_status.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/project/project_tile.dart';
import 'package:cm_mobile/screen/project/projects_screen.dart';
import 'package:cm_mobile/screen/users/add_edit_user_screen.dart';
import 'package:cm_mobile/screen/users/user_details_card.dart';
import 'package:cm_mobile/widget/loading_widget.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  final User user;

  const UserScreen({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UserScreen(user: user);
  }
}

class _UserScreen extends State<UserScreen> {
  User user;
  GenericBloc<User> userBloc;
  bool _isLoading = false;

  String _loadingText;
  StreamSubscription outProjectDeletedListener;

  ModelStatusType status = ModelStatusType.UNCHANGED;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _UserScreen({@required this.user});

  @override
  void initState() {
    userBloc = GenericBloc<User>();

    outProjectDeletedListener = userBloc.outDeletedItem.listen((isDeleted) {
      if (isDeleted) status = ModelStatusType.DELETED;
      _exitScreen();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Stack(
      children: <Widget>[

        WillPopScope(child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  actions: <Widget>[_projectPopMenuButton()],
                  expandedHeight: 250.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(user.name + " " + user.surname),
                    centerTitle: false,
                    background:  CachedNetworkImage(
                      imageUrl: user.image,
                      placeholder:  Text("loading picture...", style: TextStyle(color: themeData.primaryTextTheme.display1.color)),
                      errorWidget:  Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ];
            },
            body: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              children: <Widget>[
                user.privilege == Privilege.FOREMAN ? UserProjectsCard() : Column(),
                UserDetailsCard(user: user),
              ],
            ),
          ),
        ), onWillPop: _onWillPop),
        _isLoading ? LoadingIndicator(text: _loadingText) : Column()

      ],
    );
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
        _removeUser();
    }
  }

  _navigateAndDisplayEdit(BuildContext context) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddEditUserScreen(
              user: user,
              isEditing: true,
            )));

    if (result is User) {
      setState(() {
        user = result;
      });
      status = ModelStatusType.UPDATED;
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("project saved"), backgroundColor: Colors.green));
    }
  }

  void _removeUser([bool prompt = true]) {
    void remove() {
      setState(() {
        _isLoading = true;
        _loadingText = "removing user";
      });
      userBloc.delete(user.id);
    }

    if (prompt)
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("delete user?"),
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
    _exitScreen();
    return false;
  }

  void _exitScreen() {
    ModelStatus modelStatus = ModelStatus(status: status, model: user);

    Navigator.of(context).pop(modelStatus);
  }

  @override
  void dispose() {
    outProjectDeletedListener.cancel();
    super.dispose();
  }
}

class UserProjectsCard extends StatelessWidget {
  GenericBloc<Project> projectsBloc;

  UserProjectsCard() {
    projectsBloc = GenericBloc<Project>();
    projectsBloc.getAll();
  }
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return StreamBuilder(
      stream: projectsBloc.outItems,
      initialData: <Project>[],
      builder: (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: 20),
              child: Text(
                "projects",
                style: TextStyle(color: themeData.primaryTextTheme.display1.color, fontSize: 30),
              ),
            ),
            _buildProjectList(context, snapshot.data)
          ],
        );
      },
    );
  }

  _buildProjectList(BuildContext context, List<Project> projects) {
    List<Widget> _children = [];
    ThemeData themeData = Theme.of(context);

    if (projects != null) {
      _children.addAll([
        projects.isEmpty
            ? Center(
          child: Text(
            "no projects yet",
            style: TextStyle(fontSize: 20, color: themeData.primaryTextTheme.display1.color),
          ),
        )
            : Column(
          children: <Widget>[
            Column(
              children: projects.take(3).map((project) {
                return BasicProjectTile(project: project,);
              }).toList(),
            )
          ],
        ),
      ]);

      if (projects.length > 3)
        _children.add(Center(
          child: FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProjectsScreen()));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.keyboard_arrow_down),
                  Text("more projects")
                ],
              )),
        ));
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _children,
    );
  }
}
