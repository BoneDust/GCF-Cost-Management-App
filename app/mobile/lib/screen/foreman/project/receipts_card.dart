import 'package:flutter/material.dart';
import 'base_project_card.dart';

class ReceiptsCard  extends BaseProjectCard{
  ReceiptsCard() : super("Uploaded Receipts");

  @override
  Widget setChildren() {
    return _ReceiptsCard();
  }
}


class _ReceiptsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(

    );
  }
}