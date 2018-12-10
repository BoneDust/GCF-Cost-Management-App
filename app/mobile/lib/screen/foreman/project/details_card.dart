import 'package:cm_mobile/model/project.dart';
import 'package:flutter/material.dart';

class DetailsCard extends StatelessWidget{
  Project project;

  DetailsCard(this.project);

  @override
  Widget build(BuildContext context) {
    return project == null ? Column() : _DetailsCardRoot(project);
  }
}

class _DetailsCardRoot  extends StatelessWidget{

  Project project;

  _DetailsCardRoot(this.project);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        child:  Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Details")
                  ]),
            ),
            _DetailsCard(project),
          ],
        )
    );
  }
}

class _DetailsCard extends StatelessWidget {

  final Project project ;

  _DetailsCard(this.project);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        ListTile(
          title: Text(project.name),
          subtitle: Text("Name"),
          leading: Icon(Icons.assignment),
        ),
        Divider(color: Colors.black54,),
        ListTile(
          title: Text(project.clientId.toString()),
          subtitle: Text("Company"),
          leading: Icon(Icons.business_center),
        ),
        Divider(color: Colors.black54,),
        ListTile(
          title: Text(project.startDate.toString()),
          subtitle: Text("Start Date"),
          leading: Icon(Icons.date_range),

        ),
        Divider(color: Colors.black54,),
        ListTile(
          title: Text(project.endDate.toIso8601String()),
          subtitle: Text("End Date"),
          leading: Icon(Icons.date_range),

        )
      ],
    );
  }
}