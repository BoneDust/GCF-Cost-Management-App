import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class SliverGridMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<GridItemEntry> menuEntries = getMenuEntries(context);
    return SliverGrid(
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
            icon: Typicons.plus_outline,
            function: () {
              Navigator.pushNamed(context, '/add_receipt');
            },
            title: "add receipt"),
      ]);

    entries.addAll([
      GridItemEntry(
          icon: Typicons.clipboard,
          function: () => tabController.animateTo(1),
          title: "projects"),
      GridItemEntry(
          icon: Typicons.doc_text,
          function: () => Navigator.of(context).pushNamed("/all_receipts"),
          title: "receipts"),
      // GridItemEntry(icon: Icons.note, function: () {}, title: "Notes"),
    ]);

    if (privilege == Privilege.ADMIN)
      entries.addAll([
        GridItemEntry(
            icon: Typicons.users_outline,
            function: () {
              Navigator.pushNamed(context, '/users');
            },
            title: "users"),
        GridItemEntry(
            icon: Typicons.chart_bar_outline, function: () {}, title: "statistics"),
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
    return
      Card(
        elevation: 10,
        child: InkWell(
          onTap: menuItem.function,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                menuItem.icon,
                size: 30,
                color: Colors.blueGrey,
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text(
                menuItem.title, style: TextStyle(fontWeight: FontWeight.w700, color: Colors.blueGrey), )
            ],
          ),
        ),
      );
  }
}
