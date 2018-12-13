import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/screen/receipt/receipt.dart';
import 'package:flutter/material.dart';

class ReceiptTile extends StatelessWidget {
  final Receipt receipt;

  ReceiptTile(this.receipt);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ReceiptWidget(receipt)));
        },
        trailing: Text("2d"),
        title: Text("Payment made to " + receipt.supplier),
        subtitle: Text("Description: " + receipt.description),
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage("assets/images.jpeg"), fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
