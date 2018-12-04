import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/screen/foreman/project/project.dart';
import 'package:flutter/material.dart';


class DetailsCard  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return _DetailsCardRoot();
  }
}
class _DetailsCardRoot extends StatelessWidget {
  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  _DetailsCardRoot() {
    baseTextStyle = const TextStyle();
    headerStyle =
        baseTextStyle.copyWith(fontSize: 18.0);
    subheadingStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 12.0,);
  }

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
                    Text("Details", style: headerStyle)
                  ]),
            ),
            _DetailsCard(),
          ],
        )
    );
  }
}

class _DetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProjectInheritedWidgetState state = ProjectInheritedWidget.of(context);
    Project project = state.project;

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