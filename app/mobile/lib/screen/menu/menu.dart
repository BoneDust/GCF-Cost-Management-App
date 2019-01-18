import 'dart:async';
import 'dart:ui';

import 'package:cm_mobile/bloc/auth_bloc.dart';
import 'package:cm_mobile/data/app_data.dart';
import 'package:cm_mobile/model/auth_state.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/menu/user_profile.dart';
import 'package:cm_mobile/screen/users/add_edit_user_screen.dart';
import 'package:cm_mobile/service/api_auth_service.dart';
import 'package:cm_mobile/util/save_json_file.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:cm_mobile/widget/loading_widget.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MenuScreenState();
  }
}

class MenuScreenState extends State<MenuScreen> {
  bool _isLoading = false;

  AuthBloc authBloc;

  StreamSubscription listener;

  @override
  void initState() {
    authBloc = AuthBloc(AuthApiService());

    listener = authBloc.outLogout.listen(_logoutResult);
    listener.onError(handleError);

    super.initState();
  }
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<Widget> menuScreenWidget = _buildMenuScreenWidget(context);
    return Stack(
      children: <Widget>[
        Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Menu"),
          ),
          body: ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: menuScreenWidget,
          ),
        ),
        _isLoading ? LoadingIndicator() : Column()
      ],
    );
  }

  List<Widget> _buildMenuScreenWidget(BuildContext context) {
    List<Widget> menuScreenWidget = [
      MenuProfileCard(parent: this,),
    ];

    menuScreenWidget.add(Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RaisedButton(
            elevation: 10,
            color: Colors.white,
            child: Text(
              "sign out",
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w600, fontSize: 17),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              User user = AppDataContainer.of(context).user;
              authBloc.logout(user);
            })
      ],
    ));

    return menuScreenWidget;
  }

  void _logoutResult(AuthenticationState result) {
    Navigator.pop(context);
    setState(() {
      _isLoading = false;
    });
    User user = AppDataContainer.of(context).user;
    JsonFileUtil.removeFile(fileName: "auth_token");
    JsonFileUtil.removeFile(fileName: "user");
    JsonFileUtil.deleteFolder(username : user.name);
    AppData.user = null;
    AppDataContainer.of(context).user = null;
    AppDataContainer.of(context)
        .setAuthState(result);
  }

  handleError(error) {
    Navigator.pop(context);
    JsonFileUtil.removeFile(fileName: "auth_token");
    JsonFileUtil.removeFile(fileName: "user");
    User user = AppDataContainer.of(context).user;
    JsonFileUtil.deleteFolder(username : user.name);
    AppData.user = null;

    setState(() {
      _isLoading = false;
    });
    AppDataContainer.of(context)
        .setAuthState(AuthenticationState.unauthenticated());
  }

  navigateAndDisplayEdit(BuildContext context, User user) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddEditUserScreen(
          user: user,
          isEditing: true,
        )));

    if (result is User) {
      setState(() {
        user = result;
      });
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("saved changes"), backgroundColor: Colors.green));
    }
  }

}
