import 'package:cm_mobile/enums/privilege_enum.dart';
import 'package:cm_mobile/model/user.dart';
import 'package:cm_mobile/screen/menu/menu.dart';
import 'package:cm_mobile/util/image_utils.dart';
import 'package:cm_mobile/util/typicon_icons_icons.dart';
import 'package:cm_mobile/widget/app_data_provider.dart';
import 'package:flutter/material.dart';

class MenuProfileCard extends StatefulWidget{

  final MenuScreenState parent;

  MenuProfileCard({this.parent});

  @override
  State<StatefulWidget> createState() {
    return _MenuProfileCard();
  }

}
class _MenuProfileCard extends State<MenuProfileCard> {

  IconData icon = Typicons.moon;


  @override
  Widget build(BuildContext context) {
    AppDataContainerState userContainerState = AppDataContainer.of(context);
    User user = userContainerState.user;

    return user != null ? Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(icon),
                onPressed: (){
                  setState(() {
                    if (icon == Typicons.moon)
                      icon = Typicons.sun;
                    else
                      icon = Typicons.moon;
                  });
                },

              ),
              CircleAvatar(
                minRadius: 80,
              ),
              _buildRoundButton(Typicons.pencil, "edit", (){
                widget.parent.navigateAndDisplayEdit(context, user);
              }),

            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child:           Column(
              children: <Widget>[
                Text(user.name + " " + user.surname, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                Text(PrivilegeType[user.privilege])
              ],
            ),
          )
        ],
      ),
    ): Column();
  }

  Widget _buildRoundButton(IconData icon, String title, Function function) {
    return Container(
      height: 80,
      width: 80,
      child: FlatButton(onPressed: function, child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: Colors.blueGrey,),
          Padding(padding: EdgeInsets.only(top: 7),),
          Text(title)
        ],
      ), shape: CircleBorder()),
    );
  }


}
