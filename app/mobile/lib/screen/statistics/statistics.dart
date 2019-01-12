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
          Text('Weekly spend'),
          HorizontalBarLabelChart.withSampleData(),
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

class HorizontalBarLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  const HorizontalBarLabelChart(this.seriesList, {this.animate});

  factory HorizontalBarLabelChart.withSampleData() {
    return new HorizontalBarLabelChart(
      _createSampleData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      vertical: false,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      domainAxis: new charts.OrdinalAxisSpec(
        renderSpec: new charts.NoneRenderSpec(),
      ),
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
          id: 'Sales',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: data,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (OrdinalSales sales, _) =>
              '${sales.year}: \$${sales.sales.toString()}')
    ];
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
