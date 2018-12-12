import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ProfileScreen(),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Profile Name"),
              background: Image(
                image: AssetImage("assets/images.jpeg"),
                fit: BoxFit.fill,
              ),
            ),
          )
        ];
      },
      body: Material(
        color: Colors.black12,
        child: ListView(
          padding: EdgeInsets.only(left: 3, right: 3),
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: Text(
                  'projects currently in progress',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            _AdminProfilesScreen(),
            _AdminProfilesScreen(),
            _AdminProfilesScreen(),
          ],
        ),
      ),
    );
  }
}

class _AdminProfilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: true,
      onTap: () {
        Navigator.pushNamed(context, "/project");
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
    Navigator.pushNamed(context, "/project");
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
                Text("Project 1", style: headerStyle),
                Text("These are some details about the project",
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
