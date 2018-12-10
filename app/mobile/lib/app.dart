import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/authentication_bloc.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:cm_mobile/widget/services_provider.dart';
import 'package:flutter/material.dart';
import 'data/details.dart';
import 'screen/index.dart';
import 'bloc/authentication_bloc.dart';


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
    '/Projects': (BuildContext context) => ForeManProjects(),
    '/AdminProjects': (BuildContext context) => AdminProjectsScreen(),
    '/AdminProfile': (BuildContext context) => AdminProfilesScreen(),
    '/Profile': (BuildContext context) => ProfileScreen(),
    '/AdminStatistics': (BuildContext context) => AdminStatistics(),
    '/foreman/create_receipt': (BuildContext context) => ForeManCreateReceiptScreen(),
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





