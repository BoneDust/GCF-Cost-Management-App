import 'package:flutter/material.dart';

class AdminProfilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/AdminHome");
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
            Text("Profiles")
          ],
        ),
      ),
      body: SafeArea(
        child: _ProfilesScreen(),
      ),
    );
  }
}

class _ProfilesScreen extends StatelessWidget {
  List<_AdminProfilesScreen> projects = [
    _AdminProfilesScreen(),
    _AdminProfilesScreen(),
    _AdminProfilesScreen(),
    _AdminProfilesScreen(),
    _AdminProfilesScreen(),
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

class _AdminProfilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: true,
      onTap: () {
        Navigator.pushNamed(context, "/Profile");
      },
      child: Container(
        height: 100.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Stack(
          children: <Widget>[
            _ProfileCard(),
            _ProfileThumbnail(),
            _ProfileContentCard(),
          ],
        ),
      ),
    );
  }

  showProjectScreen(BuildContext context) {
    Navigator.pushNamed(context, "/Profile");
  }
}

class _ProfilePopMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(child: Text("Edit"), value: "Edit"),
              PopupMenuItem<String>(child: Text("Remove"), value: "Remove"),
            ]);
  }
}

class _ProfileThumbnail extends StatelessWidget {
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

class _ProfileCard extends StatelessWidget {
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

class _ProfileContentCard extends StatelessWidget {
  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  _ProfileContentCard() {
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
                Text("Profile 1", style: headerStyle),
                Text("These are some details about the foreman",
                    style: subheadingStyle),
                Text(
                  "Some more details",
                  style: subheadingStyle,
                ),
              ],
            ),
            new Row(
              children: <Widget>[_ProfilePopMenuButton()],
            )
          ]),
        ],
      ),
    );
  }
}
