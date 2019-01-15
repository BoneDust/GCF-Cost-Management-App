import 'dart:async';

import 'package:cm_mobile/bloc/generic_bloc.dart';
import 'package:cm_mobile/enums/model_status.dart';
import 'package:cm_mobile/model/client.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/screen/client/add_client_screen.dart';
import 'package:cm_mobile/screen/client/client_details_card.dart';
import 'package:cm_mobile/screen/project/project_tile.dart';
import 'package:cm_mobile/widget/loading_widget.dart';
import 'package:flutter/material.dart';

class ClientScreen extends StatefulWidget {
  final Client client;

  const ClientScreen({Key key, @required this.client}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ClientScreenState(client: client);
  }
}

class ClientScreenState extends State<ClientScreen> {
  Client client;

  GenericBloc<Client> clientBloc;
  bool _isLoading = false;

  String _loadingText;
  StreamSubscription outDeletedListener;

  ModelStatusType status = ModelStatusType.UNCHANGED;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ClientScreenState({this.client});

  @override
  void initState() {
    clientBloc = GenericBloc<Client>();

    outDeletedListener = clientBloc.outDeletedItem.listen((isDeleted) {
      if (isDeleted) status = ModelStatusType.DELETED;
      _exitScreen();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        WillPopScope(
          child: Scaffold(
            key: _scaffoldKey,
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    actions: <Widget>[_PopMenuButton()],
                    expandedHeight: 250.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(client.name),
                      centerTitle: false,
                      background: Image(
                        image: AssetImage("assets/images.jpeg"),
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
                  _ClientProjectsCard(),
                  ClientDetailsCard(client: client),
                ],
              ),
            ),
          ),
          onWillPop: _onWillPop,
        ),
        _isLoading ? LoadingIndicator(text: _loadingText) : Column()
      ],
    );
  }

  Widget _PopMenuButton() {
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
        builder: (context) => AddEditClientScreen(
              client: client,
              isEditing: true,
            )));

    if (result is Client) {
      setState(() {
        client = result;
      });
      status = ModelStatusType.UPDATED;
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("client saved"), backgroundColor: Colors.green));
    }
  }

  void _removeUser([bool prompt = true]) {
    void remove() {
      setState(() {
        _isLoading = true;
        _loadingText = "removing client";
      });
      clientBloc.delete(client.id);
    }

    if (prompt)
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("delete client?"),
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

  void _exitScreen() {
    ModelStatus modelStatus = ModelStatus(status: status, model: client);

    Navigator.of(context).pop(modelStatus);
  }

  Future<bool> _onWillPop() async {
    _exitScreen();
    return false;
  }

  @override
  void dispose() {
    outDeletedListener.cancel();
    super.dispose();
  }
}

class _ClientProjectsCard extends StatelessWidget {
  GenericBloc<Project> projectsBloc;

  _ClientProjectsCard() {
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
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: snapshot.data.take(3).map((client) {
                return BasicProjectTile(
                  project: client,
                );
              }).toList(),
            )
          ],
        );
      },
    );
  }
}
