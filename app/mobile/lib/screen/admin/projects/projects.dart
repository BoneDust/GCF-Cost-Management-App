import 'package:flutter/material.dart';

class AdminProjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/AdminMenu");
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
          ),
        ),
        body: SafeArea(
          child: _ProjectsScreen(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/foreman/create_receipt");
          },
          child: ImageIcon(AssetImage("assets/icons/add_receipt.png")),
        ));
  }
}

class _ProjectsScreen extends StatelessWidget {
  List<_AdminProjectsScreen> projects = [
    _AdminProjectsScreen(),
    _AdminProjectsScreen(),
    _AdminProjectsScreen(),
    _AdminProjectsScreen(),
    _AdminProjectsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
          itemCount: projects.length,
          padding: EdgeInsets.only(bottom: 30, top: 30),
          itemBuilder: (BuildContext context, int index) {
            return projects[index];
          },
        )),
      ],
    );
  }
}

class _AdminProjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: true,
      onTap: () {
        Navigator.pushNamed(context, "/foreman/project");
      },
      child: Container(
        height: 100.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Stack(
          children: <Widget>[
            _ProjectCard(),
            _ProjectThumbnail(),
            _ProjectContentCard(),
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
        itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(child: Text("Edit"), value: "Edit"),
              PopupMenuItem<String>(child: Text("Remove"), value: "Remove"),
            ]);
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
    return Container(
      height: 120.0,
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
    );
  }
}

class _ProjectContentCard extends StatelessWidget {
  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  _ProjectContentCard() {
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
      child: new Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Project 1", style: headerStyle),
                Text("This is the description of the project haha",
                    style: subheadingStyle),
                Text(
                  "Currently in progress",
                  style: subheadingStyle,
                ),
              ],
            ),
            new Row(
              children: <Widget>[_ProjectPopMenuButton()],
            )
          ]),
        ],
      ),
    );
  }
}
