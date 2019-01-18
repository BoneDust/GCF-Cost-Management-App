import 'package:cm_mobile/bloc/generic_bloc.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/screen/home/grid_menu.dart';
import 'package:cm_mobile/screen/home/activities_card.dart';
import 'package:cm_mobile/model/activity.dart';
import 'package:cm_mobile/screen/receipt/add_edit_receipt.dart';
import 'package:cm_mobile/screen/receipt/receipt.dart';

import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Typicons.user_outline,
              size: 30,
              color: Colors.green,
            ),
            onPressed: () => Navigator.of(context).pushNamed("/menu")),
        title: Text(
          "gcf",
          style: TextStyle(color: Colors.green, fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: _buildHome(),
    );
  }

  Widget _buildHome(){
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  ActivitiesCard(),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  )
                ])),
            SliverGridMenu(parent: this,),
            SliverPadding(padding: EdgeInsets.only(bottom: 50))
          ],
        ));
  }

  navigateAndDisplayReceipt() async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddEditReceiptScreen()));

    if (result is Receipt) {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        action: SnackBarAction(textColor: Colors.white, label: "VIEW", onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReceiptScreen(result)));
        }),
          content: Text("receipt created"), backgroundColor: Colors.green));

    }
  }
}
