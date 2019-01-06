import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/project_bloc.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/projects/project_container.dart';
import 'package:cm_mobile/service/api_service.dart';
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
  Icon actionIcon = Icon(
    Typicons.search_outline,
    color: Colors.green,
    size: 25,
  );
  Widget appBarTitle;
  bool _isSearching = false;
  Color _appBarBackgroundColor = Colors.white;

  TextEditingController searchTextController = TextEditingController();
  AppDataContainerState appDataContainerState;
  User user;
  Privilege privilege;
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
    super.build(context);
    appDataContainerState = AppDataContainer.of(context);
    user = appDataContainerState.user;
    privilege = user.privilege;

    return BlocProvider<ProjectsBloc>(
      bloc: projectsBloc,
      child: privilege == Privilege.ADMIN ? DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: buildScaffold(),
    ) : buildScaffold());
  }

  Widget buildAppBar() {
    appBarTitle = actionIcon.icon == Typicons.search_outline
        ? buildAppBarDefaultTitle()
        : buildAppBarSearch();

    return AppBar(
      elevation: 5,
      backgroundColor: _appBarBackgroundColor,
      centerTitle: actionIcon.icon == Typicons.search_outline,
      leading: actionIcon.icon != Typicons.search_outline
          ? null
          : IconButton(
              icon: Icon(
                Typicons.user_outline,
                size: 30,
                color: Colors.green,
              ),
              onPressed: () => Navigator.of(context).pushNamed("/menu")),
      actions: <Widget>[IconButton(icon: actionIcon, onPressed: _toggleSearch)],
      title: appBarTitle,
      bottom: privilege == Privilege.ADMIN ? TabBar(tabs: [
        Tab(text: "all"),
        Tab(text: "active"),
        Tab(text: "done"),
      ]) : null
    );
  }

  Widget buildAppBarSearch() {
    TextStyle style = TextStyle(fontSize: 20, color: Colors.white);
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
                  color: Colors.white,
                ),
                onPressed: _toggleSearch),
            hintText: "Search for projects...",
            hintStyle: style,
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }

  Widget buildAppBarDefaultTitle() {
    searchTextController.clear();
    return Text(
      "gcf",
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

      actionIcon = actionIcon.icon == Typicons.search_outline
          ? Icon(
              Typicons.cancel,
              color: Colors.white,
              size: 25,
            )
          : Icon(
              Typicons.search_outline,
              color: Colors.green,
              size: 25,
            );
      _isSearching = !_isSearching;
    });
  }

  Widget buildScaffold(){
    ThemeData themeData = Theme.of(context);

    return Scaffold(
        floatingActionButton: privilege == Privilege.ADMIN
            ? Container(
          decoration: BoxDecoration(
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
        appBar: buildAppBar(),
        body: StreamBuilder<List<Project>>(
          key: PageStorageKey("projects"),
          stream: projectsBloc.results,
          builder: (BuildContext context,
              AsyncSnapshot<List<Project>> snapshot) {
            return snapshot.data != null
                ? _buildBody(snapshot.data)
                : _LoadingWidget();
          },
        ));
  }

  Widget _buildBody(List<Project> projects) {
    return privilege == Privilege.ADMIN ? TabBarView(children: [
      ProjectsList(projects),
      ProjectsList(projects),
      ProjectsList(projects)
    ]) : ProjectsList(projects);
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
    return RefreshIndicator(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: projects.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 30, top: 30),
          itemBuilder: (BuildContext context, int index) {
            Project project = projects.elementAt(index);
            return ProjectContainer(project: project);
          },
        ),
        onRefresh: () => _loadProjects(context));
  }


  Future<void> _loadProjects(BuildContext context) async {}
}
