import 'package:cm_mobile/model/receipt.dart';
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
      appBar: AppBar(title: Text(appBarTitle)),
      body: _ForemanRecentReceipts(),
    );
  }

}

class _ForemanRecentReceipts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        _ReceiptTile(),
        _ReceiptTile(),
        _ReceiptTile(),
        _ReceiptTile(),
        _ReceiptTile(),
        _ReceiptTile(),
        _ReceiptTile(),
        _ReceiptTile(),
        _ReceiptTile(),
        _ReceiptTile(),
        _ReceiptTile(),
        _ReceiptTile(),
        _ReceiptTile(),
        _ReceiptTile(),

      ],
    );
  }
}

class _ReceiptTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 40,
        width: 40,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage("assets/images.jpeg"),
                fit: BoxFit.cover
            )
        ),
      ),
      title: Text("9 Dec - Builder's warehouse"),
      subtitle: Text("This is a description"),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            ForeManReceiptScreen()));
      }
    );
  }


}