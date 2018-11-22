import 'package:flutter/material.dart';
import 'base_project_card.dart';


class DetailsCard  extends BaseProjectCard{
  DetailsCard() : super("Uploaded Receipts");

  @override
  Widget setChildren() {
    return _ReceiptsCardRoot();
  }
}
class _ReceiptsCardRoot extends StatelessWidget {
  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  _ReceiptsCardRoot() {
    baseTextStyle = const TextStyle();
    headerStyle =
        baseTextStyle.copyWith(fontSize: 18.0);
    subheadingStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 12.0,);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/foreman/stages");
            },
            child: Container(
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Details", style: headerStyle)
                  ]),
            )),
        _DetailsCard(),

      ],
    );
  }
}

class _DetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          ListTile(
            title: Text("Project 1"),
            subtitle: Text("project"),
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