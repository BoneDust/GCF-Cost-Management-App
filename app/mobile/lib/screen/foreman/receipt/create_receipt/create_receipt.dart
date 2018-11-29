import 'package:flutter/material.dart';

class ForeManCreateReceiptScreen extends  StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ForeManCreateReceiptScreen(),
    );
  }
}

class _ForeManCreateReceiptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        new SliverAppBar(
          floating: true,
          expandedHeight: 300.0,
          flexibleSpace: new FlexibleSpaceBar(
              background: Image(
                image: AssetImage("assets/images.jpeg"),
                fit: BoxFit.fill,
              ),
          ),
          bottom: PreferredSize(
              child: Flexible(child:  IconButton(color: Colors.red,icon: Icon(Icons.add_a_photo) ,onPressed: (){
                Navigator.pushNamed(context, "/camera_screen");
              }),)
              , preferredSize: Size(50, 50)),
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
        TextField(
          decoration: InputDecoration(
              labelText: "Amount. Eg. 100"
          ),
        ),
        TextField(
          decoration: InputDecoration(
              labelText: "Supplier"
          ),
        ),
        TextField(
          decoration: InputDecoration(
              labelText: "Description"
          ),
        )

      ],
    );
  }
}

