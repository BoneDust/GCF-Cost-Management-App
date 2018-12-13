import 'package:cm_mobile/screen/home/grid_menu.dart';
import 'package:cm_mobile/screen/home/notifications_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
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
              onTap: () => Navigator.pushNamed(context, "/menu"),
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
      body: _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate([
          HomeNotifications(),
          Padding(
            padding: EdgeInsets.only(top: 10),
          )
        ])),
        SliverGridMenu()
      ],
    );
  }
}
