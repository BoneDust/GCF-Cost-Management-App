import 'package:flutter/material.dart';

class FailedWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
        color: Colors.blueGrey,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Could not post"),
              ButtonBar(
                children: <Widget>[
                  FlatButton(onPressed: (){}, child: Text("try again")),
                  FlatButton(onPressed: (){}, child: Text("dismiss"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}