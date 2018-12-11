import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/screen/receipt/receipt_tile.dart';
import 'package:flutter/material.dart';

class ReceiptsList extends StatelessWidget {
  final String appBarTitle;
  final List<Receipt> receipts;

  const ReceiptsList({
    Key key,
    @required this.appBarTitle,
    @required this.receipts
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle + "("+receipts.length.toString()+")")),
      body: _ForemanRecentReceipts(receipts: receipts),
    );
  }

}

class _ForemanRecentReceipts extends StatelessWidget {
  final List<Receipt> receipts;

  const _ForemanRecentReceipts({Key key, @required this.receipts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      shrinkWrap: true,
      children: receipts.map((receipt){
        return ReceiptTile(receipt);
      }).toList(),
    );
  }
}