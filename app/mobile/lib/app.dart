import 'dart:async';
import 'dart:collection';

import 'package:cm_mobile/bloc/generic_bloc.dart';
import 'package:cm_mobile/data/app_colors.dart';
import 'package:cm_mobile/data/app_data.dart';
import 'package:cm_mobile/data/dummy_data.dart';
import 'package:cm_mobile/data/mode_cache.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/model/auth_state.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/client/add_client_screen.dart';
import 'package:cm_mobile/widget/loading_widget.dart';
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

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppDataContainer(child: _App());
  }
}

class _App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<_App> {
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

  AppDataContainerState dataContainerState;

  @override
  Widget build(BuildContext context) {
    dataContainerState = AppDataContainer.of(context);

    if (AppData.isInitializing == true) {
      getAuthToken();
    }

    return _buildMaterialApp(AppData.isInitializing
        ? Material(
            color: Colors.white,
            child: LoadingIndicator(),
          )
        : dataContainerState.authState.isAuthenticated
            ? dataContainerState.user != null ? _AppBottomNavigator() : Column()
            : AuthScreen());
  }

  Future getProjects(String username) async {
    ModelJsonFileUtil.getAll<Project>(username).then((List<Project> value) {
      ModelCache.projects = value;
      dataContainerState.projects = value;
    }).catchError((error) {
      ModelCache.projects = [];
    });
  }

  Future getActivities(String username) async {
    ModelJsonFileUtil.getAll<Activity>(username).then((List<Activity> value) {
      dataContainerState.setActivity(value);
    }).catchError((error) {});
  }

  Future getReceipts(String username) async {
    ModelJsonFileUtil.getAll<Receipt>(username).then((List<Receipt> value) {
      dataContainerState.setReceipt(value);
    }).catchError((error) {});
  }

  Future getUser() async {
    ModelJsonFileUtil.get<User>().then((user) async {
      if (user != null && user.name != null && user.name.isNotEmpty) {
        dataContainerState.user = user;
        AppData.user = user;
        AppData.isInitializing = false;

        dataContainerState.setAuthState(AuthenticationState.authenticated());

        getProjects(user.name);
        getActivities(user.name);
        getReceipts(user.name);
      }
    });
  }

  void getAuthToken() async {
    ModelJsonFileUtil.get<String>(fileName: "auth_token").then((authToken) {
      if (authToken != null && authToken.isNotEmpty) {
        AppData.authToken = authToken;
        getUser();
      } else
        setState(() {
          AppData.isInitializing = false;
        });
    });
  }

  Widget _buildMaterialApp(Widget home) {
    Color textIconColor = dataContainerState.brightness == Brightness.light
        ? AppColors.lightTextIconsColor
        : AppColors.darkTextIconColor;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Details.COMPANY_TITLE,
      routes: routes,
      theme: ThemeData(
        primaryColorBrightness: dataContainerState.brightness,
        accentColorBrightness: dataContainerState.brightness,
        brightness: dataContainerState.brightness,
        fontFamily: 'OpenSans',
        primaryColorDark: AppColors.darkPrimaryColor,
        primaryColorLight: AppColors.lightPrimaryColor,
        primaryColor: dataContainerState.brightness == Brightness.light
            ? AppColors.lightPrimaryColor
            : AppColors.darkPrimaryColor,
        accentColor: AppColors.accentColor,
        primaryTextTheme: TextTheme(
            title: TextStyle(color: textIconColor),
            subhead: TextStyle(color: textIconColor),
            body1: TextStyle(color: textIconColor),
            display1: TextStyle(color: textIconColor)),
        iconTheme: IconThemeData(color: textIconColor),
        accentIconTheme: IconThemeData(color: textIconColor),
        buttonTheme: ButtonThemeData(
          highlightColor: textIconColor,
        ),
        primaryIconTheme: IconThemeData(color: textIconColor),
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

class _AppBottomNavigator extends StatelessWidget {
  AppDataContainerState dataContainerState;
  StreamSubscription outActivityListener;
  StreamSubscription<List<Receipt>> outReceiptListener;

  @override
  Widget build(BuildContext context) {
    if (AppData.isInitializingData) _initAppData(context);

    _TabEntry tabEntry = getTabEntry(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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

  void _initAppData(BuildContext context) {
    AppData.isInitializingData = false;

    dataContainerState = AppDataContainer.of(context);
    User user = dataContainerState.user;

    GenericBloc<Activity> activityBloc = GenericBloc<Activity>();
    GenericBloc<Receipt> receiptBloc = GenericBloc<Receipt>();

    outActivityListener = activityBloc.outItems
        .listen((activities) => onActivityReceived(activities));
    outActivityListener.onError(_handleProjectError);

    if (user.privilege == Privilege.ADMIN) {
      outReceiptListener = receiptBloc.outItemsByUser
          .listen((activities) => onReceiptReceived(activities));
      outReceiptListener.onError(_handleProjectError);
      receiptBloc.getAll();
    } else {
      outReceiptListener = receiptBloc.outItems
          .listen((activities) => onReceiptReceived(activities));
      outReceiptListener.onError(_handleProjectError);
      receiptBloc.getByUser(user.id);
    }

    String filter = user.privilege == Privilege.ADMIN
        ? ""
        : "foreman_id=" + user.id.toString();
    activityBloc.getAll(filter);
  }

  onActivityReceived(List<Activity> activities) {
    dataContainerState.setActivity(activities);
  }

  onReceiptReceived(List<Receipt> receipts) {
    dataContainerState.setReceipt(receipts);
  }

  _handleProjectError(error) {}
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
