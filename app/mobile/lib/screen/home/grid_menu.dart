import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/screen/client/clients_screen.dart';
import 'package:cm_mobile/screen/home/home.dart';
import 'package:cm_mobile/screen/users/users_screen.dart';
import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class SliverGridMenu extends StatelessWidget {

  final HomeState parent;

  const SliverGridMenu({Key key, @ required this.parent}) : super(key: key);

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
      delegate:  SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return  GridHomeMenuItem(menuEntries[index]);
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

    entries.addAll([
      GridItemEntry(
          icon: Typicons.doc_add,
          function: () {
            parent.navigateAndDisplayReceipt();
          },
          title: "add receipt"),
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
            function: () =>   Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => UsersScreen(title: "users",))),
            title: "users"),
        GridItemEntry(
            icon: Typicons.vcard,
            function: () =>   Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ClientsScreen(title: "clients" ))),
            title: "clients"),
        GridItemEntry(
            icon: Typicons.chart_bar_outline,
            function: () => tabController.animateTo(2),
            title: "statistics"),
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
    return Card(
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
              menuItem.title,
              style: TextStyle(
                  fontWeight: FontWeight.w700, color: Colors.blueGrey),
            )
          ],
        ),
      ),
    );
  }
}
