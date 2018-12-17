import 'package:cm_mobile/screen/home/grid_menu.dart';
import 'package:cm_mobile/screen/home/activities_card.dart';
import 'package:cm_mobile/util/image_utils.dart';
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
              onTap: () => Navigator.of(context).pushNamed("/menu"),
              child: Container(
                  height: 30.0,
                  width: 30.0,
                  decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage(ImageUtils.getAvatarPicture(context)),
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
          ActivitiesCard(),
          Padding(
            padding: EdgeInsets.only(top: 10),
          )
        ])),
        SliverGridMenu()
      ],
    );
  }
}
