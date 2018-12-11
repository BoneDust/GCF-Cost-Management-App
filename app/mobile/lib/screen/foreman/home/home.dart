import 'package:cm_mobile/screen/foreman/home/grid_menu.dart';
import 'package:cm_mobile/screen/foreman/home/notifications_card.dart';
import 'package:flutter/material.dart';

class ForeManHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ForeManHomeState();
  }
}

class _ForeManHomeState extends State<ForeManHome>
    with AutomaticKeepAliveClientMixin<ForeManHome> {

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
                Navigator.of(context).pushNamed("/foreman/menu");
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
      ) ,
      body: _ForeManHomeBody(),

    );
  }

}

class _ForeManHomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
         SliverList(
          delegate:  SliverChildListDelegate([
            ForemanHomeNotifications(),
            Padding(padding: EdgeInsets.only(top: 10),)
          ])
        ),
        SliverGridMenu()
      ],
    );
  }
}
