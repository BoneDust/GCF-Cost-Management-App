import 'package:flutter/material.dart';

class AddProjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("create a project")),
      body: _AddProjectScreen(),
    );
  }
}

class _AddProjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: <Widget>[
          Card(
            elevation: 10,
            child: Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
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
                      labelText: "estimated cost",
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
                      labelText: "end date",
                    ),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      RaisedButton(
                          elevation: 10,
                          color: Colors.blueGrey,
                          child: Text("create", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17),),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          onPressed: () {
                          })
                    ],
                  )
                ],
              ),
            ),
          )
        ],
    );
  }
}
