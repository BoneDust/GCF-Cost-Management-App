import 'package:flutter/material.dart';
import 'data/details.dart';
import 'screen/index.dart';

class Route {

  final routes = <String, WidgetBuilder>{
    '/Auth': (BuildContext context) => AuthScreen(),
    '/Home': (BuildContext context) => HomeScreen(),
    '/AdminHome': (BuildContext context) => AdminHomeScreen(),
    '/Projects': (BuildContext context) => ProjectsScreen(),
    '/AdminProjects': (BuildContext context) => AdminProjectsScreen(),
    '/AdminProfile': (BuildContext context) => AdminProfilesScreen(),
    '/Profile': (BuildContext context) => ProfileScreen(),
    '/AdminStatistics': (BuildContext context) => AdminStatistics(),
  };

  Route () {
    runApp(new MaterialApp(
      title: Details.COMPANY_TITLE,
      routes: routes,
      home: new AuthScreen(),
    ));
  }
}