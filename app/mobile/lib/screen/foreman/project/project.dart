import 'package:cm_mobile/model/project.dart';
import 'package:flutter/material.dart';
import 'index.dart';

class ForeManProjectScreen extends StatelessWidget{
  Project project;

  ForeManProjectScreen(this.project);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ForeManProject(project),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushNamed(context, "/foreman/create_receipt");
      },
        child: ImageIcon(AssetImage("assets/icons/add_receipt.png")),),
    );
  }
}

class _ForeManProject extends StatelessWidget {
  Project project;

  _ForeManProject(this.project);


  @override
  Widget build(BuildContext context) {
    return NestedScrollView(headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverAppBar(
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(project.name),
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
                Padding(padding: EdgeInsets.only(bottom: 20),),
                StagesCard(project.stages),
                Padding(padding: EdgeInsets.only(bottom: 20),),
                ReceiptsCard(project.receipts),
                Padding(padding: EdgeInsets.only(bottom: 20),),
                DetailsCard(project),
                Padding(padding: EdgeInsets.only(bottom: 50),),
              ],
            )
        )
    );
  }
}


