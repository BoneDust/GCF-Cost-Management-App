import 'package:cm_mobile/bloc/bloc_provider.dart';
import 'package:cm_mobile/bloc/project_bloc.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/projects/project_container.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:cm_mobile/util/image_utils.dart';
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
  Icon actionIcon = Icon(Icons.search, color: Colors.white);
  Widget appBarTitle;
  bool _isSearching = false;
  Color _appBarBackgroundColor = Colors.blue;

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
            stream: projectsBloc.results,
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
      backgroundColor: _appBarBackgroundColor,
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
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/menu");
          },
          child: Container(
              height: 30.0,
              width: 30.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage(ImageUtils.getAvatarPicture(context)),
                      fit: BoxFit.cover))),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
        ),
        Text("Projects")
      ],
    );
  }

  void _toggleSearch() {
    setState(() {
      projectsBloc.query.add("");
      if (!_isSearching) {
        _appBarBackgroundColor = Colors.white;
      } else
        _appBarBackgroundColor = Colors.blue;

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
