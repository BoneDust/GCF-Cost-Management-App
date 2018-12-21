import 'package:cm_mobile/model/project.dart';
import 'package:flutter/material.dart';

class FinancialOverviewCard extends StatelessWidget {
  final Project project;

  FinancialOverviewCard(this.project);

  @override
  Widget build(BuildContext context) {
    return project == null ? Column() : _FinancialOverviewCard(project);
  }
}

class _FinancialOverviewCard extends StatelessWidget {
  final Project project;

  _FinancialOverviewCard(this.project);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[Text("finance overview")],
          ),
        ));
  }
}
