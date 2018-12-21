import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/project_bloc.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/projects/project_container.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:cm_mobile/util/image_utils.dart';
import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class ProjectsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectsScreenState();
  }
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with AutomaticKeepAliveClientMixin<ProjectsScreen> {
  ProjectsBloc projectsBloc;
  Icon actionIcon = Icon(Icons.search);
  Widget appBarTitle;
  bool _isSearching = false;
  Color _appBarBackgroundColor = Colors.white;

  TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    projectsBloc = ProjectsBloc(ApiService());
    projectsBloc.query.add("");
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    AppDataContainerState userContainerState = AppDataContainer.of(context);
    User user = userContainerState.user;
    ThemeData themeData = Theme.of(context);
    super.build(context);
    return BlocProvider<ProjectsBloc>(
      bloc: projectsBloc,
      child: Scaffold(
          floatingActionButton: user.privilege == Privilege.ADMIN
              ? Container(
            decoration:   BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.blueGrey,
                      blurRadius: 5.0,
                      offset: Offset(0.4, 0.0))
                ]),
                  child: Theme(
                      data: themeData.copyWith(accentColor: Colors.white),
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/add_project");
                        },
                        child: Icon(
                          Typicons.plus_outline,
                          color: Colors.green,
                        ),
                      )),
                )
              : null,
          resizeToAvoidBottomPadding: false,
          appBar: buildAppBar(context),
          body: StreamBuilder<List<Project>>(
            key: PageStorageKey("projects"),
            stream: projectsBloc.results,
            builder:
                (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
              return snapshot.data != null
                  ? ProjectsList(snapshot.data)
                  : _LoadingWidget();
            },
          )),
    );
  }

  Widget buildAppBar(BuildContext context) {
    appBarTitle = actionIcon.icon == Icons.search
        ? buildAppBarDefaultTitle(context)
        : buildAppBarSearch(context);

    return AppBar(
      backgroundColor: _appBarBackgroundColor,
      centerTitle: actionIcon.icon == Icons.search,
      leading: actionIcon.icon != Icons.search
          ? null
          : IconButton(
              icon: Icon(
                Icons.person,
                size: 30,
                color: Colors.green,
              ),
              onPressed: () => Navigator.of(context).pushNamed("/menu")),
      actions: <Widget>[IconButton(icon: actionIcon, onPressed: _toggleSearch)],
      title: appBarTitle,
    );
  }

  Widget buildAppBarSearch(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 20, color: Colors.black);
    return Center(
      child: TextField(
        controller: searchTextController,
        autofocus: true,
        autocorrect: true,
        style: style,
        onChanged: projectsBloc.query.add,
        //   controller: _searchQuery,
        decoration: InputDecoration(
            prefixIcon: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: _toggleSearch),
            hintText: "Search for projects...",
            hintStyle: style,
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }

  Widget buildAppBarDefaultTitle(BuildContext context) {
    searchTextController.clear();
    return Text(
      "gfc",
      style: TextStyle(color: Colors.green, fontSize: 40),
    );
  }

  void _toggleSearch() {
    setState(() {
      projectsBloc.query.add("");
      if (!_isSearching) {
        _appBarBackgroundColor = Colors.green;
      } else
        _appBarBackgroundColor = Colors.white;

      actionIcon = actionIcon.icon == Icons.search
          ? Icon(
              Icons.close,
              color: Colors.black,
              size: 25,
            )
          : Icon(
              Icons.search,
              size: 25,
            );
      _isSearching = !_isSearching;
    });
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

class ProjectsList extends StatelessWidget {
  final List<Project> projects;

  ProjectsList(this.projects);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: projects.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: 30, top: 30),
      itemBuilder: (BuildContext context, int index) {
        Project project = projects.elementAt(index);
        return ProjectContainer(project: project);
      },
    );
  }
}
