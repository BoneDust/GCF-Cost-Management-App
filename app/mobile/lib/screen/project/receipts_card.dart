import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/screen/receipt/receipt_tile.dart';
import 'package:cm_mobile/screen/receipt/receipts_list.dart';
import 'package:flutter/material.dart';

class ReceiptsWidget extends StatelessWidget {
  final List<Receipt> receipts;

  ReceiptsWidget({this.receipts,});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "receipts(" +
                (receipts != null ? receipts.length.toString() : "0") +
                ")",
            style: TextStyle(color: themeData.primaryTextTheme.display1.color, fontSize: 30),
          ),
        ),
        _buildReceiptList(context, receipts),
      ],
    );
  }

  _buildReceiptList(BuildContext context, List<Receipt> receipts) {
    List<Widget> _children = [];
    ThemeData themeData = Theme.of(context);

    if (receipts != null) {
      _children.addAll([
        receipts.isEmpty
            ? Center(
                child: Text(
                  "no receipts yet",
                  style: TextStyle(fontSize: 20, color: themeData.primaryTextTheme.display1.color),
                ),
              )
            : Column(
                children: <Widget>[
                  Column(
                    children: receipts.take(3).map((receipt) {
                      return ReceiptTile(receipt);
                    }).toList(),
                  )
                ],
              ),
      ]);

      if (receipts.length > 3)
        _children.add(Center(
          child: FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReceiptsList(
                          receipts: receipts,
                          appBarTitle: "Receipts",
                        )));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.keyboard_arrow_down),
                  Text("more receipts")
                ],
              )),
        ));
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _children,
    );
  }
}
