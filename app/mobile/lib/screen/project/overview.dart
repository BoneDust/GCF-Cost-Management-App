import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/model/receipt.dart';
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
  int totalExpenditure = 0;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    if (project.receipts != null){
      for (Receipt receipt in project.receipts ) {
        totalExpenditure += receipt.totalCost.toInt();
      }
    }


      return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "overview",
            style: TextStyle(
                color: themeData.primaryTextTheme.display1.color, fontSize: 30),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildBoxWithText(
                      "R " + project.expenditure.toInt().toString(),
                      " has been spent",
                      Colors.green,
                      context),
                  _buildBoxWithText(
                      "R " + project.estimatedCost.toInt().toString(),
                      "estimated project cost",
                      Colors.green,
                      context),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [BoxShadow(color: Colors.grey[400])]),
                child: LinearProgressIndicator(
                  semanticsLabel: "sdfsd",
                  semanticsValue: "fsfsd",
                  backgroundColor: themeData.primaryTextTheme.display1.color,
                  value: ((totalExpenditure /project.estimatedCost) * 100) /100 ,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              Center(child: Text(totalExpenditure < project.estimatedCost ? "project is within budget" : "project over budget"))
            ],
          ),
        )
      ],
    );
  }

  Widget _buildBoxWithText(
      String title, String subtitle, Color color, BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Container(
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[400],
              spreadRadius: 1,
              offset: Offset(0.8, 0.5),
              blurRadius: 0.9),
          BoxShadow(color: themeData.primaryColor)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: color, fontWeight: FontWeight.w700, fontSize: 20),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
            ),
          )
        ],
      ),
    );
  }
}
