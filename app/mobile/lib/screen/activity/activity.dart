import 'package:cm_mobile/model/activity.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  final Activity activity;

  ActivityScreen(this.activity);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity"),
      ),
    );
  }
}
