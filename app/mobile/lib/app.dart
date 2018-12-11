import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/authentication_bloc.dart';
import 'package:cm_mobile/screen/admin/root.dart';
import 'package:cm_mobile/screen/foreman/menu/menu.dart';
import 'package:cm_mobile/screen/foreman/root.dart';
import 'package:cm_mobile/widget/projects/projects.dart';
import 'package:cm_mobile/widget/receipt/create_receipt.dart';
import 'package:cm_mobile/widget/services_provider.dart';
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
  final routes = <String, WidgetBuilder>{
    '/Auth': (BuildContext context) => LoginScreen(),
    '/Home': (BuildContext context) => ForeManHome(),
    '/AdminHome': (BuildContext context) => AdminHomeScreen(),
    '/admin/menu': (BuildContext context) => AdminMenu(),
    '/projects': (BuildContext context) => ProjectsWidget(),
    '/AdminProjects': (BuildContext context) => AdminProjectsScreen(),
    '/AdminProfile': (BuildContext context) => AdminProfilesScreen(),
    '/Profile': (BuildContext context) => ProfileScreen(),
    '/AdminStatistics': (BuildContext context) => AdminStatistics(),
    '/foreman/create_receipt': (BuildContext context) => CreateReceiptWidget(),
    '/foreman/menu': (BuildContext context) => ForeManMenu(),

  };

  @override
  Widget build(BuildContext context) {
    return ServicesContainer(
      child:  MaterialApp(
        title: Details.COMPANY_TITLE,
        routes: routes,
        home: ForeManRoot(),
      ),
    );
  }
}
