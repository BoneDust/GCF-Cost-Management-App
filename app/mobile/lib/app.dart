import 'package:cm_mobile/bloc/activity_bloc.dart';
import 'package:cm_mobile/bloc/auth_bloc.dart';
import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/receipt_bloc.dart';
import 'package:cm_mobile/bloc/user_bloc.dart';
import 'package:cm_mobile/data/app_colors.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/auth_state.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/activity/activities.dart';
import 'package:cm_mobile/screen/project/add_project.dart';
import 'package:cm_mobile/screen/project/edit_project.dart';
import 'package:cm_mobile/screen/receipt/all_receipts.dart';
import 'package:cm_mobile/screen/stage/add_stage.dart';
import 'package:cm_mobile/screen/users/create_user_screen.dart';
import 'package:cm_mobile/screen/users/users.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:cm_mobile/util/typicon_icons_icons.dart';
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
    '/auth': (BuildContext context) => AuthScreen(),
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
        theme: ThemeData(
          fontFamily: 'OpenSans',

//          // Define the default Brightness and Colors
//          brightness: Brightness.light,
          primaryColorLight: AppColors.primaryColor,
          primaryColor: AppColors.primaryColor,
          accentColor: AppColors.accentColor,
          primaryTextTheme: TextTheme(
              title: TextStyle(color: AppColors.primaryText),
              subhead: TextStyle(color: AppColors.primaryText),
              body1: TextStyle(color: AppColors.primaryText)),

//
//          accentColor: AppColors.accentColor,
//          primaryColorDark: AppColors.darkPrimaryColor,
//          primaryIconTheme: IconThemeData(color: AppColors.textIconsColor),
//          dividerColor: AppColors.divider,
//          // Define the default Font Family
//          fontFamily: 'Montserrat',
//
//          // Define the default TextTheme. Use this to specify the default
//          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
//            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
//            title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
//            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
              ),
        ),
        home: _AppRoot(),
      )),
    );
  }
}

class _AppRoot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DataBlocImplementationState();
}

class _DataBlocImplementationState extends State<_AppRoot> {
  final UserBloc userBloc = UserBloc(ApiService());
  final ActivityBloc activityBloc = ActivityBloc(ApiService());
  final ReceiptBloc receiptBloc = ReceiptBloc(ApiService());
  final AuthBloc authBloc = AuthBloc(ApiService());

  @override
  void initState() {
    super.initState();
    userBloc.getUser(" ");
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

    userBloc.results.listen((user) => dataContainerState.setUser(user));

    authBloc.results
        .listen((authState) => dataContainerState.setAuthState(authState));

    return BlocProvider(
        bloc: authBloc,
        child: dataContainerState.authState.isAuthenticated
            ? BlocProvider(
                bloc: userBloc,
                child: BlocProvider(
                    bloc: activityBloc,
                    child: BlocProvider(
                      bloc: receiptBloc,
                      child: dataContainerState.user != null
                          ? _AppBottomNavigator()
                          : Column(),
                    )),
              )
            : AuthScreen());
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
