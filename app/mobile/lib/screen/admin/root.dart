import 'package:cm_mobile/screen/admin/home/home.dart';
import 'package:cm_mobile/screen/admin/projects/projects.dart';
import 'package:cm_mobile/screen/admin/statistics/statistics.dart';
import 'package:flutter/material.dart';

class AdminRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: TabBarView(children: [
            AdminHomeScreen(),
            AdminProjectsScreen(),
            AdminStatistics()
          ]),
          bottomNavigationBar: Material(
            color: Colors.grey,
            child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.assessment)),
                Tab(icon: Icon(Icons.trending_up))
              ],
              indicatorColor: Colors.red,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.black,
            ),
          )),
    );
  }
}
