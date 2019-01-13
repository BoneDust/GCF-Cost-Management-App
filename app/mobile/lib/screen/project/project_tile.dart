import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/screen/project/projects_screen.dart';
import 'package:cm_mobile/util/StringUtil.dart';
import 'package:flutter/material.dart';

class ProjectTile extends StatelessWidget {
  final Project project;
  final ProjectsScreenState parent;

  const ProjectTile({Key key, this.project, this.parent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: true,
      onTap: () {
        if (parent.widget.isSelectOnClick)
          parent.selectProjectAndExit(project);
          else
            parent.navigateAndDisplayProject(context, project);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Stack(
          children: <Widget>[
            _ProjectCard(),
            _Thumbnail(project: project),
            _ProjectContentCard(project: project),
          ],
        ),
      ),
    );
  }

}

class _Thumbnail extends StatelessWidget{
  final Project project;

  const _Thumbnail({Key key, @required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: 60.0,
      width: 60.0,
      child: CircleAvatar(
        backgroundColor: getColor(project.name),
        child: Text(StringUtil.createInitials(project.name)),
      ),
    );
  }

}

Color getColor(String name) {
  int getColorFromHash (double variant){
    return ((name.hashCode / variant) % 256).toInt();
  }
  int r = getColorFromHash(10);
  int g = getColorFromHash(06);
  int b = getColorFromHash(89);

  Color color = Color.fromRGBO(r , g, b, 1.0);

  return color;
}

class _ProjectCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        margin: EdgeInsets.only(left: 20.0),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.blueGrey,
                  blurRadius: 10.0,
                  offset: Offset(2.0, 2.0))
            ]),
      ),
    );
  }
}

class _ProjectContentCard extends StatelessWidget {
  final Project project;

  const _ProjectContentCard({Key key, @required this.project})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(75.0, 30.0, 16.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            project.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            project.status,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}

class BasicProjectTile extends StatelessWidget {
  final Project project;
  final ProjectsScreenState parent;

  const BasicProjectTile({Key key, this.project, this.parent}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(project.id.toString()),
      background: Container(color: Colors.red),
      child: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () {
                if (parent.widget.isSelectOnClick)
                  parent.selectProjectAndExit(project);
                else
                  parent.navigateAndDisplayProject(context, project);
              },
              title: Text(project.name),
              subtitle: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(project.status),
                  ],
                ),
              ),
              leading: _Thumbnail(project: project),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
            ),
            Divider(
              height: 1.0,
              indent: 82,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}

