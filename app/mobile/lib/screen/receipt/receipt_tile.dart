import 'package:cached_network_image/cached_network_image.dart';
import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/screen/receipt/receipt.dart';
import 'package:flutter/material.dart';

class ReceiptTile extends StatelessWidget {
  final Receipt receipt;

  ReceiptTile(this.receipt);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReceiptScreen(receipt)));
            },
            trailing: Text("2d"),
            title: Text("Payment made to " + receipt.supplier),
            subtitle: Text("Description: " + receipt.description, overflow: TextOverflow.ellipsis, maxLines: 1,),
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,),
              child: CachedNetworkImage(
                imageUrl: receipt.picture,
                placeholder:  Text("loading picture...", style: TextStyle(color: themeData.primaryTextTheme.display1.color)),
                errorWidget:  Image.asset("assets/images.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          )
          ,
          Divider(
            indent: 82,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
