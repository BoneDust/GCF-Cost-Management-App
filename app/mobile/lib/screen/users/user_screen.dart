import 'package:cm_mobile/bloc/project_bloc.dart';
import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/users/user_details_card.dart';
import 'package:cm_mobile/service/api_service.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  final User user;

  const UserScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _UserScreen(
        user: user,
      ),
    );
  }
}

class _UserScreen extends StatelessWidget {
  final User user;

  const _UserScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(user.name + " " + user.surname),
              centerTitle: false,
              background: Image(
                image: AssetImage("assets/images.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          )
        ];
      },
      body:ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          children: <Widget>[
            user.privilege == Privilege.FOREMAN ? UserProjectsCard() : Column(),
            UserDetailsCard(user: user),
          ],
        ),
    );
  }
}

class UserProjectsCard extends StatelessWidget {
  ProjectsBloc projectsBloc;

  UserProjectsCard() {
    projectsBloc = ProjectsBloc(ApiService());
    projectsBloc.query.add("");
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: projectsBloc.results,
      initialData: <Project>[],
      builder: (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 10), child: Text("projects", style: TextStyle(color: Colors.blueGrey, fontSize: 30),),),
            Card(
                elevation: 5,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: snapshot.data.take(3).map((project) {
                    return UserProjectTile(project: project);
                  }).toList(),
                ))
          ],
        );
      },
    );
  }
}

class UserProjectTile extends StatelessWidget {
  final Project project;

  const UserProjectTile({Key key, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(project.name),
      subtitle: Text(project.description, maxLines: 1),
    );
  }
}
