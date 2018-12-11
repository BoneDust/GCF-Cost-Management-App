import 'package:cm_mobile/widget/receipt/receipts_list.dart';
import 'package:flutter/material.dart';

class SliverGridMenu extends StatelessWidget{

  List<GridItemEntry> menuEntries;

  @override
  Widget build(BuildContext context) {
    menuEntries = getMenuEntries(context);
    return SliverPadding(
      padding: EdgeInsets.all(10.0),
      sliver: SliverGrid(
        gridDelegate:
        new SliverGridDelegateWithMaxCrossAxisExtent(
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
    TabController tabController = DefaultTabController.of(context);
    return [
      GridItemEntry(
          icon: Icons.assignment,
          function: () => tabController.animateTo(1),
          title: "Projects"
      ),
      GridItemEntry(
          icon: Icons.receipt,
          function: () =>
            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                ReceiptsList(receipts: [], appBarTitle: "Recent Receipts",)
            ))
          ,
          title: "Recent Receipts"
      ),
      GridItemEntry(
          icon: Icons.note,
          function: (){},
          title: "Notes"
      )
    ];
  }

}
class GridItemEntry {
  final IconData icon;
  final String title;
  final Function function;

  GridItemEntry({@required this.icon, @required this.title,@required this.function});


}
class GridHomeMenuItem extends StatelessWidget{

  final GridItemEntry menuItem;

  const GridHomeMenuItem(this.menuItem);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: menuItem.function,
        child:
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue
          ),

          height: 200,
          width: 200,
          child:
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(menuItem.icon, size: 40, color: Colors.white,),
                Padding(padding: EdgeInsets.only(top: 10)),
                Text(menuItem.title, style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
        )
    );
  }
}



