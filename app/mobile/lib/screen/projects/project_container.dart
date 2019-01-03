import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/screen/project/project.dart';
import 'package:flutter/material.dart';

class ProjectContainer extends StatelessWidget {
  final Project project;

  const ProjectContainer({Key key, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: true,
      onTap: () {
        showProjectScreen(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Stack(
          children: <Widget>[
            _ProjectCard(),
            _ProjectThumbnail(),
            _ProjectContentCard(project: project),
          ],
        ),
      ),
    );
  }

  showProjectScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProjectWidget(project)));
  }
}

class _ProjectThumbnail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 60.0,
        width: 60.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage("assets/images.jpeg"), fit: BoxFit.cover))

    );
  }
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

  const _ProjectContentCard({Key key, @required this.project}) : super(key: key);


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
            project.description,
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
