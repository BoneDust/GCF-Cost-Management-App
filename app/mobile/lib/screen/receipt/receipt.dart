import 'package:cm_mobile/model/receipt.dart';
import 'package:flutter/material.dart';

class ReceiptScreen extends StatelessWidget {
  final Receipt receipt;

  ReceiptScreen(this.receipt);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            expandedHeight: 200.0,
            flexibleSpace:   FlexibleSpaceBar(
              background: Image(
                image: AssetImage("assets/images.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([_ReceiptFields(receipt)]),
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
            elevation: 5,
            child: ListTile(
              title: Text(receipt.totalCost.toString()),
              subtitle: Text("amount"),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: Card(
            elevation: 5,
            child: ListTile(
              title: Text(receipt.supplier),
              subtitle: Text("supplier"),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: Card(
            elevation: 5,
            child: ListTile(
              title: Text(receipt.description),
              subtitle: Text("description"),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: Card(
            elevation: 5,
            child: ListTile(
              title: Text(receipt.projectId.toString()),
              subtitle: Text("project"),
            ),
          ),
        ),
      ],
    );
  }
}
