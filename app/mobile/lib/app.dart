import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/user_bloc.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:cm_mobile/widget/services_provider.dart';
import 'package:cm_mobile/widget/user_provider.dart';
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
    '/auth': (BuildContext context) => LoginScreen(),
    '/home': (BuildContext context) => HomeScreen(),
    '/menu': (BuildContext context) => MenuScreen(),
    '/projects': (BuildContext context) => ProjectsScreen(),
    '/profile': (BuildContext context) => ProfileScreen(),
    '/statistics': (BuildContext context) => StatisticsScreen(),
    '/create_receipt': (BuildContext context) => CreateReceiptWidget()
  };

  @override
  Widget build(BuildContext context) {
    return ServicesContainer(
      child: UserContainer(
        child: MaterialApp(
          title: Details.COMPANY_TITLE,
          routes: routes,
          home: _AppRoot(),
        )
      ),
    );
  }
}

class _AppRoot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppRootState();
}

class _AppRootState extends State<_AppRoot> {
  final UserBloc userBloc = UserBloc("1", ApiService());

  @override
  void initState() {
    super.initState();
    userBloc.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: userBloc,
      child: StreamBuilder<User>(
        stream: userBloc.outUser,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          UserContainerState userContainerState = UserContainer.of(context);
          userContainerState.user = snapshot.data;
          return snapshot.data != null
              ? _AppBottomNavigator()
              : Column();
        },
      ),
    );
  }
}

class _AppBottomNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _TabEntry tabEntry = getTabEntry(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: TabBarView(children: tabEntry.children),
          bottomNavigationBar: Material(
            type: MaterialType.card,
            elevation: 20.0,
            child: TabBar(
              tabs: tabEntry.tabs,
              indicatorColor: Colors.red,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.blue,
            ),
          )),
    );
  }

  _TabEntry getTabEntry(BuildContext context) {
    _TabEntry tabEntry = _TabEntry();
    UserContainerState userContainerState = UserContainer.of(context);
    User user = userContainerState.user;

    if (user.privileges == Privilege.ADMIN) {
      tabEntry.children.add(StatisticsScreen());
      tabEntry.tabs.add(Tab(icon: Icon(Icons.trending_up)));
    }

    return tabEntry;
  }
}

class _TabEntry {
  List<Widget> children = [HomeScreen(), ProjectsScreen()];
  List<Tab> tabs = [
    Tab(icon: Icon(Icons.home)),
    Tab(icon: Icon(Icons.assignment)),
  ];
}
