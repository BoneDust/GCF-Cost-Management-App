import 'dart:collection';

import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/model/stage.dart';
import 'package:cm_mobile/screen/foreman/project/project.dart';
import 'package:flutter/material.dart';

class ReceiptsCard extends StatelessWidget{
  List<Receipt> receipts;

  ReceiptsCard(this.receipts);


  @override
  Widget build(BuildContext context) {


    return receipts == null || receipts.isEmpty ? Column() : _ReceiptsCardRoot(receipts);
  }
}
class _ReceiptsCardRoot extends StatelessWidget {
  List<Receipt> receipts;

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
                            Text(receipts.length.toString(), style: headerStyle.copyWith(color: Colors.grey)),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                              size: 25.0,
                            ),
                          ],
                        )
                      ]),
                )),
            Container(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: receipts.length,
                padding: EdgeInsets.only(bottom: 30, top: 30),
                itemBuilder: (BuildContext context, int index) {
                  return _ReceiptsCard(receipts.elementAt(index));
                },
              ),
            )


          ],
        )
    );
  }
}

class _ReceiptsCard extends StatelessWidget {
 final Receipt receipt;

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

