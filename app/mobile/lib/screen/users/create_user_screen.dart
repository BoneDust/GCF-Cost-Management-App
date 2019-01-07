import 'dart:ui';

import 'package:cm_mobile/bloc/user_bloc.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/users/form_fields.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:flutter/material.dart';

class CreateUserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateUserScreenState();
  }
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  bool _isLoading = false;
  UsersBloc userBlocs;

  @override
  void initState() {
    userBlocs = UsersBloc(ApiService());
    userBlocs.query.add("");

    userBlocs.outAddedProject
        .listen((user) => finishedAddingUser(user));

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
                        userBlocs.addUser(User());
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
                  delegate: SliverChildListDelegate([FormFields()]),
                ),
              )
            ],
          ),
        ),
        _isLoading ? _loadingIndicator() : Column()

      ],
    );
  }

  void finishedAddingUser(User user) {
    setState(() {
      _isLoading = false;
    });
    if (user != null) Navigator.of(context).pop();
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