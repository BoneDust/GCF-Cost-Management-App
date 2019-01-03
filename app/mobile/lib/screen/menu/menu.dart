import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/auth_state.dart';
import 'package:cm_mobile/screen/menu/user_profile.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    return Column(
      children: menuScreenWidget,
    );
  }

  List<Widget> getMenuScreenWidget(BuildContext context) {
    AppDataContainerState appDataContainerState = AppDataContainer.of(context);
//    Privilege privilege = appDataContainerState.user.privilege;

    List<Widget> menuScreenWidget = [
      MenuProfileCard(),
    ];

//    if (privilege == Privilege.ADMIN)
//      menuScreenWidget.addAll(
//          [Padding(padding: EdgeInsets.only(top: 30.0)), MenuProfilesCard()]);

    menuScreenWidget.add(RaisedButton(
      elevation: 10,
        color: Colors.white,
        child: Text("sign out", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 17),),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        onPressed: () {
          Navigator.of(context).pop();
          appDataContainerState.setAuthState(AuthenticationState(
              isInitializing: false, isLoading: false, isAuthenticated: false));
        }));
    return menuScreenWidget;
  }
}
