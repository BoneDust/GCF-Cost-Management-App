import 'package:flutter/material.dart';

class ForeManReceiptScreen extends  StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ForeManReceiptScreen(),
    );
  }
}

class _ForeManReceiptScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ForeManCreateReceiptState();
  }
}

class _ForeManCreateReceiptState extends State<_ForeManReceiptScreen> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomScrollView(
      slivers: <Widget>[
        new SliverAppBar(
          floating: true,
          expandedHeight: 300.0,
          flexibleSpace: new FlexibleSpaceBar(
            background: Image(
                image: AssetImage("assets/images.jpeg"),
              fit: BoxFit.cover,
            ) ,
          ),
        ),
        new SliverPadding(
          padding: new EdgeInsets.all(16.0),
          sliver: new SliverList(
            delegate: new SliverChildListDelegate([
              _ReceiptFields()
            ]),
          ),
        ),
      ],
    );
  }

}

class _ReceiptFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Card(
            child: ListTile(
              title: Text("R200"),
              subtitle: Text("Amount"),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: Card(
            child: ListTile(
              title: Text("Builder's warehouse"),
              subtitle: Text("Supplier"),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: Card(
            child: ListTile(
              title: Text("Brought these things where ever"),
              subtitle: Text("Description"),
            ),
          ),
        ),

      ],
    );
  }
}

