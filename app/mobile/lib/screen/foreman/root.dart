import 'dart:collection';

import 'package:cm_mobile/model/project.dart';
import 'package:cm_mobile/screen/foreman/home/home.dart';
import 'package:cm_mobile/screen/foreman/projects/projects.dart';
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
              ForeManProjects()
            ]),
            bottomNavigationBar: Material(
              color: Colors.grey,
              child:  TabBar(tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.assessment))
              ],
                indicatorColor: Colors.red,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: Colors.black,
                labelColor: Colors.black,
              ),

            )
        ),
    );
  }
}

