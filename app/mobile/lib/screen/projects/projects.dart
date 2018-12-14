import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/project_bloc.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/projects/project_container.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:cm_mobile/widget/user_provider.dart';
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
  Icon actionIcon = Icon(Icons.search, color: Colors.white);
  Widget appBarTitle;
  bool _isSearching = false;
  TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    projectsBloc = ProjectsBloc(ApiService());
    projectsBloc.getAllProjects();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    UserContainerState userContainerState = UserContainer.of(context);
    User user = userContainerState.user;

    super.build(context);
    return BlocProvider<ProjectsBloc>(
      bloc: projectsBloc,
      child: Scaffold(
          floatingActionButton: user.privilege == Privilege.ADMIN
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/add_project");
                  },
                  child: Icon(Icons.add),
                )
              : null,
          resizeToAvoidBottomPadding: false,
          appBar: buildAppBar(context),
          body: StreamBuilder<List<Project>>(
            key: PageStorageKey("projects"),
            stream:
                _isSearching ? projectsBloc.results : projectsBloc.outProject,
            builder:
                (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
              return snapshot.data != null
                  ? ProjectsList(snapshot.data)
                  : Column(
                      children: <Widget>[Text("loading...")],
                    );
            },
          )),
    );
  }

  Widget buildAppBar(BuildContext context) {
    appBarTitle = actionIcon.icon == Icons.search
        ? buildAppBarDefaultTitle(context)
        : buildAppBarSearch(context);

    return AppBar(
      actions: <Widget>[
        IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                actionIcon = actionIcon.icon == Icons.search
                    ? Icon(Icons.close)
                    : Icon(Icons.search);
                _isSearching = !_isSearching;

              });
            })
      ],
      title: appBarTitle,
    );
  }

  Widget buildAppBarSearch(BuildContext context) {
    TextStyle style = TextStyle(color: Colors.white, fontSize: 20);
    return Center(
      child: TextField(
        controller: searchTextController,
        cursorColor: Colors.white,
        autofocus: true,
        autocorrect: true,
        style: style,
        onChanged:  projectsBloc.query.add,
        //   controller: _searchQuery,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.arrow_back, color: Colors.white),
            hintText: "Search for projects...",
            hintStyle: style,
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }

  Widget buildAppBarDefaultTitle(BuildContext context) {
    searchTextController.clear();
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/menu");
          },
          child: Container(
              height: 40.0,
              width: 40.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/images.jpeg"),
                      fit: BoxFit.cover))),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
        ),
        Text("Projects")
      ],
    );
  }

  void onSearchTextChanged(String value) {
    if (searchTextController.text.isNotEmpty)
      projectsBloc.createQuery(searchTextController.text);
  }
}

class ProjectsList extends StatelessWidget {
  final List<Project> projects;

  ProjectsList(this.projects);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: projects.length,
      padding: EdgeInsets.only(bottom: 30, top: 30),
      itemBuilder: (BuildContext context, int index) {
        Project project = projects.elementAt(index);
        return ProjectContainer(project: project);
      },
    );
  }
}
