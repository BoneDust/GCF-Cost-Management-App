import 'package:cm_mobile/model/filter/ProjectFilter.dart';
import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/util/filter/filter_tool.dart';
import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
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

  List<Project> _projects;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppDataContainerState userContainerState = AppDataContainer.of(context);
    _projects = userContainerState.projects;

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
              child: WeeklySpendChart.withSampleData(),
            ),
          ),
          new _StatisticCard(
            title: "in total",
            value: _projects.length,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Expanded(
                child: new _StatisticCard(
                  title: "active",
                  value: FilterTool.filterProjects(_projects, ProjectFilter.byActive()).length,
                  textSizeFactor: 0.8,
                  processNumberSymbol: true,
                ),
              ),
              new Expanded(
                child: new _StatisticCard(
                  title: "completed",
                  value:  FilterTool.filterProjects(_projects, ProjectFilter.byDone()).length,
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

class WeeklySpendChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  WeeklySpendChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory WeeklySpendChart.withSampleData() {
    return new WeeklySpendChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSpend, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSpend(new DateTime(2017, 9, 19), 5),
      new TimeSeriesSpend(new DateTime(2017, 9, 26), 10),
      new TimeSeriesSpend(new DateTime(2017, 10, 3), 42),
      new TimeSeriesSpend(new DateTime(2017, 10, 10), 37),
      new TimeSeriesSpend(new DateTime(2017, 10, 17), 51),
      new TimeSeriesSpend(new DateTime(2017, 10, 24), 100),
      new TimeSeriesSpend(new DateTime(2017, 10, 31), 75),
    ];

    return [
      new charts.Series<TimeSeriesSpend, DateTime>(
        id: 'Spend',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSpend spend, _) => spend.time,
        measureFn: (TimeSeriesSpend spend, _) => spend.spend,
        data: data,
        displayName: "Weekly expenditure"
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSpend {
  final DateTime time;
  final int spend;

  TimeSeriesSpend(this.time, this.spend);
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
    String numberSymbol = processNumberSymbol && value > 0 ? "" : "";
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
                    child: new Text("projects")),
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
