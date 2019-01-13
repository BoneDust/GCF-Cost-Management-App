import 'package:cm_mobile/bloc/generic_bloc.dart';
import 'package:cm_mobile/enums/model_status.dart';
import 'package:cm_mobile/model/filter/ProjectFilter.dart';
import 'package:cm_mobile/model/filter/UserFilter.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/users/add_edit_user_screen.dart';
import 'package:cm_mobile/screen/users/user_screen.dart';
import 'package:cm_mobile/screen/users/users_tile.dart';
import 'package:cm_mobile/service/model_api_service.dart';
import 'package:cm_mobile/util/filter/filter_tool.dart';
import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  final String title;
  final Function userTileFunction;
  final bool showOnlyForeMan;
  final bool showTabs;

  const UsersScreen(
      {Key key,
      @required this.title,
      this.userTileFunction,
      this.showOnlyForeMan = false, this.showTabs = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UsersScreenState();
  }
}

class UsersScreenState extends State<UsersScreen> with SingleTickerProviderStateMixin{
  GenericBloc<User> userBlocs;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<User> _users;
  List<User> _filteredUsers;

  TabController tabController;
  UserFilter userFilter = UserFilter.none();

  @override
  void initState() {

    tabController = TabController(vsync: this, length: 3, initialIndex: 0);
    tabController.addListener(() {
      switch (tabController.index) {
        case 0:
          userFilter = UserFilter.none();
          filterUsers(true);
          break;
        case 1:
          userFilter = UserFilter.byAdmin();
          filterUsers(true);
          break;
        case 2:
          userFilter = UserFilter.byForeMan();
          filterUsers(true);
          break;
      }
    });

    userBlocs =  GenericBloc<User>();
    userBlocs.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(),
        body: StreamBuilder<List<User>>(
          key: PageStorageKey("users"),
          stream: userBlocs.outItems,
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            _users = snapshot.data;
            filterUsers(false);
            return snapshot.data != null
                ? _buildBody()
                : _LoadingWidget();
          },
        ),
        floatingActionButton: _buildFloatingActionButton(context),
      );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return UserTile(
          user: _filteredUsers[index],
          function: widget.userTileFunction,
          parent: this,
        );
      },
      itemCount: _filteredUsers.length,
    );
  }

  Widget _buildAppBar() {
    return  AppBar(
      title: Text(widget.title),
      bottom: widget.showTabs ? TabBar(tabs: [
        Tab(
          child: Text("all"),
        ),
        Tab(
          child: Text("admins"),
        ),
        Tab(
          child: Text("foremans"),
        )
      ], controller: tabController,): null);
  }

  _navigateAndDisplaySelection() async {
    final result =  await         Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddEditUserScreen()));
    if (result is User) {
      setState(() {
        _filteredUsers.insert(0, result);
      });
      _scaffoldKey.currentState..showSnackBar(SnackBar(content: Text("user successfully created"), backgroundColor: Colors.green));
    }
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Theme(
        data: themeData.copyWith(accentColor: Colors.white),
        child: FloatingActionButton(
          onPressed: _navigateAndDisplaySelection,
          child: Icon(
            Typicons.user_add_outline,
            color: Colors.green,
          ),
        ));
  }

  void filterUsers([bool isSetState = false]) {
    void filter() {
      _filteredUsers = FilterTool.filterUsers(_users, userFilter);
    }

    if (isSetState) {
      setState(() {
        setState(() {
          filter();
        });
      });
    } else
      filter();
  }

  navigateAndDisplayProject(BuildContext context, User user) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserScreen(user : user)));

    if (result is ModelStatus && result.status != ModelStatusType.UNCHANGED) {
      if (result.status == ModelStatusType.UPDATED) {
        int index = _filteredUsers.indexOf(user);
        setState(() {
          _filteredUsers[index] = result.model;
        });
      } else {
        _users.remove(user);
        filterUsers(true);

        _scaffoldKey.currentState.removeCurrentSnackBar();
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("project successfully deleted"),
            backgroundColor: Colors.green));
      }
    }
  }

}


class _LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.green,
      ),
    );
  }
}
