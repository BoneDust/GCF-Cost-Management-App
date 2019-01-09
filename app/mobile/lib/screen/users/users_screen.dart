import 'package:cm_mobile/bloc/user_bloc.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/users/users_tile.dart';
import 'package:cm_mobile/service/api_service.dart';
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

class UsersScreenState extends State<UsersScreen> {
  UsersBloc userBlocs;

  @override
  void initState() {
    userBlocs = UsersBloc(ApiService());
    userBlocs.query.add("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: StreamBuilder<List<User>>(
          key: PageStorageKey("users"),
          stream: userBlocs.results,
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            return snapshot.data != null
                ? _buildBody(snapshot.data)
                : _LoadingWidget();
          },
        ),
        floatingActionButton: Theme(
            data: themeData.copyWith(accentColor: Colors.white),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/create_users");
              },
              child: Icon(
                Typicons.user_add_outline,
                color: Colors.green,
              ),
            )),
      ),
    );
  }

  Widget _buildBody(List<User> data) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return UserTile(
          user: data[index],
          function: widget.userTileFunction,
        );
      },
      itemCount: data.length,
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
      ]): null);
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
