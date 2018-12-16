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
            _ProjectContentCard(project),
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
                image: AssetImage("assets/images.jpeg"), fit: BoxFit.cover)));
  }
}

class _ProjectCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        margin: EdgeInsets.only(left: 20.0),
        decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  offset: new Offset(0.0, 0.0))
            ]),
      ),
    );
  }
}

class _ProjectContentCard extends StatelessWidget {
  final Project project;

  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  _ProjectContentCard(this.project) {
    baseTextStyle = const TextStyle(fontFamily: 'Comfortaa');
    headerStyle = baseTextStyle.copyWith(
        color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold);
    subheadingStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 12.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(75.0, 30.0, 16.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            project.name,
            style: headerStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            project.description,
            style: subheadingStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            project.status,
            style: subheadingStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
