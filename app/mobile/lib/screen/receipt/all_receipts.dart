import 'package:cm_mobile/model/receipt.dart';
import 'package:cm_mobile/screen/receipt/receipts_list.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/cupertino.dart';

class AllReceiptsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppDataContainerState userContainerState = AppDataContainer.of(context);
    List<Receipt> receipts = userContainerState.receipts;

    return ReceiptsList(
      receipts: receipts,
      appBarTitle: "all receipts",
    );
  }
}
