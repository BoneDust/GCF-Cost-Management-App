import 'package:cm_mobile/model/stage.dart';
import 'package:flutter/material.dart';

class StageDetails extends StatelessWidget {
  final Stage stage;

  const StageDetails({Key key,@required this.stage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          Text(stage.description, maxLines: 1,overflow: TextOverflow.ellipsis),
          Text("status: " + stage.status, maxLines: 1,overflow: TextOverflow.ellipsis),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
        ],
      ),
    );
  }
}
