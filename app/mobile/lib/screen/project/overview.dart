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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "overview",
            style: TextStyle(color: Colors.blueGrey, fontSize: 30),
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
                      "R5000", "has been spent", Colors.green),
                  _buildBoxWithText(
                      "R100000", "estimated project cost", Colors.blueGrey)
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
                  backgroundColor: Colors.blueGrey,
                  value: 0.9,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              Center(child: Text("project is within budget"))
            ],
          ),
        )
      ],
    );
  }

  Widget _buildBoxWithText(String title, String subtitle, Color color) {
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
          BoxShadow(color: Colors.white)
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
