import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/screen/receipt/receipts_list.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class SliverGridMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<GridItemEntry> menuEntries = getMenuEntries(context);
    return SliverPadding(
      padding: EdgeInsets.all(10.0),
      sliver: SliverGrid(
        gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 2.0,
        ),
        delegate: new SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return new GridHomeMenuItem(menuEntries[index]);
          },
          childCount: menuEntries.length,
        ),
      ),
    );
  }

  List<GridItemEntry> getMenuEntries(BuildContext context) {
    AppDataContainerState userContainerState = AppDataContainer.of(context);
    Privilege privilege = userContainerState.user.privilege;

    TabController tabController = DefaultTabController.of(context);
    List<GridItemEntry> entries = [];

                                                                                                             if (privilege == Privilege.FOREMAN)
      entries.addAll([
        GridItemEntry(
            icon: Icons.add,
            function: () {
              Navigator.pushNamed(context, '/add_receipt');
            },
            title: "Add Receipt"),
      ]);

    entries.addAll([
      GridItemEntry(
          icon: Icons.assignment,
          function: () => tabController.animateTo(1),
          title: "Projects"),
      GridItemEntry(
          icon: Icons.receipt,
          function: () => Navigator.of(context).pushNamed("/all_receipts"),
          title: "All Receipts"),
      // GridItemEntry(icon: Icons.note, function: () {}, title: "Notes"),
    ]);

    if (privilege == Privilege.ADMIN)
      entries.addAll([
        GridItemEntry(
            icon: Icons.people,
            function: () {
              Navigator.pushNamed(context, '/users');
            },
            title: "Users"),
        GridItemEntry(
            icon: Icons.trending_up, function: () {}, title: "Statistics"),
      ]);

    return entries;
  }
}

class GridItemEntry {
  final IconData icon;
  final String title;
  final Function function;

  GridItemEntry(
      {@required this.icon, @required this.title, @required this.function});
}

class GridHomeMenuItem extends StatelessWidget {
  final GridItemEntry menuItem;

  const GridHomeMenuItem(this.menuItem);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: menuItem.function,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.blue),
          height: 200,
          width: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  menuItem.icon,
                  size: 40,
                  color: Colors.white,
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  menuItem.title,
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ));
  }
}
