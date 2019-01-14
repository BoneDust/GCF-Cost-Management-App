import 'dart:async';
import 'dart:collection';

import 'package:cm_mobile/data/app_colors.dart';
import 'package:cm_mobile/data/mode_cache.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/client/add_client_screen.dart';
import 'package:cm_mobile/screen/project/projects_screen.dart';
import 'package:cm_mobile/screen/receipt/all_receipts.dart';
import 'package:cm_mobile/screen/stage/add_edit_stage.dart';
import 'package:cm_mobile/screen/users/add_edit_user_screen.dart';
import 'package:cm_mobile/util/model_from_json.dart';
import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';
import 'data/details.dart';
import 'screen/index.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _App();
  }
}

class _App extends State<App> {
  _App(){
    ModelJsonFileUtil.getAll<Project>().then(onValue).catchError(onError);
  }
  @override
  Widget build(BuildContext context) {
    return AppDataContainer(child: _MaterialApp());
  }

  void onValue(List<Project> value) {
    ModelCache.projects = value;
  }

  onError(error) {
    ModelCache.projects = [];

  }
}


class _MaterialApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    '/auth': (BuildContext context) => AuthScreen(),
    '/add_stage': (BuildContext context) => AddEditStageScreen(),
    '/add_receipt': (BuildContext context) => AddEditReceiptScreen(),
    '/all_receipts': (BuildContext context) => AllReceiptsScreen(),
    '/home': (BuildContext context) => HomeScreen(),
    '/create_users': (BuildContext context) => AddEditUserScreen(),
    '/create_client': (BuildContext context) => AddEditClientScreen(),
    '/menu': (BuildContext context) => MenuScreen(),
    '/projects': (BuildContext context) => ProjectsScreen(),
    '/statistics': (BuildContext context) => StatisticsScreen(),
  };

  @override
  Widget build(BuildContext context) {

    AppDataContainerState dataContainerState = AppDataContainer.of(context);

    return MaterialApp(
      title: Details.COMPANY_TITLE,
      routes: routes,
      theme: ThemeData(
        primaryColorBrightness: Brightness.light,
        fontFamily: 'OpenSans',

//          // Define the default Brightness and Colors
//          brightness: Brightness.light,

        primaryColorDark: AppColors.darkPrimaryColor,
        primaryColorLight: AppColors.primaryColor,
        primaryColor: AppColors.primaryColor,
        accentColor: AppColors.accentColor,
        primaryTextTheme: TextTheme(
            title: TextStyle(color: AppColors.primaryText),
            subhead: TextStyle(color: AppColors.primaryText),
            body1: TextStyle(color: AppColors.primaryText)),

        iconTheme: IconThemeData(
          color: AppColors.textIconsColor,
        ),
        buttonTheme: ButtonThemeData(
          highlightColor: AppColors.accentColor,
        ),
        primaryIconTheme: IconThemeData(color: AppColors.textIconsColor),
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0),
        ),
      ),
      home: dataContainerState.authState.isAuthenticated
          ? _AppBottomNavigator()
          : AuthScreen(),
    );
  }
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _AppBottomNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _TabEntry tabEntry = getTabEntry(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          key: _scaffoldKey,
          body: TabBarView(
              children: tabEntry.children,
              physics: NeverScrollableScrollPhysics()),
          bottomNavigationBar: Material(
            type: MaterialType.card,
            elevation: 20.0,
            child: TabBar(
              tabs: tabEntry.tabs,
              indicatorColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.green,
            ),
          )),
    );
  }

  _TabEntry getTabEntry(BuildContext context) {
    _TabEntry tabEntry = _TabEntry();
    AppDataContainerState userContainerState = AppDataContainer.of(context);
    User user = userContainerState.user;

    if (user.privilege == Privilege.ADMIN) {
      tabEntry.children.add(StatisticsScreen());
      tabEntry.tabs.add(Tab(
        icon: Icon(Typicons.chart_bar_outline),
        text: "stats",
      ));
    }

    return tabEntry;
  }
}

class _TabEntry {
  List<Widget> children = [];
  List<Tab> tabs = [];

  _TabEntry() {
    children = [HomeScreen(), ProjectsScreen()];
    tabs = [
      Tab(icon: Icon(Typicons.home_outline), text: "home"),
      Tab(
        icon: Icon(
          Typicons.clipboard,
        ),
        text: "projects",
      ),
    ];
  }
}
