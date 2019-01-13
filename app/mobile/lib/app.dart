import 'package:cm_mobile/bloc/activity_bloc.dart';
import 'package:cm_mobile/bloc/auth_bloc.dart';
import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/project_bloc.dart';
import 'package:cm_mobile/bloc/receipt_bloc.dart';
import 'package:cm_mobile/bloc/user_bloc.dart';
import 'package:cm_mobile/data/app_colors.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/auth_state.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/activity/activities.dart';
import 'package:cm_mobile/screen/client/add_client_screen.dart';
import 'package:cm_mobile/screen/receipt/all_receipts.dart';
import 'package:cm_mobile/screen/stage/add_stage.dart';
import 'package:cm_mobile/screen/users/add_user_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return ServicesContainer(child: AppDataContainer(child: _Blocs()));
  }
}

class _MaterialApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    '/auth': (BuildContext context) => AuthScreen(),
    '/activities': (BuildContext context) => ActivitiesScreen(),
    '/add_stage': (BuildContext context) => AddStageScreen(),
    '/add_receipt': (BuildContext context) => AddReceiptScreen(),
    '/all_receipts': (BuildContext context) => AllReceiptsScreen(),
    '/home': (BuildContext context) => HomeScreen(),
    '/create_users': (BuildContext context) => AddUserScreen(),
    '/create_client': (BuildContext context) => AddClientScreen(),
    '/menu': (BuildContext context) => MenuScreen(),
    '/projects': (BuildContext context) => ProjectsScreen(),
    '/statistics': (BuildContext context) => StatisticsScreen(),
  };

  final Widget home;

  _MaterialApp({Key key, this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      home: home,
    );
  }
}

class _Blocs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DataBlocImplementationState();
}

class _DataBlocImplementationState extends State<_Blocs> {
  final UserBloc userBloc = UserBloc(ApiService());
  final ActivityBloc activityBloc = ActivityBloc(ApiService());
  final ReceiptBloc receiptBloc = ReceiptBloc(ApiService());
  final AuthBloc authBloc = AuthBloc(ApiService());
  final ProjectsBloc projectsBloc = ProjectsBloc(ApiService());

  @override
  Widget build(BuildContext context) {
    AppDataContainerState dataContainerState = AppDataContainer.of(context);

    authBloc.results
        .listen((authState) => _onAuthenticated(dataContainerState, authState));

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
                          ? _MaterialApp(home: _AppBottomNavigator())
                          : Column(),
                    )),
              )
            : _MaterialApp(home: AuthScreen()));
  }

  void _onAuthenticated(
      AppDataContainerState dataContainer, AuthenticationState authState) {
    userBloc.results.listen((user) => _onUserReceived(dataContainer, user));
    userBloc.query.add(1);
    dataContainer.setAuthState(authState);
  }

  void _onUserReceived(AppDataContainerState dataContainer, User user) {
    activityBloc.results
        .listen((activities) => dataContainer.setActivities(activities));

    receiptBloc.results
        .listen((receipts) => dataContainer.setReceipts(receipts));

    activityBloc.query.add("");
    receiptBloc.query.add("");
    dataContainer.setUser(user);
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
