import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/screen/foreman/receipt/receipt_tile.dart';
import 'package:cm_mobile/screen/foreman/receipt/receipt.dart';
import 'package:flutter/material.dart';

class ForemanReceiptsList extends StatelessWidget{
  final String appBarTitle;
  final List<Receipt> receipts;

  const ForemanReceiptsList({
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