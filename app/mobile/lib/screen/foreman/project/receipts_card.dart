import 'dart:collection';

import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/screen/foreman/project/project.dart';
import 'package:flutter/material.dart';

class ReceiptsCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    HashSet<Receipt> receipts;

    return receipts == null || receipts.isEmpty ? Column() : _ReceiptsCardRoot();
  }
}
class _ReceiptsCardRoot extends StatelessWidget {

  TextStyle baseTextStyle;
  TextStyle headerStyle;
  TextStyle subheadingStyle;

  _ReceiptsCardRoot() {
    baseTextStyle = const TextStyle();
    headerStyle =
        baseTextStyle.copyWith(fontSize: 18.0);
    subheadingStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 12.0,);
  }

  @override
  Widget build(BuildContext context) {
    HashSet<Receipt> receipts;

    return Card(
        shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        child:  Column(
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/foreman/stages");
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
                            Text("4", style: headerStyle.copyWith(color: Colors.grey)),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                              size: 25.0,
                            ),
                          ],
                        )
                      ]),
                )),
            ListView.builder(
              itemCount: receipts.length,
              padding: EdgeInsets.only(bottom: 30, top: 30),
              itemBuilder: (BuildContext context, int index) {
                return _ReceiptsCard(receipts.elementAt(index));
              },
            )

          ],
        )
    );
  }
}

class _ReceiptsCard extends StatelessWidget {
  Receipt receipt;

  _ReceiptsCard(this.receipt);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Payment made to " + receipt.supplier),
      subtitle: Text("Description: " + receipt.description),
      leading: Image(
        image: AssetImage("assets/images.jpeg"),
        width: 60,
        height: 60,
      ),
    );
  }
}

