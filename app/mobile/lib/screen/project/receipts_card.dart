import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/screen/receipt/receipt_tile.dart';
import 'package:cm_mobile/screen/receipt/receipts_list.dart';
import 'package:flutter/material.dart';

class ReceiptsWidget extends StatelessWidget {
  final List<Receipt> receipts;

  ReceiptsWidget(this.receipts);

  @override
  Widget build(BuildContext context) {
    return receipts == null || receipts.isEmpty
        ? Column()
        : _ReceiptsWidgetRoot(receipts);
  }
}

class _ReceiptsWidgetRoot extends StatelessWidget {
  final List<Receipt> receipts;

  _ReceiptsWidgetRoot(this.receipts);

  @override
  Widget build(BuildContext context) {
    var topThreeReceipts = receipts.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "receipts(" + receipts.length.toString() +")",
            style: TextStyle(color: Colors.blueGrey, fontSize: 30),
          ),
        ),
        Column(
          children: <Widget>[
            Column(
              children: topThreeReceipts.map((receipt) {
                return ReceiptTile(receipt);
              }).toList(),
            )
          ],
        ),
       Center(child: FlatButton(onPressed:(){
         Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
             ReceiptsList(receipts: receipts, appBarTitle: "Receipts",)
         ));
       } , child:  Row(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
         Icon(Icons.keyboard_arrow_down),
         Text("more receipts")
       ],)),)
      ],
    );
  }
}
