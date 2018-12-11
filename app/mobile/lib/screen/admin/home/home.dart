import 'package:cm_mobile/screen/admin/home/notifications_card.dart';
import 'package:cm_mobile/screen/admin/home/recent_receipt_card.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("GCF"),
        ) ,
        body: SafeArea(
          child: _AdminHomeScreen(),
        )
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
