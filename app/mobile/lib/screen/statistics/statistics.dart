import 'dart:math';

import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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

  int _selectedItem;

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
      body: Column(
        children: <Widget>[
          Expanded(
            child: Card(
              child: LineAnimationZoomChart.withSampleData(),
            ),
          ),
          new _StatisticCard(
            title: "Current weight",
            value: 20,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Expanded(
                child: new _StatisticCard(
                  title: "Last week",
                  value: 10,
                  textSizeFactor: 0.8,
                  processNumberSymbol: true,
                ),
              ),
              new Expanded(
                child: new _StatisticCard(
                  title: "Last month",
                  value: 10,
                  textSizeFactor: 0.8,
                  processNumberSymbol: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class _StatisticsScreenBody extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: CircularProgressIndicator(),
//     );
//   }
// }

class LineAnimationZoomChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  LineAnimationZoomChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory LineAnimationZoomChart.withSampleData() {
    return new LineAnimationZoomChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory LineAnimationZoomChart.withRandomData() {
    return new LineAnimationZoomChart(_createRandomData());
  }

  /// Create random data.
  static List<charts.Series<LinearSales, num>> _createRandomData() {
    final random = new Random();

    final data = <LinearSales>[];

    for (var i = 0; i < 100; i++) {
      data.add(new LinearSales(i, random.nextInt(100)));
    }

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList, animate: animate, behaviors: [
      new charts.PanAndZoomBehavior(),
    ]);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 75),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

class _StatisticCardWrapper extends StatelessWidget {
  final double height;
  final Widget child;

  _StatisticCardWrapper({this.height = 120.0, this.child});

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: [
        new Expanded(
          child: new Container(
            height: height,
            child: new Card(child: child),
          ),
        ),
      ],
    );
  }
}

class _StatisticCard extends StatelessWidget {
  final String title;
  final num value;
  final bool processNumberSymbol;
  final double textSizeFactor;

  _StatisticCard(
      {this.title,
      this.value,
      this.processNumberSymbol = false,
      this.textSizeFactor = 1.0});

  @override
  Widget build(BuildContext context) {
    Color numberColor =
        (processNumberSymbol && value > 0) ? Colors.red : Colors.green;
    String numberSymbol = processNumberSymbol && value > 0 ? "+" : "";
    return new _StatisticCardWrapper(
      child: new Column(
        children: <Widget>[
          new Expanded(
            child: new Row(
              children: [
                new Text(
                  numberSymbol + value.toString(),
                  textScaleFactor: textSizeFactor,
                  style: Theme.of(context)
                      .textTheme
                      .display2
                      .copyWith(color: numberColor),
                ),
                new Padding(
                    padding: new EdgeInsets.only(left: 5.0),
                    child: new Text("kg")),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          new Padding(
            child: new Text(title),
            padding: new EdgeInsets.only(bottom: 8.0),
          ),
        ],
      ),
    );
  }
}
