import 'package:flutter/material.dart';

class ForeManProjects extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Projects"),
        ) ,
        body: SafeArea(
          child: _ProjectsScreen(),
        )
    );
  }
}

class _ProjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _ProjectWidget(),
        _ProjectWidget(),
        _ProjectWidget(),
        _ProjectWidget()

      ],
    );
  }
}

class _ProjectWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, "/foreman/project");
      },
      child: Container(
        height: 120.0,
        margin: EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0
        ),
        child: Stack(
          children: <Widget>[
            _ProjectCard(),
            _ProjectThumbnail(),
            _ProjectContentCard(),
            _ProjectPopMenuButton()
          ],
        ),
      ),
    );
  }

  showProjectScreen(BuildContext context) {
    Navigator.pushNamed(context, "/foreman/project");

  }
}

class _ProjectPopMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        itemBuilder: (_) => <PopupMenuItem<String>> [
          PopupMenuItem<String>(child: Text("Edit"), value: "Edit"),
          PopupMenuItem<String>(child: Text("Remove"), value: "Remove"),
        ]);
  }
}

class _ProjectThumbnail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 16.0),
        height: 80.0,
        width: 80.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image : AssetImage("assets/images.jpeg"),
                fit: BoxFit.cover
            )
        )
    );
  }
}

class _ProjectCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      margin: EdgeInsets.only(left: 46.0),
      decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: <BoxShadow> [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                offset: new Offset(0.0, 10.0)
            )
          ]
      ),
    );
  }
}

class _ProjectContentCard extends StatelessWidget{
  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  _ProjectContentCard(){
    baseTextStyle = const TextStyle(fontFamily: 'Comfortaa');
    headerStyle = baseTextStyle.copyWith(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold
    );
    subheadingStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 12.0,
    );

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(100.0, 20.0, 16.0, 16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Project Name", style: headerStyle),
          Text("Project Name", style: subheadingStyle),
          Text("Status"),
        ],
      ),
    );
  }
}