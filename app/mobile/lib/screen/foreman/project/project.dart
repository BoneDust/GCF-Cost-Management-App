import 'package:flutter/material.dart';
import 'index.dart';

class ForeManProjectScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ForeManProject(),
    );
  }
}

class _ForeManProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverAppBar(
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Project Name"),
            background: Image(
              image: AssetImage("assets/images.jpeg"),
              fit: BoxFit.fill,
            ),
          ),
        )
      ];
    }, body: ListView(
      children: <Widget>[
        RecentActivityCard(),
        ReceiptsCard(),
        ProjectDetailsCard()

      ],
    ),

    );
  }
}


