import 'dart:collection';

import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/screen/foreman/home/home.dart';
import 'package:cm_mobile/widget/projects/projects.dart';
import 'package:flutter/material.dart';

class ForeManRoot extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 2,
        child:
        Scaffold(body: TabBarView(
            children: [
              ForeManHome(),
              ProjectsWidget()
            ]),
            bottomNavigationBar: Material(
              type: MaterialType.card,
              elevation: 20.0,
              child:  TabBar(tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.assignment))
              ],
                indicatorColor: Colors.red,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.blue,
              ),

            )
        ),
    );
  }
}

