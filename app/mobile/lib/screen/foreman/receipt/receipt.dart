import 'package:cm_mobile/model/receipt.dart';
import 'package:flutter/material.dart';

class ForeManReceiptScreen extends  StatelessWidget{
  final Receipt receipt;

  ForeManReceiptScreen(this.receipt);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: CustomScrollView(
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
          SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _ReceiptFields(receipt)
              ]),
            ),
          ),
        ],
      ),
    );
  }

}

class _ReceiptFields extends StatelessWidget {
  final Receipt receipt;

  _ReceiptFields(this.receipt);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Card(
            child: ListTile(
              title: Text(receipt.totalCost.toString()),
              subtitle: Text("Amount"),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: Card(
            child: ListTile(
              title: Text(receipt.supplier),
              subtitle: Text("Supplier"),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: Card(
            child: ListTile(
              title: Text(receipt.description),
              subtitle: Text("Description"),
            ),
          ),
        ),

      ],
    );
  }
}

