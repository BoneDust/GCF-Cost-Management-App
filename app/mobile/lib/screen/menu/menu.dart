import 'dart:ui';

import 'package:cm_mobile/bloc/auth_bloc.dart';
import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/menu/user_profile.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MenuScreenState();
  }
}

class _MenuScreenState extends State<MenuScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {

    List<Widget> menuScreenWidget = getMenuScreenWidget(context);
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text("Menu"),
          ),
          body:  Column(
            children: menuScreenWidget,
          ),
        ),
        _isLoading ? _loadingIndicator() : Column()
      ],
    );
  }

  List<Widget> getMenuScreenWidget(BuildContext context) {
    List<Widget> menuScreenWidget = [
      MenuProfileCard(),
    ];

    menuScreenWidget.add(RaisedButton(
        elevation: 10,
        color: Colors.white,
        child: Text(
          "sign out",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 17),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        onPressed: () {
          setState(() {
            _isLoading = true;
          });
          AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
          User user = AppDataContainer.of(context).user;
          authBloc.logout(user);
        }));

    return menuScreenWidget;
  }
}

Widget _loadingIndicator() {
  return Stack(
    children: <Widget>[
      Container(
        child:  BackdropFilter(
          filter:  ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child:  Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
          ),
        ),
      ),
      Center(
        child: CircularProgressIndicator(backgroundColor: Colors.green,),
      ),
    ],
  );
}
