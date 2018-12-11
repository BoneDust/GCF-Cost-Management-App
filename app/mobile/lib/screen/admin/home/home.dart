import 'package:cm_mobile/screen/admin/home/grid_menu.dart';
import 'package:cm_mobile/screen/admin/home/notifications_card.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdminHomeState();
  }
}

class _AdminHomeState extends State<AdminHomeScreen>
    with AutomaticKeepAliveClientMixin<AdminHomeScreen> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/admin/menu");
              },
              child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/images.jpeg"),
                          fit: BoxFit.cover
                      )
                  )
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 10),),
            Text("Home")
          ],
        ),
      ),
      body: _AdminHomeBody(),

    );
  }

}

class _AdminHomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate([
              AdminHomeNotifications(),
              Padding(padding: EdgeInsets.only(top: 10),)
            ])),
        AdminSliverGridMenu()
      ],
    );
  }
}
