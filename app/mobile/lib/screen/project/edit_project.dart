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
                  labelText: "name",
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "foreman"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "description"),
              ),
              TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: "estimated Cost",
                ),
              ),
              TextFormField(
                maxLines: null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "team size",
                ),
              ),
              TextFormField(
                maxLines: null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "end Date",
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    child: Text("create"),
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
