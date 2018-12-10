import 'package:cm_mobile/screen/admin/home/notifications_card.dart';
import 'package:cm_mobile/screen/admin/home/recent_receipt_card.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/AdminMenu");
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
            Text("Home")
          ],
        ),
      ),
      body: _AdminHomeScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/foreman/create_receipt");
        },
        child: ImageIcon(AssetImage("assets/icons/add_receipt.png")),
      ),
    );
  }
}

class _AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0),
        ),
        HomeNotificationsCard(),
        Padding(
          padding: EdgeInsets.only(top: 20.0),
        ),
        RecentReceiptCard(),
        Padding(
          padding: EdgeInsets.only(top: 40.0),
        ),
      ],
    );
  }
}
