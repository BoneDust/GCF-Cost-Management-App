import 'package:flutter/material.dart';

class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Testing Stats',
      theme: new ThemeData(
        primarySwatch: Colors.green[400],
      ),
      home: new StatsPage(),
    );
  }
}

class StatsPage extends StatefulWidget {
  StatsPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StatPageState();
  }
}

class StatPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[_putImage()],
      ),
    );
  }

  _putImage() {
    return new Image.asset(
      'assets/images.jpeg',
    );
  }
}
