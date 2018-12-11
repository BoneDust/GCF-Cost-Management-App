import 'package:flutter/material.dart';


class HomeNotifications extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeNotificationsState();
  }
}

class _HomeNotificationsState extends State<HomeNotifications> {
  bool isDown = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ExpansionTile(
            title: Row(
              children: <Widget>[
                Text("Activity"),
              ],
            ),
            children: <Widget>[
              _LatestActivities(),
              _ActivityActions()
            ],
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


class NotificationTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(bottom: BorderSide(color: Colors.grey)),
      ),
      child: ListTile(
        dense: true,
        title: Text("You have been assigned to a project"),
        subtitle: Text("Standard bank project created by Dale. "),
        trailing: Text("8 Dec"),
      ),
    );
  }
}

class _LatestActivities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          NotificationTile(),
          NotificationTile(),
          NotificationTile(),
        ]
    );
  }
}

class _ActivityActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        FlatButton(child: Text("All Notifications"), onPressed: () {}),
      ],
    );
  }

}