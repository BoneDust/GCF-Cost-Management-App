import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/authentication_bloc.dart';
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
  final AuthenticationBloc _authenticationBloc = AuthenticationBloc();

  final routes = <String, WidgetBuilder>{
    '/Auth': (BuildContext context) => LoginScreen(),
    '/Home': (BuildContext context) => ForeManHome(),
    '/AdminHome': (BuildContext context) => AdminHomeScreen(),
    '/Projects': (BuildContext context) => ForeManProjects(),
    '/AdminProjects': (BuildContext context) => AdminProjectsScreen(),
    '/AdminProfile': (BuildContext context) => AdminProfilesScreen(),
    '/Profile': (BuildContext context) => ProfileScreen(),
    '/AdminStatistics': (BuildContext context) => AdminStatistics(),
    '/foreman/project' : (BuildContext context) => ForeManProjectScreen(),
  };

  _App() {
    _authenticationBloc.onAppStart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: _authenticationBloc,
      child: MaterialApp(
        title: Details.COMPANY_TITLE,
        routes: routes,
        home: ForeManTabView(),
      ),
    );
  }

//  Widget _rootPage() {
//    return BlocBuilder<AuthenticationEvent, AuthenticationState>(
//      bloc: _authenticationBloc,
//      builder: (BuildContext context, AuthenticationState state) {
//        List<Widget> widgets = [];
//
//        if (state.isAuthenticated) {
//          widgets.add(HomePage());
//        } else {
//          widgets.add(LoginPage());
//        }
//
//        if (state.isInitializing) {
//          widgets.add(SplashPage());
//        }
//
//        if (state.isLoading) {
//          widgets.add(_loadingIndicator());
//        }
//
//        return Stack(
//          children: widgets,
//        );
//      },
//    );
//  }
//
//  Widget _loadingIndicator() {
//    return Stack(
//      children: <Widget>[
//        Opacity(
//          opacity: 0.3,
//          child: ModalBarrier(dismissible: false, color: Colors.grey),
//        ),
//        Center(
//          child: CircularProgressIndicator(),
//        ),
//      ],
//    );
//  }
}





