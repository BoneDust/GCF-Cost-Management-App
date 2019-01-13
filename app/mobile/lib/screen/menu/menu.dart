import 'dart:async';
import 'dart:ui';

import 'package:cm_mobile/bloc/auth_bloc.dart';
import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/model/auth_state.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/menu/user_profile.dart';
import 'package:cm_mobile/service/api_auth_service.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MenuScreenState();
  }
}

class _MenuScreenState extends State<MenuScreen> {
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

  @override
  Widget build(BuildContext context) {
    List<Widget> menuScreenWidget = _buildMenuScreenWidget(context);
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text("Menu"),
          ),
          body: Column(
            children: menuScreenWidget,
          ),
        ),
        _isLoading ? _loadingIndicator() : Column()
      ],
    );
  }

  List<Widget> _buildMenuScreenWidget(BuildContext context) {
    List<Widget> menuScreenWidget = [
      MenuProfileCard(),
    ];

    menuScreenWidget.add(RaisedButton(
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
        }));

    return menuScreenWidget;
  }

  void _logoutResult(AuthenticationState result) {
    Navigator.pop(context);
    setState(() {
      _isLoading = false;
    });
    AppDataContainer.of(context)
        .setAuthState(result);
  }

  handleError(error) {
    Navigator.pop(context);

    setState(() {
      _isLoading = false;
    });
    AppDataContainer.of(context)
        .setAuthState(AuthenticationState.unauthenticated());
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
