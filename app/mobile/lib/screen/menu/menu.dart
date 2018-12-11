import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/screen/menu/profiles_card.dart';
import 'package:cm_mobile/screen/menu/user_profile.dart';
import 'package:cm_mobile/widget/user_provider.dart';
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
    return ListView(
      children: menuScreenWidget,
    );
  }

  List<Widget>  getMenuScreenWidget(BuildContext context) {
    UserContainerState userContainerState = UserContainer.of(context);
    Privilege privilege = userContainerState.user.privileges;

    List<Widget> menuScreenWidget = [
      Padding(padding: EdgeInsets.only(top: 30.0)),
      MenuProfileCard(),
    ];

    if (privilege == Privilege.ADMIN)
      menuScreenWidget.addAll([MenuProfilesCard()]);
    return menuScreenWidget;
  }
}
