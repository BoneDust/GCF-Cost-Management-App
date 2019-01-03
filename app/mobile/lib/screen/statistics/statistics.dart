import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StatisticsScreenState();
  }
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with AutomaticKeepAliveClientMixin<StatisticsScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Typicons.user_outline,
              size: 30,
              color: Colors.green,
            ),
            onPressed: () => Navigator.of(context).pushNamed("/menu")),
        title: Text(
          "gfc",
          style: TextStyle(color: Colors.green, fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: _StatisticsScreenBody(),
    );
  }
}

class _StatisticsScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: CircularProgressIndicator(
      ),
    );
  }
}