import 'dart:collection';

import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/screen/foreman/receipt/receipt_tile.dart';
import 'package:cm_mobile/screen/foreman/project/project.dart';
import 'package:cm_mobile/screen/foreman/receipt/receipt.dart';
import 'package:cm_mobile/screen/foreman/receipt/receipts_list.dart';
import 'package:flutter/material.dart';

class ReceiptsCard extends StatelessWidget{
  final List<Receipt> receipts;

  ReceiptsCard(this.receipts);


  @override
  Widget build(BuildContext context) {
    return receipts == null || receipts.isEmpty ? Column() : _ReceiptsCardRoot(receipts);
  }
}
class _ReceiptsCardRoot extends StatelessWidget {
  final List<Receipt> receipts;

  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  _ReceiptsCardRoot(this.receipts) {
    baseTextStyle = const TextStyle();
    headerStyle =
        baseTextStyle.copyWith(fontSize: 18.0);
    subheadingStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 12.0,);
  }

  @override
  Widget build(BuildContext context) {
   var topThreeReceipts = receipts.take(3).toList();

    return Card(
        shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        child:  Column(
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                      ForemanReceiptsList(receipts: receipts, appBarTitle: "Receipts",)
                  ));
                },
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new Text("Uploaded Receipts", style: headerStyle),
                        new Row(
                          children: <Widget>[
                            Text(receipts.length.toString(), style: headerStyle.copyWith(color: Colors.grey)),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                              size: 25.0,
                            ),
                          ],
                        )
                      ]),
                )
            ),
            Column(
              children: topThreeReceipts.map((receipt){
                return ReceiptTile(receipt);
              }).toList(),
            )
          ],
        )
    );
  }
}

