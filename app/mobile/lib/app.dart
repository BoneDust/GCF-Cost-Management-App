import 'package:cm_mobile/bloc/activity_bloc.dart';
import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/receipt_bloc.dart';
import 'package:cm_mobile/bloc/user_bloc.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/activity/activities.dart';
import 'package:cm_mobile/screen/project/add_project.dart';
import 'package:cm_mobile/screen/project/edit_project.dart';
import 'package:cm_mobile/screen/receipt/all_receipts.dart';
import 'package:cm_mobile/screen/stage/add_stage.dart';
import 'package:cm_mobile/screen/users/create_user_screen.dart';
import 'package:cm_mobile/screen/users/users.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:cm_mobile/widget/services_provider.dart';
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
  final routes = <String, WidgetBuilder>{
    '/auth': (BuildContext context) => LoginScreen(),
    '/activities': (BuildContext context) => ActivitiesScreen(),
    '/add_stage': (BuildContext context) => AddStageScreen(),
    '/add_project': (BuildContext context) => AddProjectScreen(),
    '/add_receipt': (BuildContext context) => AddReceiptScreen(),
    '/all_receipts': (BuildContext context) => AllReceiptsScreen(),
    '/edit_project': (BuildContext context) => EditProjectScreen(),
    '/home': (BuildContext context) => HomeScreen(),
    '/users': (BuildContext context) => ManageUsersScreen(),
    '/create_users': (BuildContext context) => CreateUserScreen(),
    '/menu': (BuildContext context) => MenuScreen(),
    '/projects': (BuildContext context) => ProjectsScreen(),
    '/profile': (BuildContext context) => ProfileScreen(),
    '/statistics': (BuildContext context) => StatisticsScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return ServicesContainer(
      child: AppDataContainer(
          child: MaterialApp(
        title: Details.COMPANY_TITLE,
        routes: routes,
        home: _AppRoot(),
      )),
    );
  }
}

class _AppRoot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _DataBlocImplementationState(child: _AppBottomNavigator());
}

class _DataBlocImplementationState extends State<_AppRoot> {
  final UserBloc userBloc = UserBloc("1", ApiService());
  final ActivityBloc activityBloc = ActivityBloc(ApiService());
  final ReceiptBloc receiptBloc = ReceiptBloc(ApiService());

  final Widget child;

  _DataBlocImplementationState({@required this.child});

  @override
  void initState() {
    super.initState();
    userBloc.getUser();
    activityBloc.query.add("");
    receiptBloc.query.add("");
  }

  @override
  Widget build(BuildContext context) {

    AppDataContainerState dataContainerState = AppDataContainer.of(context);
    activityBloc.results
        .listen((activities) => dataContainerState.setActivities(activities));
    receiptBloc.results
        .listen((receipts) => dataContainerState.setReceipts(receipts));

    return BlocProvider(
      bloc: userBloc,
      child: StreamBuilder<User>(
        stream: userBloc.outUser,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          dataContainerState.user = snapshot.data;
          return snapshot.data != null
              ? BlocProvider(
                  bloc: activityBloc,
                  child: BlocProvider(
                    bloc: receiptBloc,
                    child: child,
                  ),
                )
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
    AppDataContainerState userContainerState = AppDataContainer.of(context);
    User user = userContainerState.user;

    if (user.privilege == Privilege.ADMIN) {
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
