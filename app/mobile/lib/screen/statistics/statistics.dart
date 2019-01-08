import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

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
          "gcf",
          style: TextStyle(color: Colors.green, fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: _StatisticsScreenBody(),
    );
  }
}

// class _StatisticsScreenBody extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Center(
//       child: CircularProgressIndicator(),
//     );
//   }
// }

class _StatisticsScreenBody extends StatelessWidget {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();
  final GlobalKey<AnimatedCircularChartState> _chartKey2 =
      new GlobalKey<AnimatedCircularChartState>();
  final GlobalKey<AnimatedCircularChartState> _chartKey3 =
      new GlobalKey<AnimatedCircularChartState>();

  @override
  Widget build(BuildContext context) {
    int percentage = ((20 / (20 + 55)) * 100).toInt();
    return new Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new AnimatedCircularChart(
            key: _chartKey,
            size: const Size(90.0, 90.0),
            initialChartData: [
              new CircularStackEntry(
                <CircularSegmentEntry>[
                  new CircularSegmentEntry(26.0, Colors.greenAccent,
                      rankKey: 'Q1'),
                  new CircularSegmentEntry(
                      74.0, const Color.fromRGBO(0, 0, 0, 0.5),
                      rankKey: 'Q2'),
                ],
                rankKey: 'Quarterly Profits',
              ),
            ],
            holeLabel: '$percentage %',
            labelStyle: new TextStyle(
              color: Colors.black,
            ),
            chartType: CircularChartType.Radial,
          ),
          new AnimatedCircularChart(
            key: _chartKey2,
            size: const Size(90.0, 90.0),
            initialChartData: [
              new CircularStackEntry(
                <CircularSegmentEntry>[
                  new CircularSegmentEntry(26.0, Colors.greenAccent,
                      rankKey: 'Q1'),
                  new CircularSegmentEntry(
                      74.0, const Color.fromRGBO(0, 0, 0, 0.5),
                      rankKey: 'Q2'),
                ],
                rankKey: 'Quarterly Profits',
              ),
            ],
            holeLabel: '$percentage %',
            labelStyle: new TextStyle(
              color: Colors.black,
            ),
            chartType: CircularChartType.Radial,
          ),
          new AnimatedCircularChart(
            key: _chartKey3,
            size: const Size(90.0, 90.0),
            initialChartData: [
              new CircularStackEntry(
                <CircularSegmentEntry>[
                  new CircularSegmentEntry(26.0, Colors.greenAccent,
                      rankKey: 'Q1'),
                  new CircularSegmentEntry(
                      74.0, const Color.fromRGBO(0, 0, 0, 0.5),
                      rankKey: 'Q2'),
                ],
                rankKey: 'Quarterly Profits',
              ),
            ],
            holeLabel: '$percentage %',
            labelStyle: new TextStyle(
              color: Colors.black,
            ),
            chartType: CircularChartType.Radial,
          ),
        ],
      ),
      // child: new AnimatedCircularChart(
      //   key: _chartKey,
      //   size: const Size(90.0, 90.0),
      //   initialChartData: [
      //     new CircularStackEntry(
      //       <CircularSegmentEntry>[
      //         new CircularSegmentEntry(26.0, Colors.greenAccent, rankKey: 'Q1'),
      //         new CircularSegmentEntry(74.0, const Color.fromRGBO(0, 0, 0, 0.5),
      //             rankKey: 'Q2'),
      //       ],
      //       // <CircularSegmentEntry>[
      //       //   new CircularSegmentEntry(26.0, Colors.greenAccent, rankKey: 'Q3'),
      //       //   new CircularSegmentEntry(74.0, const Color.fromRGBO(0, 0, 0, 0.5),
      //       //       rankKey: 'Q4'),
      //       // ],
      //       rankKey: 'Quarterly Profits',
      //     ),
      //   ],
      //   holeLabel: '$percentage %',
      //   labelStyle: new TextStyle(
      //     color: Colors.black,
      //   ),
      //   chartType: CircularChartType.Radial,
      // ),
    );
  }
}
