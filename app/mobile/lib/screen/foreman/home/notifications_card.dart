import 'package:flutter/material.dart';


class HomeNotificationsCard extends StatelessWidget {
  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  HomeNotificationsCard() {
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
      child: Column(
        children: <Widget>[
          ExpansionTile(

              title: Text("Notifications")
          ),
        ],
      ),
    );
//    return Column(
//      children: <Widget>[
//        Container(
//          color: Colors.white,
//          padding: EdgeInsets.only(top: 10.0, left: 10.0),
//              child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: [
//                    Text("Notifications", style: headerStyle)
//                  ]),
//            ),
//        _NotificationCard(),
//      ],
//    );
  }
}

class _TopTenNotications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column();
  }

}

class _NotificationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          ListTile(
            title: Text("Project 1"),
            subtitle: Text("project"),
          ),
          Divider(color: Colors.black54,),
          ListTile(
            title: Text("Company 1"),
            subtitle: Text("company"),
          ),
          Divider(color: Colors.black54,),
          ListTile(
            title: Text("11/11/11"),
            subtitle: Text("Start Date"),

          ),
          Divider(color: Colors.black54,),
          ListTile(
            title: Text("11/11/11"),
            subtitle: Text("End Date"),
          )
        ],
    );
  }
}