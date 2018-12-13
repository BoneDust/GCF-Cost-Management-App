import 'package:flutter/material.dart';

class AddStageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add a stage")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[_AddProjectScreen()],
      ),
    );
  }
}

class _AddProjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: ListView(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Name",
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Description"),
              ),
              ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    child: Text("Create"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
