import 'package:cm_mobile/model/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Testing Stats',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new StatsPage(),
    );
  }
}

class StatsPage extends StatefulWidget {
  StatsPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StatisticsScreenState();
  }
}

class _StatisticsScreenState extends State<StatsPage> {
  double _imageHeight = 256.0;

  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();
  final GlobalKey<AnimatedCircularChartState> _chartKey2 =
      new GlobalKey<AnimatedCircularChartState>();
  final GlobalKey<AnimatedCircularChartState> _chartKey3 =
      new GlobalKey<AnimatedCircularChartState>();

  List<Project> projects = [
    new Project(
        id: 1,
        name: "WeThinkCode_JHB",
        description: "Mobile Project",
        clientId: 1,
        status: "undergoing"),
    new Project(
        id: 1,
        name: "WeThinkCode_JHB",
        description: "Mobile Project",
        clientId: 1,
        status: "undergoing"),
    new Project(
        id: 1,
        name: "WeThinkCode_JHB",
        description: "Mobile Project",
        clientId: 1,
        status: "undergoing"),
    new Project(
        id: 1,
        name: "WeThinkCode_JHB",
        description: "Mobile Project",
        clientId: 1,
        status: "undergoing"),
    new Project(
        id: 1,
        name: "WeThinkCode_JHB",
        description: "Mobile Project",
        clientId: 1,
        status: "undergoing"),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          _buildImage(),
          _buildStatRings(),
          _buildBottomPart(),
        ],
      ),
    );
  }

  _buildImage() {
    return new Image.asset(
      'assets/images.jpeg',
      fit: BoxFit.fitHeight,
      height: _imageHeight,
    );
  }

  _buildStatRings() {
    int percentage = ((20 / (20 + 55)) * 100).toInt();

    return new Padding(
      padding: new EdgeInsets.only(left: 16.0, top: _imageHeight / 2.5),
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
    );
  }

  Widget _buildBottomPart() {
    return new Padding(
      padding: new EdgeInsets.only(top: 280.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildMyTasksHeader(),
          _buildTasksList(),
        ],
      ),
    );
  }

  Widget _buildTasksList() {
    return new Expanded(
      child: new ListView(
        children: projects.map((task) => new TaskRow(project: task)).toList(),
      ),
    );
  }

  Widget _buildMyTasksHeader() {
    return new Padding(
      padding: new EdgeInsets.only(left: 64.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            'My Projects',
            style: new TextStyle(fontSize: 34.0),
          ),
          new Text(
            'FEBRUARY 8, 2015',
            style: new TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return new Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 32.0,
      child: new Container(
        width: 1.0,
        color: Colors.grey[300],
      ),
    );
  }
}

/////////////////////////////////////
class TaskRow extends StatefulWidget {
  final Project project;
  final double dotSize = 12.0;

  const TaskRow({Key key, this.project}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new TaskRowState();
  }
}

class TaskRowState extends State<TaskRow> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding:
                new EdgeInsets.symmetric(horizontal: 32.0 - widget.dotSize / 2),
            child: new Container(
              height: widget.dotSize,
              width: widget.dotSize,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle, color: Colors.green),
            ),
          ),
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  widget.project.name,
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  widget.project.description,
                  style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                )
              ],
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: new Text(
              widget.project.status,
              style: new TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
