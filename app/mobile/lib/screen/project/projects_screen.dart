import 'dart:async';

import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/generic_bloc.dart';
import 'package:cm_mobile/enums/model_status.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/filter/ProjectFilter.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/project/add_edit_project.dart';
import 'package:cm_mobile/screen/project/project.dart';
import 'package:cm_mobile/screen/project/project_tile.dart';
import 'package:cm_mobile/util/filter/filter_tool.dart';
import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class ProjectsScreen extends StatefulWidget {
  final String title;
  final bool isSelectOnClick;
  final ProjectFilter projectFilter;
  final bool showTabs;

  const ProjectsScreen(
      {Key key,
        this.title,
        this.isSelectOnClick = false,
        this.projectFilter, this.showTabs = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProjectsScreenState(projectFilter);
  }
}

class ProjectsScreenState extends State<ProjectsScreen>
    with
        AutomaticKeepAliveClientMixin<ProjectsScreen>,
        SingleTickerProviderStateMixin {
  GenericBloc<Project> projectsBloc;
  Completer<Null> _refreshCompleter;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Icon actionIcon = Icon(
    Typicons.search_outline,
    color: Colors.green,
    size: 25,
  );
  Widget appBarTitle;
  bool _isSearching = false;
  Color _appBarBackgroundColor = Colors.white;
  List<Project> filteredProjects;
  List<Project> projects;

  TextEditingController searchTextController = TextEditingController();
  AppDataContainerState appDataContainerState;
  User user;
  Privilege privilege;

  TabController tabController;

  ProjectFilter projectFilter;

  List<Tab>_projectStatusTabs = [
  Tab(text: "all"),
  Tab(text: "active"),
  Tab(text: "done"),
  ];
  ProjectsScreenState(this.projectFilter){



    if (projectFilter == null)
      projectFilter = ProjectFilter.none();
  }

  @override
  void initState() {
    projectsBloc = GenericBloc<Project>();
    projectsBloc.getAll();
    tabController = TabController(vsync: this, length: 3, initialIndex: 1);
    tabController.addListener(() {
      switch (tabController.index) {
        case 0:
          projectFilter = ProjectFilter.none();
          filterProjects(true);
          break;
        case 1:
          projectFilter = ProjectFilter.byActive();
          filterProjects(true);
          break;
        case 2:
          projectFilter = ProjectFilter.byDone();
          filterProjects(true);
          break;
      }
    });
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

    return BlocProvider<GenericBloc<Project>>(
        bloc: projectsBloc, child: buildScaffold());
  }

  Widget buildAppBar() {
    appBarTitle = actionIcon.icon == Typicons.search_outline
        ? buildAppBarDefaultTitle()
        : buildAppBarSearch();

    return AppBar(
        elevation: 5,
        backgroundColor: _appBarBackgroundColor,
        centerTitle: actionIcon.icon == Typicons.search_outline && widget.title == null,
        automaticallyImplyLeading: true,
        leading: actionIcon.icon != Typicons.search_outline
            ? null
            : IconButton(
                icon: Icon(
                  Typicons.user_outline,
                  size: 30,
                  color: Colors.green,
                ),
                onPressed: () => Navigator.of(context).pushNamed("/menu")),
        actions: <Widget>[
          IconButton(icon: actionIcon, onPressed: _toggleSearch)
        ],
        title: appBarTitle,
        bottom: privilege == Privilege.ADMIN && widget.showTabs
            ? TabBar(
                tabs: _projectStatusTabs,
                controller: tabController,
              )
            : null);
  }

  Widget buildAppBarSearch() {
    TextStyle style = TextStyle(fontSize: 20, color: Colors.white);
    return Center(
      child: TextField(
        controller: searchTextController,
        autofocus: true,
        autocorrect: true,
        style: style,
        onChanged: (value) {},
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
    return widget.title == null ? Text("gcf",
      style: TextStyle(color: Colors.green, fontSize: 40),
    ) : Text(widget.title);
  }

  void _toggleSearch() {
    setState(() {
      projectsBloc.getAll();
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

  Widget buildScaffold() {
    return Scaffold(
        key: _scaffoldKey,
        floatingActionButton: _buildFloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        resizeToAvoidBottomPadding: false,
        appBar: buildAppBar(),
        body: StreamBuilder<List<Project>>(
          key: PageStorageKey("projects"),
          stream: projectsBloc.outItems,
          builder:
              (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
            if (snapshot.data != null) {
              if (_refreshCompleter != null && !_refreshCompleter.isCompleted)
                _refreshCompleter.complete(null);
              projects = snapshot.data;
              filterProjects(false);
              return _buildProjectList();
            }
            return _LoadingWidget();
          },
        ));
  }

  Widget _buildFloatingButton() {
    ThemeData themeData = Theme.of(context);
    return privilege == Privilege.ADMIN
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
                    _navigateAndDisplayCreateProject();
                  },
                  child: Icon(
                    Typicons.plus_outline,
                    color: Colors.green,
                  ),
                )),
          )
        : null;
  }

  _navigateAndDisplayCreateProject() async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddEditProjectScreen()));
    if (result is Project) {
      projects.insert(0, result);

      filterProjects(true);
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("project successfully created"),
          backgroundColor: Colors.green));
    }
  }

  _buildProjectList() {
    return RefreshIndicator(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: filteredProjects.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 30, top: 30),
          itemBuilder: (BuildContext context, int index) {
            Project project = filteredProjects.elementAt(index);
            return ProjectTile(
              project: project,
              parent: this,
            );
          },
        ),
        onRefresh: () => _loadProjects(context));
  }

  navigateAndDisplayProject(BuildContext context, Project project) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProjectWidget(project: project)));

    if (result is ModelStatus && result.status != ModelStatusType.UNCHANGED) {
      if (result.status == ModelStatusType.UPDATED) {
        int index = filteredProjects.indexOf(project);
        setState(() {
          filteredProjects[index] = result.model;
        });
      } else {
          filteredProjects.remove(project);
          filterProjects(true);

        _scaffoldKey.currentState.removeCurrentSnackBar();
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("project successfully deleted"),
            backgroundColor: Colors.green));
      }
    }
  }

  Future<void> _loadProjects(BuildContext context) async {
    _refreshCompleter = Completer<Null>();
    projectsBloc.getAll();
    await _refreshCompleter.future;
  }

  void filterProjects([bool isSetState = false]) {
    void filter() {
      filteredProjects = FilterTool.filterProjects(projects, projectFilter);
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

  void selectProjectAndExit(Project project) {
    Navigator.of(context).pop(project);
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
