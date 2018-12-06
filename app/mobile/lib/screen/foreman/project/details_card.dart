import 'package:cm_mobile/model/project.dart';
import 'package:flutter/material.dart';


class DetailsCard  extends StatelessWidget{

  Project project;

  DetailsCard(this.project);

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

  Project project ;

  _DetailsCard(this.project);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        ListTile(
          title: Text(project.name),
          subtitle: Text(project.description),
          leading: Icon(Icons.assignment),
        ),
        Divider(color: Colors.black54,),
        ListTile(
          title: Text("Company 1"),
          subtitle: Text("company"),
          leading: Icon(Icons.business_center),
        ),
        Divider(color: Colors.black54,),
        ListTile(
          title: Text("11/11/11"),
          subtitle: Text("Start Date"),
          leading: Icon(Icons.date_range),

        ),
        Divider(color: Colors.black54,),
        ListTile(
          title: Text("11/11/11"),
          subtitle: Text("End Date"),
          leading: Icon(Icons.date_range),

        )
      ],
    );
  }
}