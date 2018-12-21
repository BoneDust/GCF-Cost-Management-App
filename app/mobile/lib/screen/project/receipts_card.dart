import 'dart:collection';

import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/stage.dart';
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

    return Card(
        elevation: 5,
        child: Column(
          children: <Widget>[
            GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ReceiptsList(
                            receipts: receipts,
                            appBarTitle: "receipts",
                          )));
                },
                child: Container(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("receipts"),
                        Row(
                          children: <Widget>[
                            Text(receipts.length.toString()),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                              size: 25.0,
                            ),
                          ],
                        )
                      ]),
                )),
            Column(
              children: topThreeReceipts.map((receipt) {
                return ReceiptTile(receipt);
              }).toList(),
            )
          ],
        ));
  }
}
