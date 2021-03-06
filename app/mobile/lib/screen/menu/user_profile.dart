import 'package:cached_network_image/cached_network_image.dart';
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
    ThemeData themeData = Theme.of(context);

    icon = userContainerState.brightness == Brightness.dark ? Typicons.sun : Typicons.moon;
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
                  Brightness brightness;
                  if (icon == Typicons.moon){
                    icon = Typicons.sun;
                    brightness = Brightness.dark;
                  }
                  else{
                    icon = Typicons.moon;
                    brightness = Brightness.light;
                  }
                  userContainerState.setBrightness(brightness);
                },

              ),
              CircleAvatar(
                minRadius: 80,
                child:  CachedNetworkImage(
                  imageUrl: user.image,
                  placeholder:  Text("loading picture...", style: TextStyle(color: themeData.primaryTextTheme.display1.color)),
                  errorWidget:  Icon(Typicons.user_outline, size: 60, color: Colors.green,),
                  fit: BoxFit.cover,
                ),
              ),
              IconButton(
                icon: Icon(Typicons.pencil),
                onPressed: user.privilege == Privilege.ADMIN ?  (){
                  widget.parent.navigateAndDisplayEdit(context, user);
                } : null,
              ),

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



}
