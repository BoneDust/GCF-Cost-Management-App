import 'package:flutter/material.dart';
import 'base_project_card.dart';


class ProjectDetailsCard extends BaseProjectCard{
  ProjectDetailsCard() : super("Details");

  @override
  Widget setChildren() {
    return _CapturedReceiptsCard();
  }
}

class _CapturedReceiptsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(

    );
  }
}