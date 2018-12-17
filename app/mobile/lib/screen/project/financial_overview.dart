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
        shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Financial Overview")]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Money spent so far " + project.estimatedCost.toString())
              ],
            )
          ],
        ));
  }
}

