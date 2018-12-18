import 'package:cm_mobile/bloc/auth_bloc.dart';
import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/auth_state.dart';
import 'package:cm_mobile/screen/menu/profiles_card.dart';
import 'package:cm_mobile/screen/menu/user_profile.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: _MenuScreen(),
    );
  }
}

class _MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> menuScreenWidget = getMenuScreenWidget(context);
    return ListView(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      children: menuScreenWidget,
    );
  }

  List<Widget> getMenuScreenWidget(BuildContext context) {
    AppDataContainerState appDataContainerState = AppDataContainer.of(context);
    Privilege privilege = appDataContainerState.user.privilege;

    List<Widget> menuScreenWidget = [
      Padding(padding: EdgeInsets.only(top: 30.0)),
      MenuProfileCard(),
    ];

    if (privilege == Privilege.ADMIN)
      menuScreenWidget.addAll(
          [Padding(padding: EdgeInsets.only(top: 30.0)), MenuProfilesCard()]);

    menuScreenWidget.add(RaisedButton(child : Text("Sign out"),onPressed: (){
      Navigator.of(context).pop();
      appDataContainerState.setAuthState(AuthenticationState(isInitializing: false, isLoading: false, isAuthenticated: false));
    }));
    return menuScreenWidget;
  }
}
