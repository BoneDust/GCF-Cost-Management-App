import 'dart:ui';

import 'package:cm_mobile/bloc/client_bloc.dart';
import 'package:cm_mobile/model/client.dart';
import 'package:cm_mobile/screen/client/form_fields.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:flutter/material.dart';

class AddClientScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddClientScreenState();
  }
}

class _AddClientScreenState extends State<AddClientScreen> {
  bool _isLoading = false;
  ClientsBloc clientsBloc;

  @override
  void initState() {
    clientsBloc = ClientsBloc(ApiService());
    clientsBloc.query.add("");

    clientsBloc.outAddedClient
        .listen((client) => finishedAddingUser(client));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              new SliverAppBar(
                actions: <Widget>[
                  FlatButton(
                      child: Text(
                        "CREATE",
                      ),
                      shape: CircleBorder(),
                      onPressed: () {
                        setState(() {
                          _isLoading = true;
                        });
                        clientsBloc.addClient(Client());
                      })
                ],
                elevation: 5,
                forceElevated: true,
                pinned: true,
                flexibleSpace: new FlexibleSpaceBar(
                  title: Text("add new user"),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(5.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([ClientFormFields()]),
                ),
              )
            ],
          ),
        ),
        _isLoading ? _loadingIndicator() : Column()

      ],
    );
  }

  void finishedAddingUser(Client client) {
    setState(() {
      _isLoading = false;
    });
    if (client != null) Navigator.of(context).pop();
  }
}

Widget _loadingIndicator() {
  return Stack(
    children: <Widget>[
      Container(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
          ),
        ),
      ),
      Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.green,
        ),
      ),
    ],
  );
}