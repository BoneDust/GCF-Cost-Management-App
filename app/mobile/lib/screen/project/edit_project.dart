import 'package:cm_mobile/model/project.dart';
import 'package:flutter/material.dart';

class EditProjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[_EditProjectScreen()],
      ),
    );
  }
}

class _EditProjectScreen extends StatelessWidget {
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
                decoration: InputDecoration(labelText: "Foreman"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Description"),
              ),
              TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: "Estimated Cost",
                ),
              ),
              TextFormField(
                maxLines: null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Team size",
                ),
              ),
              TextFormField(
                maxLines: null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "End Date",
                ),
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
